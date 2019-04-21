# Machine learning: resampling techniques ----
# In mlr, the supported resampling strategies are:
# Cross-validation ("CV"),
# Leave-one-out cross-validation ("LOO"),
# Repeated cross-validation ("RepCV"),
# Out-of-bag bootstrap and other variants like b632 ("Bootstrap"),
# Subsampling, also called Monte-Carlo cross-validation ("Subsample"),
# Holdout (training/test) ("Holdout")

# 1. Old school way to split data ----
# PhishingWebsites Source: https://www.openml.org/d/4534
# https://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset
data <- read.csv('PhishingWebsites.csv')
str(data)

nrow(data)

sample(c('training', 'validation', 'test'), 
       size = 10, prob = c(0.5, 0.3, 0.2), 
       replace = TRUE)

set.seed(1234)
data$index <- sample(c('training', 'validation', 'test'), 
                     size = nrow(data), prob = c(0.5, 0.3, 0.2), 
                     replace = TRUE)

training_data    <- data[data$index == 'training',  ]
validation_data  <- data[data$index == 'validation',  ]
test_data        <- data[data$index == 'test',  ]

# Alternative
library(tidyverse)
training_data <- data %>% filter(index == 'training')

nrow(training_data)
nrow(validation_data)
nrow(test_data)

nrow(data)

# Remember to remove index columns in models!
data$index <- NULL

# 2. mlr methods ----
# 3-fold cross-validation
library(mlr)
rdesc <- makeResampleDesc("CV", iters = 3) 
rdesc 

## Holdout estimation 
rdesc <- makeResampleDesc("Holdout") 
rdesc 
hout 

cv3 
cv5

# Specify the resampling strategy (5-fold cross-validation) 
rdesc <- makeResampleDesc("CV", iters = 5) 

# 2 Rep 5-CV resampling
rdesc <- makeResampleDesc("RepCV", folds = 5, reps = 2) 

# Stratified Resampling
rdesc <- makeResampleDesc("RepCV", folds = 5, reps = 2, stratify = TRUE) 

# 3. Example ----
# All variables to nominal (PhishingWebsites)
data[c(1:31)] <- lapply(data[c(1:31)] , factor)
summarizeColumns(data)

# Let's check the proportion
table(data$Result)

# Configure a classification task using mlr with predict.type = 'response' ----
classif.task <- makeClassifTask(id = "web", 
                                data = data, # remember to remove index!
                                target = "Result")


r <- resample("classif.rpart", classif.task, rdesc, models = TRUE) 


names(r) 
r$aggr 
?resample

# r$measures.test gives the performance on each of the 5 test data sets in each rep. 
# r$aggr shows the aggregated performance value. 
# Its name "mmce.test.mean" indicates the performance measure, mmce, and 
# the method, test.mean, used to aggregate the 10 individual performances. 


## Subsampling with 5 iterations and default split ratio 2/3 
rdesc <- makeResampleDesc("Subsample", iters = 5) 

## Subsampling with 5 iterations and 4/5 training data 
rdesc <- makeResampleDesc("Subsample", iters = 5, split = 4/5) 

## Classification tree with information splitting criterion 
lrn <- makeLearner("classif.rpart", 
                   parms = list(split = "information"),
                   predict.type = 'prob') 

## Calculate the performance measures 
r <- resample(lrn, classif.task, rdesc, 
              measures = list(mmce, fpr, fnr, auc), 
              models = TRUE) 
r$pred 

pred <- getRRPredictions(r) 
pred 
head(as.data.frame(pred)) 
head(getPredictionTruth(pred)) 
head(getPredictionResponse(pred)) 

calculateConfusionMatrix(pred)

## Make predictions on both training and test sets 
rdesc <- makeResampleDesc("RepCV", folds = 5, 
                          reps = 2, stratify = TRUE,
                          predict = 'both') 

r <- resample("classif.rpart", classif.task, rdesc, 
              show.info = FALSE, models = TRUE) 
r 

r$measures.train 
r$measures.test

r$models 
r$models[[1]]
class(r$models[[1]])

predList <- getRRPredictionList(r) 
predList 

# Extract the variable importance 
r <- resample("classif.rpart", classif.task, rdesc, 
              show.info = FALSE, models = TRUE,
              extract = getFeatureImportance) 
r$extract 

# Use bootstrap as resampling strategy and predict on both train and test sets 
rdesc <- makeResampleDesc("Bootstrap", predict = "both", iters = 10) 
r     <- resample(lrn , classif.task, rdesc, 
                  measures = list(mmce, auc), 
                  show.info = FALSE) 
r$measures.train
r$measures.test
r$aggr

?makeResampleDesc
?repcv
