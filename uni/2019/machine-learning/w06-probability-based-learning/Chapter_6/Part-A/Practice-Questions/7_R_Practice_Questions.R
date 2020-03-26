#' Machine Learning: Feature selection with mlr
#' @author Yong Kai Wong
# Question 0: Loading the packages ----
library(mlr)
library(tidyverse) # for ggplot and data wrangly

options("java.home"="/Library/Java/JavaVirtualMachines/jdk-9.0.4.jdk/Contents/Home/lib")
Sys.setenv(LD_LIBRARY_PATH='$JAVA_HOME/server')
dyn.load('/Library/Java/JavaVirtualMachines/jdk-9.0.4.jdk/Contents/Home/lib/server/libjvm.dylib')
library(rJava)
library(FSelector) 
set.seed(999)      # set a random seed

# Question 1: Data Preparation and co----
# Source: https://archive.ics.uci.edu/ml/datasets/Airfoil+Self-Noise

# This problem has the following features: 
# 1. Frequency, in Hertzs. 
# 2. Angle of attack, in degrees. 
# 3. Chord length, in meters. 
# 4. Free-stream velocity, in meters per second. 
# 5. Suction side displacement thickness, in meters. 
# 
# The target feature is: 
# 6. Scaled sound pressure level, in decibels

airfoil        <- read.csv('airfoil_self_noise.dat.txt', sep = '', header = FALSE) # note that data has no header
regressionTask <- makeRegrTask(id = 'airfoil', data = airfoil, target = 'V6')
regressionTask 

# Question 2: Generate and plot the feature importance using three filter methods. -----
mFV <- generateFilterValuesData(regressionTask, 
                                method = c('randomForest.importance', 
                                           'information.gain',
                                           'chi.squared'))
plotFilterValues(mFV) 

# Using three methods, V1 (Frequnency) is most important consistently.
# V4 (Free-stream velocity) is least important consistently.

# Question 3: Fuse a learner with a filtered method and fine-tune the percentage of features and resampling ----

# get a list of regression learners
Regressionlrns <- listLearners() 
Regressionlrns  %>% filter( type == 'regr') %>% select(class, package)

# We shall use regr.randomForest with 'randomForestSRC.rfsrc'
lrn_rfsrc <-  makeFilterWrapper(learner = "regr.randomForest",  fw.method = 'randomForestSRC.rfsrc')
lrn_rfsrc

ps    <-  makeParamSet(makeDiscreteParam("fw.abs", values = seq(1:5)))
rdesc <-  makeResampleDesc("CV", iters = 3)
res   <-  tuneParams(lrn_rfsrc, 
                     task = regressionTask, 
                     resampling = rdesc, 
                     par.set = ps, 
                     control = makeTuneControlGrid())

# The optimal number of feature is 3
as.data.frame(res$opt.path)

# Question 4: Train the regression model with the fused learner. ----
fusedLrn <- makeFilterWrapper(learner = "regr.randomForest", 
                              fw.method = "randomForestSRC.rfsrc", 
                              fw.abs = res$x$fw.abs)

mod      <- train(fusedLrn, regressionTask)
mod

# the best features are:
getFilteredFeatures(mod)

# Question 5: Using the same regression task, fuse a learner with forward selection wrapper method.  ----
sfsCtrl <- makeFeatSelControlSequential(method = "sfs", alpha = 0.005)
lrn     <- makeFeatSelWrapper("regr.randomForest", resampling = rdesc,
                              control = sfsCtrl, show.info = TRUE)

# Question 6: Train the fused learner with the wrapped method from Question 5.  -----
mod     <-  train(lrn, task = regressionTask)
mod

# Question 7: Analyzing trainned model  -----
sfeats <- getFeatSelResult(mod)
analyzeFeatSelResult(sfeats)

# Qeustions 8 and 9: Remark ----
# The model fused with the filter method results in MSE of 9.988907 whereas
# the model fused with the forward selection wrapper method result in MSE of 8.6892.
# In addition, the filtered value plot shows that the optimal feature subset is {V1, V3, and V5}
# This contrast with the the wrapper method which yields {V1, V5, and V2}.
