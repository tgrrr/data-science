# 1. Preliminaries ----
library(mlr)
library(tidyverse)

rm(list = ls())
data <- read.csv('cleaned_adult.csv')

# Remove the granular features
data <- data %>% 
  select(-workclass, -education, -marital_status, -native_country, -occupation)
str(data)
table(data$income)

# Set a common random seed for reproducibility
set.seed(1234)

# Old school way to spliting the data into 70 % training & 30 % test data
# This is not stratified sampling, which shall be used in model training
# obtain index for training and test indices
training_index <- sample(nrow(data)*0.70)
test_index     <- setdiff(seq(1:nrow(data)), training_index )

# Get the training data and test data
training_data  <- data[training_index, ]
test_data      <- data[test_index, ]

# Check the proportion of income in each dataset
prop.table(table(training_data$income))
prop.table(table(test_data$income))

# They are quite balanced and representative of the full dataset
# We shall use training data for modeling
# and test data for model evaluation

# 2. Modeling ----
# 2.1. Basic configuration ----
# Configure classification task
task <- makeClassifTask(data = training_data, target = 'income', id = 'adult')

# Configure learners with probability type
learner1 <- makeLearner('classif.naiveBayes', predict.type = 'prob')    # baseline learner
learner2 <- makeLearner('classif.randomForest', predict.type = 'prob')
learner3 <- makeLearner('classif.kknn', predict.type = 'prob')

# 2.2 Model fine-tuning ----
# Obtain parameters available for fine-tuning
getParamSet(learner1)
getParamSet(learner2)
getParamSet(learner3)

# For naiveBayes, we can fine-tune Laplacian
ps1 <- makeParamSet(
  makeNumericParam('laplace', lower = 0, upper = 30)
)

# For randomForest, we can fine-tune mtry i.e mumber of variables randomly 
# sampled as candidates at each split. Following
# Breiman, L. (2001), Random Forests, Machine Learning 45(1), 5-32,
# we can try mtry = 2, 3, 4 as mtry = sqrt(p) where p = 11
ps2 <- makeParamSet(
  makeDiscreteParam('mtry', values = c(2,3,4))
)


# For kknn, we can fine-tune k = 2 to 20 
ps3 <- makeParamSet(
  makeDiscreteParam('k', values = seq(2, 20, by = 1))
)

# Configure tune control search and a 5-CV stratified sampling
ctrl  <- makeTuneControlGrid()
rdesc <- makeResampleDesc("CV", iters = 5L, stratify = TRUE)

# Configure tune wrapper with tune-tuning settings
tunedLearner1 <- makeTuneWrapper(learner1, rdesc, mmce, ps1, ctrl)
tunedLearner2 <- makeTuneWrapper(learner2, rdesc, mmce, ps2, ctrl)
tunedLearner3 <- makeTuneWrapper(learner3, rdesc, mmce, ps3, ctrl)

# Train the tune wrappers
tunedMod1  <- train(tunedLearner1, task)
tunedMod2  <- train(tunedLearner2, task)
tunedMod3  <- train(tunedLearner3, task)

# Predict on training data
tunedPred1 <- predict(tunedMod1, task)
tunedPred2 <- predict(tunedMod2, task)
tunedPred3 <- predict(tunedMod3, task)

# 2.3 Obtain threshold values for each learner ----
d1 <- generateThreshVsPerfData(tunedPred1, measures = list(mmce))
d2 <- generateThreshVsPerfData(tunedPred2, measures = list(mmce))
d3 <- generateThreshVsPerfData(tunedPred3, measures = list(mmce))

plotThreshVsPerf(d1) + labs(title = 'Threshold Adjustment for Naive Bayes', x = 'Threshold')
plotThreshVsPerf(d2) + labs(title = 'Threshold Adjustment for Random Forest', x = 'Threshold')
plotThreshVsPerf(d3) + labs(title = 'Threshold Adjustment for 20-KNN', x = 'Threshold')

# Get threshold for each learner
threshold1 <- d1$data$threshold[ which.min(d1$data$mmce) ]
threshold2 <- d2$data$threshold[ which.min(d2$data$mmce) ]
threshold3 <- d3$data$threshold[ which.min(d3$data$mmce) ]

# 3. Evaluation on test data ----
# we shall use tuned wrapper models and optimal thresholds from previous sections
testPred1 <- predict(tunedMod1, newdata = test_data)
testPred2 <- predict(tunedMod2, newdata = test_data)
testPred3 <- predict(tunedMod3, newdata = test_data)

testPred1 <- setThreshold(testPred1, threshold1 )
testPred2 <- setThreshold(testPred2, threshold2 )
testPred3 <- setThreshold(testPred3, threshold3 )

?calculateConfusionMatrix
calculateConfusionMatrix( testPred1,relative = TRUE)
performance( testPred1 )

calculateConfusionMatrix( testPred2,relative = TRUE)
performance( testPred2 )

calculateConfusionMatrix( testPred3,relative = TRUE)
performance( testPred3 )

