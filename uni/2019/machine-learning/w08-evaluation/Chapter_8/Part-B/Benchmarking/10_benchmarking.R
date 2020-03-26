library(mlr)
library(ggplot2)

# Classification problems ----
data          <- read.csv('PhishingWebsites.csv')
data[c(1:31)] <- lapply(data[c(1:31)] , factor)
classif.task <- makeClassifTask(id = "web", 
                                data = data,
                                target = "Result")

lrns <- list(
  makeLearner("classif.kknn", id = "kknn", predict.type = 'prob'), 
  makeLearner("classif.naiveBayes", id = "NB", predict.type = 'prob'), 
  makeLearner("classif.randomForest", id = "randomForest", predict.type = 'prob')
)

rdesc   <- makeResampleDesc("CV", iters = 5, stratify = TRUE)
measure <-  list(mmce, tpr, fnr)
bmr     <- benchmark(lrns, classif.task, rdesc, measure)

perf    <- getBMRPerformances(bmr, as.df = TRUE)
perf

pred <- getBMRPredictions(bmr)

performance(pred$web$kknn)
performance(pred$web$NB)
performance(pred$web$randomForest)

calculateConfusionMatrix( pred$web$kknn )
calculateConfusionMatrix( pred$web$NB )
calculateConfusionMatrix( pred$web$randomForest )

getBMRMeasures(bmr)


plotBMRBoxplots(bmr, measure = mmce)
plotBMRBoxplots(bmr, measure = fnr)
plotBMRBoxplots(bmr, measure = tpr)


plotBMRBoxplots(bmr, measure = mmce) + ggplot2::ylim(0, 1)
plotBMRBoxplots(bmr, measure = fnr) + ggplot2::ylim(0, 1)
plotBMRBoxplots(bmr, measure = tpr) + ggplot2::ylim(0, 1)

# Multi-Classification problems ----
bmr2     <- benchmark(lrns, list(classif.task, sonar.task), rdesc, measure)

plotBMRBoxplots(bmr2, measure = mmce)
plotBMRBoxplots(bmr2, measure = fnr)
plotBMRBoxplots(bmr2, measure = tpr)


# In our example, we want to compare the three learners on the selected data sets. 
# First we might we want to test the hypothesis whether there is a difference between the learners.
# This often means many data sets are needed in order to be able to show significant differences 
# at reasonable significance levels.
friedmanTestBMR(bmr2)

g <- generateCritDifferencesData(bmr2, p.value = 0.1, test = "nemenyi")
plotCritDifferences(g) + coord_cartesian(xlim = c(-1,5), ylim = c(0,2))

# Learners that are not connected by a bar are significantly different, 
# and the learner(s) with the lower mean rank can be considered "better" at the chosen significance level.

# Regression benchmarking ----
library(MASS)
data("Boston")
regTask <- makeRegrTask(data = Boston, target = 'medv')

regLrns <- list(
  makeLearner("regr.lm", id = "lm"),
  makeLearner("regr.randomForest"),
  makeLearner("regr.featureless")
  
)
rdesc   <- makeResampleDesc("CV", iters = 5)
measure <- list(mse, rmse)
bmr     <- benchmark(regLrns, regTask, rdesc, measure)


plotBMRBoxplots(bmr)
plotBMRBoxplots(bmr, measure = rmse)

df <- getBMRPerformances(bmr, as.df = TRUE)
df

library(reshape2)
library(tidyverse)

df2 <- melt(df %>% select(-task.id, -iter))
df2

# Bad example: not recommended as rmse and mse have different units
ggplot(df2, aes(x = learner.id, y = value)) + 
  geom_boxplot() + facet_grid(variable~.)
