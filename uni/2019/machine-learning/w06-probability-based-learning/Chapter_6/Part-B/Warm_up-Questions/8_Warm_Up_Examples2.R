# 1. Loading Library and data preparation ----
library(mlr)
library(tidyverse)
data    <- read.csv('Table6-2.csv', skip = 1)
data$ID <- NULL
data <- sapply(data, function(x){ trimws(sub("\t", '', x)) }) 
data <- data.frame(data)
str(data)
write.csv(data, 'Table6-2_cleaned.csv')

data %>% filter(History == 'paid', 
                CoApplicant == 'guarantor', 
                Accommodation == 'false')

# 2. Configure a classification task using mlr ----
classif.task <- makeClassifTask(id = "fraud", 
                                data = data, 
                                target = "Fraud",
                                positive = 'true')
classif.task

# Additional information
getTaskDesc(classif.task)
getTaskTargetNames(classif.task)
getTaskType(classif.task)
getTaskClassLevels(classif.task)
getTaskFeatureNames(classif.task)

# 3. Configure naiveBayes ----
listLearners() %>% 
  filter(class == "classif.naiveBayes") %>% 
  select(class, name, package, installed)

learner1 <- makeLearner(cl = "classif.naiveBayes", predict.type = "prob")

# 4. Train and evaluate the model ----
mod1  <- train( learner1, classif.task)

pred1 <- predict(mod1, newdata  = data)

performance(pred1)

calculateConfusionMatrix(pred1)
calculateConfusionMatrix(pred2)

pred1$threshold

# 5. Why Smoothing ----
test_data <- data.frame(History = 'paid', 
                        CoApplicant = 'guarantor', 
                        Accommodation = 'false')
str(data)

predict(mod1, newdata  = test_data)
predict(mod2, newdata  = test_data)

# 6. Laplace smoothing ----
getParamSet("classif.naiveBayes")
ps <- makeParamSet(
  
  makeDiscreteParam('laplace', values = c(0, 0.1, 0.5, 2, 3, 5, 10, 20))
  
)
print(ps)

# optional: makeNumericParam
ctrl  <- makeTuneControlGrid()
rdesc <- makeResampleDesc("CV", iters = 2L, stratify = TRUE)

performance(pred1)
table(data$Fraud)

set.seed(124)
res <- tuneParams("classif.naiveBayes", 
                   task = classif.task, 
                   resampling = rdesc,
                   par.set = ps, 
                   control = ctrl)
res
mmce$minimize
res$x
res$y

generateHyperParsEffectData(res)


psdata <- generateHyperParsEffectData(res)

plotHyperParsEffect(psdata, x = "iteration", 
                    y = "mmce.test.mean",
                    plot.type = "line")

plotHyperParsEffect(psdata, x = "laplace", 
                    y = "mmce.test.mean",
                    plot.type = "line")

# 7. Train a Laplace smoothed model ----
classif.task

tunedLearner1 <- makeTuneWrapper(learner1, rdesc, mmce, ps, ctrl)

tunedMod1  <- train(tunedLearner1, classif.task)

tunedPred1 <- predict(tunedMod1, newdata  = data)


performance(tunedPred1)
performance(tunedPred2)

performance(pred1)
performance(pred2)

calculateConfusionMatrix(tunedPred1)
test_data
predict(tunedMod1, newdata  = test_data)
predict(tunedMod2, newdata  = test_data)

tunedPred1$threshold

d <- generateThreshVsPerfData(tunedPred1, 
                              measures = list(mmce))
plotThreshVsPerf(d)
plotThreshVsPerf(d) + 
  geom_hline(yintercept = 0.3, color = 'red', linetype = 'dashed')


tunedPred3 <- setThreshold(tunedPred1, 0.3)
calculateConfusionMatrix(tunedPred3 )
performance( tunedPred3 )
predict(tunedMod1, newdata  = test_data)

setThreshold(predict(tunedMod1, newdata  = test_data), 0.3)
