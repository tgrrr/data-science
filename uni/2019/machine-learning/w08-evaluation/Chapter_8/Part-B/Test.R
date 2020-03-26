library(mlr)
data(iris)
head(iris)

train.task <- makeClassifTask(data = iris, target = 'Species')
randomCtrl <- makeFeatSelControlSequential(method = 'sffs')
rdesc      <- makeResampleDesc("CV", iters = 3L)
sfeats <- selectFeatures(learner = "classif.randomForest", 
                         task = train.task,resampling = rdesc, 
                         control = randomCtrl,
                         show.info= FALSE)
sfeats
x <- analyzeFeatSelResult(sfeats, reduce = FALSE)


lrn   <- makeFeatSelWrapper("classif.randomForest", resampling = rdesc,
                            control = randomCtrl, 
                            show.info = TRUE)

r <- resample(learner = lrn, task = train.task, 
              resampling = rdesc  , models = TRUE,
              show.info = FALSE)

lapply(r$models, getFeatSelResult)
?selectFeatures
