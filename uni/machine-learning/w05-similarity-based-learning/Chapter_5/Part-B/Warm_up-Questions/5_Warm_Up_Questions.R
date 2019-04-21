# 1. Loading the packages ----
library(mlr)
library(tidyverse)
set.seed(999)

# 2. Data preparation ----
# Steel source: https://www.openml.org/d/1504
data <- read.csv('steels.csv')
str(data)

# All variables to nominal (data)
data[c(28:34)] <- lapply(data[c(28:34)] , factor)
summarizeColumns(data)

table(data$Class)

# 3. Modeling ----
## 3.1 Task Configuration ----
# Define the classification task
# classif.task <- makeClassifTask(id = "phish", data = data, target = "Result")
classif.task <- makeClassifTask(id = "steel", data = data, target = "Class")
classif.task

# Additional information
getTaskDesc(classif.task)
getTaskTargetNames(classif.task)
getTaskType(classif.task)
getTaskClassLevels(classif.task)
getTaskFeatureNames(classif.task)

# Extra step to remove constant feature (optional)
classif.task <- removeConstantFeatures( classif.task )
getTaskDesc(classif.task)

classif.task

## 3.2 Learner Configuration ----
# Make sure these packages have been in stalled
c('randomForest', 'rpart', 'kknn') %in% listLearners()$package

# Individual learners
rpart.lrn   <- makeLearner("classif.rpart", predict.type = 'response', fix.factors.prediction = TRUE)
rf.lrn      <- makeLearner("classif.randomForest", predict.type = 'response', fix.factors.prediction = TRUE)
kknn.lrn    <- makeLearner("classif.kknn", predict.type = 'response', fix.factors.prediction = TRUE)

rpart.lrn
rf.lrn 
kknn.lrn

# Multiple learners
learners <- makeLearners(c('randomForest', 'rpart', 'kknn'), type = "classif", predict.type = "prob")
learners

## 3.3 Traininng rpart ----
## basic trainned model
rpart.mod <- train(rpart.lrn , classif.task)
rpart.mod

tree <- getLearnerModel(rpart.mod)
tree

library(rpart.plot)
rpart.plot( tree )

## 3.4 Training multiple learners (for illustration) ----
model <- train(learners, classif.task) # not working
model <- train(learners$classif.randomForest, classif.task)


## 3.5 Getting from rpart to randomForest ----
## Next, we use makeBaggingWrapper to create the 
## base learners and the bagged learner. 
## We choose to set equivalents of ntree (100 base learners) 
## and mtry (proportion of randomly selected features).
wrapped.lrn <- makeBaggingWrapper(rpart.lrn, bw.iters = 100, bw.feats = 0.5)
print(wrapped.lrn)

# We can use this newly constructed learner like all base learners, 
# i.e. we can use it in train, benchmark, resample, etc with some exception
wrappedRpart.mod <- train(wrapped.lrn , classif.task)
wrappedRpart.mod

wrappedTree <- getLearnerModel(wrapped.lrn) # not working

benchmark(tasks =  classif.task, learners = list(rpart.lrn, wrapped.lrn))


# But we hope for a better performance by 
# tuning some hyperparameters of both the decision trees and bagging wrapper. 
# Let's have a look at the available hyperparameters of the fused learner:
getParamSet(wrapped.lrn)


# We choose to tune the parameters minsplit 
# and bw.feats for the mmce using a random search in a 3-fold CV:

ctrl  <- makeTuneControlRandom(maxit = 5)
rdesc <- makeResampleDesc("CV", iters = 5)
par.set = makeParamSet(
  makeIntegerParam("minsplit", lower = 2, upper = 10),
  makeNumericParam("bw.feats", lower = 0.35, upper = 1)
)
tuned.lrn <- makeTuneWrapper(wrapped.lrn, rdesc, mmce, par.set, ctrl)
print(tuned.lrn)

tunedBaggedTreeMod <- train(tuned.lrn, task = classif.task)

pred <- predict(tunedBaggedTreeMod, newdata = data)
performance(pred)


## 3.6 randomForest (optional, left as exercise)----
rf.mod <- train(rf.lrn , classif.task)
rf.mod

## 3.7 kknn ----
kknn.mod <- train(kknn.lrn, classif.task)
kknn.mod 

## 3.8  Benchmarking----
# How does randomforest fare?
benchmark(tasks =  classif.task, 
          learners = list(rf.lrn, tuned.lrn, wrapped.lrn, rpart.lrn, kknn.lrn))

## 3.9 Percentage of task's data used
# This cannot be applied on wrapped and tuned learners
lrnCurve <- generateLearningCurveData(task =  classif.task, learners = list(rf.lrn, rpart.lrn, kknn.lrn))
head(lrnCurve$data)

ggplot(lrnCurve$data, aes(x = percentage, y = mmce, color = learner)) + 
  geom_point() + geom_line() + 
  labs(x = 'Percentage of data used %', 
       y = 'MMCE')

