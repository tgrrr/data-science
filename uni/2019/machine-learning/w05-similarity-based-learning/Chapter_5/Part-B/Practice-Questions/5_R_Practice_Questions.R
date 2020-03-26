# 0. Loading the packages ----
library(mlr)
library(tidyverse) # for ggplot and data wrangly
set.seed(999)      # set a random seed

# Note: the following script provide the solution to basic questions only.
# There is no solution to challenging questions because they are meant
# to be challenging!
# 
# Question 1: Read the data set and convert the descritpive features to nominal if necessary -----
# PhishingWebsites Source: https://www.openml.org/d/4534
data <- read.csv('PhishingWebsites.csv')
str(data)

# All variables to nominal (PhishingWebsites)
data[c(1:31)] <- lapply(data[c(1:31)] , factor)
summarizeColumns(data)

# Let's check the proportion
table(data$Result)

# Question 2. Configure a classification task using mlr with predict.type = 'response' ----
classif.task <- makeClassifTask(id = "steel", data = data, target = "Result")
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

# Question 3. Configure at least three classification learners including `randomForest`, `rpart`, and `kknn` ----
# Make sure these packages have been in stalled
c('randomForest', 'rpart', 'kknn') %in% listLearners()$package

# Individual learners
rpart.lrn   <- makeLearner("classif.rpart", predict.type = 'response', fix.factors.prediction = TRUE)
rf.lrn      <- makeLearner("classif.randomForest", predict.type = 'response', fix.factors.prediction = TRUE)
kknn.lrn    <- makeLearner("classif.kknn", predict.type = 'response', fix.factors.prediction = TRUE)

rpart.lrn
rf.lrn 
kknn.lrn


# Question 4. Train the models ----
# rpart 
rpart.mod <- train(rpart.lrn , classif.task)
rpart.mod

## randomForest
rf.mod <- train(rf.lrn , classif.task)
rf.mod

## kknn
kknn.mod <- train(kknn.lrn, classif.task)
kknn.mod 


# Question 5. Prune the `rpart` learner if necessary ----
# Define parameters of cp which governs the pruning parameter
# say, we can start with 0 (no pruning) and increase by 0.002 to 0.0005
ps <- makeParamSet(
  makeDiscreteParam("cp", values = seq(0, 0.002, 0.0005)) 
)

# Define parameters                         
ctrl   <- makeTuneControlRandom(maxit = 5)
rdesc  <- makeResampleDesc("CV", iters = 4L)     # 4-CV resampling
pruned <- tuneParams(rpart.lrn, classif.task, 
                     par.set = ps, 
                     control = makeTuneControlGrid() ,
                     resampling = rdesc)                    


# the best cp is 5e-04

# Question 6. Fine-tune hyperparameter of the pruned `rpart` model. ----
# Let's fine-tune the pruned learner by
# 1. control the cp
# 2. minsplit from 2 to 10
# 3. max depth ranging 20 to 50
ps2 <- makeParamSet(
  makeDiscreteParam("cp", values = seq(0, 0.002, 0.0005)),
  makeIntegerParam("minsplit", lower = 2, upper = 10),
  makeDiscreteParam("maxdepth", values = c(20, 30, 40, 50))
)

pruned.lrn <- makeTuneWrapper(rpart.lrn, rdesc, mmce, ps2, ctrl)
print(pruned.lrn)

# Train the model with the pruned and tuned rpart learner
prunedRpart.mod <- train(pruned.lrn , classif.task)
prunedRpart.mod 

# Question 7. Fine-tune hyperparameter of other learners -----
# For knnn learner
ps3 <- makeParamSet(
  makeIntegerParam("k", lower = 2, upper = 10),                   # the number of hyperparameter
  makeDiscreteParam("kernel", values = c("rectangular","optimal")) # kernel types
  
)

# We shall use the same rdesc, mmce, ctrl for consistency
tuned.kknn.Lrn <- makeTuneWrapper(kknn.lrn, rdesc, mmce, ps3, ctrl)
print(tuned.kknn.Lrn)

# Train the model
tunedKknn.mod <- train(tuned.kknn.Lrn , classif.task)
tunedKknn.mod

# For Random Forest
ps4 <- makeParamSet(
  makeDiscreteParam("ntree", values = c(100, 200, 300, 400, 500)) # number of trees to grow
)

# We shall use the same rdesc, mmce, ctrl for consistency
tuned.rf.Lrn <- makeTuneWrapper(rf.lrn, rdesc, mmce, ps4, ctrl)
print(tuned.rf.Lrn )

# Train the model
tunedRF.mod <- train(tuned.rf.Lrn , classif.task)
tunedRF.mod 

# Question 8. Benchmarking ----
# Note the benchmarking will take very long time
benchmark(tasks =  classif.task, 
          learners = list(tuned.rf.Lrn, tuned.kknn.Lrn, pruned.lrn))
