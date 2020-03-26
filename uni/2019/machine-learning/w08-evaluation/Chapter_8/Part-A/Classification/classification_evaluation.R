#' How to evaluate a classification problem using ionosphere data?

library('kknn')
library(mlr)
data("ionosphere")

str(ionosphere)
?ionosphere

# Preliminaries
classifTask  <- makeClassifTask(data = ionosphere, target = 'class')
learner1     <- makeLearner("classif.rpart", predict.type = "prob") 
learner2     <- makeLearner("classif.kknn",  predict.type = "prob",  k = 3) 

mod1         <- train(learner1, task = classifTask )
mod2         <- train(learner2, task = classifTask )

pred1 <- predict(mod1, classifTask)   # regress model
pred2 <- predict(mod2, classifTask)   # knn model

# What measures available?
listMeasures( classifTask )


# Evaluation
performance(pred1)
performance(pred2)

performance(pred1, measures = list(tp, tn, fp, fn) )
performance(pred1, measures = list(f1, tpr, tnr, fpr, fnr) )

r <- calculateROCMeasures(pred1)
r

# Confusion matrix

calculateConfusionMatrix(pred1)
confusionMatrix <- calculateConfusionMatrix(pred, relative = TRUE)
confusionMatrix
confusionMatrix$relative.row
confusionMatrix$relative.col
calculateConfusionMatrix(pred1, relative = TRUE, sums = TRUE)

pred1$threshold

calculateConfusionMatrix(pred1)

# ROC and threshold performance with one learner
d <- generateThreshVsPerfData(pred1, measures = list(fpr, tpr, mmce))
plotThreshVsPerf(d)
plotROCCurves(d)

# ROC and threshold performance with two learners
d <- generateThreshVsPerfData(list(rpart = pred1, kknn = pred2),
                              measures = list(fpr, tpr))
plotROCCurves(d)
