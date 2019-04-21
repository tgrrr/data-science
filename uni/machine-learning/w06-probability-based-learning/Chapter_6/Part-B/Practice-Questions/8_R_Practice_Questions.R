
# Question 1. Loading Library and data preparation ----
library(mlr)
library(tidyverse)

# Read the data
# Source: http://archive.ics.uci.edu/ml/datasets/banknote+authentication
# Note that the dataset has no header. So, we need to set header to FALSE
data    <- read.csv('data_banknote_authentication.txt', header = FALSE)

# We need to rename the columns. From the source, we know that
# 1. variance of Wavelet Transformed image (continuous) 
# 2. skewness of Wavelet Transformed image (continuous) 
# 3. curtosis of Wavelet Transformed image (continuous) 
# 4. entropy of image (continuous) 
# 5. class (integer) 

# Column 5 is type of banknote. It is the target feature which we need to predict
# If class = 1, then it is a counterfeit
# Otherwise, it is a genuine

colnames(data) # Without renaming, R will define it with "V1", "V2",.. and so on
colnames(data) <- c('var', 'skew', 'curt', 'ent', 'class')

# Let's summarise it
summarizeColumns(data)
data
# We need to column class to factor
data$class <- factor(data$class)

# Check if class is a factor variable and make sure it has only 2 levels
# i.e. nlevs = 2
summarizeColumns(data)

table(data$class)

# Question 2. Configure a classification task using mlr ----
classif.task <- makeClassifTask(id = "banknote", 
                                data = data, 
                                target = "class",
                                positive = '1')
classif.task

# Get some additional information to make sure
# we feed makeClassifTask with the correct information
getTaskClassLevels(classif.task)
getTaskFeatureNames(classif.task)

# Question 2. Configure naiveBayes learner----
# Find out which library required by mlr to run Naive Bayes
listLearners() %>% 
  filter(class == "classif.naiveBayes") %>% 
  select(class, name, package, installed)

# Create a naive Bayes learner with predict.type = 'prob
learner1 <- makeLearner(cl = "classif.naiveBayes", predict.type = "prob")


# Question 3. Train and evaluate the model without resampling----
mod1  <- train( learner1, classif.task) # train
pred1 <- predict(mod1, newdata  = data) # predict on full data

performance(pred1)                      # mean misclassification rate

# Question 4. calculate confusion matrix ----
calculateConfusionMatrix(pred1)       

# What's misclassification error by the type of banknote
calculateConfusionMatrix(pred1, relative = TRUE) 

# 21 % error rate, which is not perfect
# Is it due to the equal threshold?
pred1$threshold

# 50 % seems to be a high to classify a note to be counterfeit 
# We need to lower it. 

# Question 5. Laplace smoothing ----
# Laplace smoothing does not work for continuous features. This is because the role
# of Laplace smoothing is to mitigate the issue where the training data does not
# capture instances not observed. This works only for for categorical features with 
# a finite number of values whereas numeric features could take infinite set of values
# 
# To verify this, we can run the Laplace smoothing. Keep it mind that
# it will be futile. However, let's run as if it would work!
# 
# Let's see there is other parameter of Naive Bayes classifier
# It has only one paramater which is Laplace
getParamSet("classif.naiveBayes")

# Let's create the parameter controls via makeParamSet
# where laplace ranges from 0 to 50
ps <- makeParamSet(
  makeNumericParam('laplace', lower = 0, upper = 50)

)

# We need to create a control object
ctrl  <- makeTuneControlGrid()

# We need to do a 3-folded CV-resampling. 
# There is no rule for number of folds. Since the data is relatively small,
# we can afford to do more resampling. However, resampling too much
# might lead to estimation issues. 3 to 4 should be fine.
# 
# Stratification is optional as the imbalance between genuine and counterfeit 
# is not severe. 
rdesc <- makeResampleDesc("CV", iters = 3L, stratify = TRUE)

# Set a random seeds
set.seed(123)

# Let's run the parameters
res <- tuneParams("classif.naiveBayes", 
                  task = classif.task, 
                  resampling = rdesc,
                  par.set = ps, 
                  control = ctrl)

# Display the result
res

# As expected, the Laplace smoothing is zero
# Let's vindicate by visualising it by
# scrapping the full result from res
psdata <- generateHyperParsEffectData(res)

# call plotHyperParsEffect to visualise it
plotHyperParsEffect(psdata, x = "laplace", 
                    y = "mmce.test.mean",
                    plot.type = "line")

# Indeed, the test mean error does not change along all Laplace parameters

# Questions 6 and 7. Train the model with the 3-CV resampling ----
# Re-use "rdesc" we configured before. 
resampledModel <- resample(learner1, classif.task, rdesc)

# Extract the predictions from resampledModel
pred2 <- getRRPredictions(resampledModel)
performance(pred2 )

# Question 8. Adjusting threshold ----
# After resampling, the error rate is still quite high, especially
# for the counterfeit notes. To find the optimal threshold,
# run the following

d <- generateThreshVsPerfData(pred2, measures = list(mmce))

# The threshold can be obtain as follow
# which.min(d$data$mmce) returns which row that corresponds to
# the lowest error rate. Using this row, we can retrieve
# the threshold in d$data$threshold[ ]

optimal_threshold <- d$data$threshold[ which.min(d$data$mmce) ]
optimal_threshold 
# the optimal threshold is around 0.3

# Let's visualise it
plotThreshVsPerf(d) + 
  geom_hline(yintercept = performance(pred2), color = 'red', linetype = 'dashed') +
  geom_hline(yintercept = min(d$data$mmce), color = 'blue', linetype = 'dashed')

# The red line represents the error rate before adjusting threshold
# The blue line represents the error rate after adjusting threshold

pred3 <- setThreshold(pred2, optimal_threshold)
calculateConfusionMatrix( pred3, relative = TRUE )

# Final remark: we manage to reduce the error rate for counterfeit notes substantially
