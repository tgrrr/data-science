# 0. Preliminaries ----
library(mlbench) # obtain Sonar Data
library(mlr)     # load mlr package

data(Sonar)      # read Sonar data fron mlbench; case-sensitive
head(Sonar)      # head and tail
tail(Sonar)
summary(Sonar)
unique(Sonar$Class)

# 1. Classification Task ----
classif.task <- makeClassifTask(id = "sonar", data = Sonar, target = "Class")

# 2. rpart (decision-tree) learner ----
classif.lrn <- makeLearner("classif.rpart", predict.type = "prob", fix.factors.prediction = TRUE)

# 3. Train the model ----
mod <- train(classif.lrn, classif.task)

# 4. Visualise the tree ----
tree <- getLearnerModel(mod)

library(rpart.plot)
rpart.plot( tree )

# 5. Prediction with the full data set ----
pred <- predict(mod, newdata = Sonar)

# 6. Evaluation ----
performance(pred, measure = mmce)

# 7. Optimal threshold ----
d <- generateThreshVsPerfData(pred, measures = mmce)
plotThreshVsPerf(d)

# Optimal threshold = 50 to 75 %

# 8. 2-fold resampling ----
set.seed(1234)
rdesc1 <- makeResampleDesc("CV", iters = 2, predict = 'both')
r1     <- resample("classif.rpart", classif.task, rdesc1)

r1$aggr

# 9. 3-fold resampling ----
set.seed(1234)
rdesc2 <- makeResampleDesc("CV", iters = 3, predict = 'both')
r2     <- resample("classif.rpart", classif.task, rdesc2)

r2$aggr

# When random seed is set at 1234, increase in fold might not necessarily improve the accuracy
