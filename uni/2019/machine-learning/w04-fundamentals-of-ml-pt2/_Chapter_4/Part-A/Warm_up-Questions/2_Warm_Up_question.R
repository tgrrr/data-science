adult <- read.csv('adult.csv', header = TRUE)
library(mlr)
summarizeColumns( adult )
colnames( adult)

# Data Processing ----
adult$capital <- adult$capital.gain - adult$capital.loss
adult$capital.gain <- NULL
adult$capital.loss <- NULL

boxplot(adult$capital)

classif.task <- makeClassifTask(id = "income", data = adult, target = "income")
classif.task

classif.task <- makeClassifTask(id = "income", data = adult, target = "income", positive = '>50K')
classif.task

getTaskDesc(classif.task)
getTaskTargetNames(classif.task)
getTaskType(classif.task)
getTaskClassLevels(classif.task)
getTaskFeatureNames(classif.task)

classif.task <- removeConstantFeatures( classif.task )

classif.task <- dropFeatures( classif.task, c("native.country"))
getTaskDesc(classif.task)

classif.task

lrns <- listLearners()
head( lrns[c("class", "package")])

'rpart' %in% listLearners()$package

classif.lrn <- makeLearner("classif.rpart", predict.type = "prob", fix.factors.prediction = TRUE)
classif.lrn
classif.lrn$predict.type


mod <- train(classif.lrn, classif.task)
mod

tree <- getLearnerModel(mod)
tree

library(rpart.plot)
rpart.plot( tree )

pred <- predict(mod, newdata = adult)
head( getPredictionProbabilities(pred) )

listMeasures( classif.task)
getDefaultMeasure( classif.task)

performance(pred)
performance(pred, measure = list(f1, mmce, auc))

calculateConfusionMatrix(pred)
calculateConfusionMatrix(pred, relative = TRUE, sums = TRUE)

pred$threshold

pred2 <- setThreshold(pred, 0.25)
pred2$threshold

performance(pred2)
performance(pred2, measure = list(f1, mmce, auc))

calculateConfusionMatrix(pred2 )
plotLearnerPrediction( classif.lrn, task = classif.task, features = 'education.num' )

d <- generateThreshVsPerfData(pred, measures = list(mmce, f1))
plotThreshVsPerf(d)


# Cross-validation ("CV")
# Leave-one-out cross-validation ("LOO"")
# Repeated cross-validation ("RepCV"),
# Out-of-bag bootstrap and other variants ("Bootstrap"),
# Subsampling, also called Monte-Carlo cross-validaton ("Subsample"), 
# Holdout (training/test) ("Holdout")

?makeResampleDesc

set.seed(123)

rdesc <- makeResampleDesc("CV", iters = 3, predict = 'both')
r     <- resample("classif.rpart", classif.task, rdesc)
r     <- resample("classif.rpart", classif.task, rdesc, models = TRUE)

r$models
r$aggr
r$measures.test
r$measures.train

rdesc <- makeResampleDesc("CV", iters = 3, predict = 'both', stratify = TRUE)
r     <- resample("classif.rpart", classif.task, rdesc)
r     <- resample("classif.rpart", classif.task, rdesc, models = TRUE)

r$models
r$aggr
r$measures.test
r$measures.train
