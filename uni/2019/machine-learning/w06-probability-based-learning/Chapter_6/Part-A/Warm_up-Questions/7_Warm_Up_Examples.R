#' Machine Learning: Feature selection
#' @author Yong Kai Wong
# 0. Loading the packages ----
library(mlr)
library(tidyverse) # for ggplot and data wrangly
library(ggvis)     # ggplot visualisation in shiny app

options("java.home"="/Library/Java/JavaVirtualMachines/jdk-9.0.4.jdk/Contents/Home/lib")
Sys.setenv(LD_LIBRARY_PATH='$JAVA_HOME/server')
dyn.load('/Library/Java/JavaVirtualMachines/jdk-9.0.4.jdk/Contents/Home/lib/server/libjvm.dylib')
library(rJava)
library(FSelector) 
set.seed(999)      # set a random seed

# 1. Data Preparation ----
# PhishingWebsites Source: https://www.openml.org/d/4534
# https://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset
data <- read.csv('PhishingWebsites.csv')
str(data)

# All variables to nominal (PhishingWebsites)
data[c(1:31)] <- lapply(data[c(1:31)] , factor)
summarizeColumns(data)

# Let's check the proportion
table(data$Result)

# 2. Configure a classification task using mlr with predict.type = 'response' ----
classif.task <- makeClassifTask(id = "web", data = data, target = "Result")
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

# 3. Filter methods ----
# Filter methods assign an importance value to each feature. 
# Based on these values the features can be ranked and a feature subset can be selected.
# the default method is randomForest.rfsrc. Other methods include
# 'information.gain', 'relief'
# Note: not all methods applied to "classif" such as rank.correlation

fv <- generateFilterValuesData(classif.task)
plotFilterValues(fv) 
plotFilterValues(fv) + coord_flip()

# ggvis (optional)
# plotFilterValuesGGVIS(fv)

# multiple Filter Values
mFV <- generateFilterValuesData(classif.task, 
                                method = c('randomForest.importance', 
                                           'information.gain',
                                           'chi.squared'))
plotFilterValues(mFV) 

# 4. Selecting a feature subset ----
# With mlr’s function filterFeatures you can create a new Task by 
# leaving out features of lower importance.
# There are several ways to select a feature subset based on feature importance values:
# 1. Keep a certain absolute number (abs) of features with highest importance. 
# 2. Keep a certain percentage (perc) of features with highest importance.
# 3. Keep all features whose importance exceeds a certain threshold value (threshold).

filteredTask1 <- filterFeatures(classif.task, abs = 5)               # Keep the 5 most important features
filteredTask2 <- filterFeatures(classif.task, fval = fv, perc = 0.4) # Keep 40 % most important features
filteredTask3 <- filterFeatures(classif.task, fval = fv, threshold = 0.025)

classif.task
filteredTask1
filteredTask2 
filteredTask3 

# Fuse a learner with a filter method and train the model.
# Often feature selection based on a filter method is part of 
# the data preprocessing and in a subsequent step a learning method is applied to the filtered data

lrn   <- makeFilterWrapper(learner = "classif.kknn", fw.method = "chi.squared")
ps    <-  makeParamSet(makeDiscreteParam("fw.perc", values = seq(0.2, 0.5, 0.05)))
rdesc <-  makeResampleDesc("CV", iters = 3)
res   <-  tuneParams(lrn, task = classif.task, resampling = rdesc, par.set = ps, control = makeTuneControlGrid())

as.data.frame(res$opt.path)

# The optimal percentage and the corresponding performance can be accessed as follows:
res$x
res$y

# Fuse it with fw percentage
fusedLrn <- makeFilterWrapper(learner = "classif.kknn", fw.method = "chi.squared", fw.perc = res$x$fw.perc)
mod      <- train(fusedLrn, classif.task)
mod

getFilteredFeatures(mod)


library(emoa)
res <- tuneParamsMultiCrit(lrn, task = classif.task, resampling = rdesc, par.set = ps,
                           measures = list(fpr, mmce), 
                           control = makeTuneMultiCritControlRandom(maxit = 10L),
                           show.info = FALSE)

plotTuneMultiCritResult(res)


# 5. Wrapper methods ----

# Wrapper method provided by mlr:
# Exhaustive search (makeFeatSelControlExhaustive),
# Genetic algorithm (makeFeatSelControlGA),
# Random search (makeFeatSelControlRandom),
# Deterministic forward or backward search (makeFeatSelControlSequential).

# Let's try control random
randomCtrl <- makeFeatSelControlRandom(maxit = 10L)
randomCtrl

rdesc  <-  makeResampleDesc("CV", iters = 3)
sfeats <-  selectFeatures(learner = "classif.kknn", task = classif.task, 
                          resampling = rdesc, control = randomCtrl, show.info = TRUE)

sfeats
sfeats$x
sfeats$y

# Let's try control makeFeatSelControlSequential
sfsCtrl <- makeFeatSelControlSequential(method = "sfs", alpha = 0.005)
lrn     <- makeFeatSelWrapper("classif.kknn", resampling = rdesc,
                              control = sfsCtrl, show.info = FALSE)
mod     <-  train(lrn, task = classif.task)
mod

sfeats <- getFeatSelResult(mod)
sfeats$x
analyzeFeatSelResult(sfeats)
