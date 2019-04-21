#' How to evaluate a regression problem using BostonHousing data?

# 1. Load libraries and the dataset from MASS package ----
library(MASS)
library(mlr)
data("Boston")
summarizeColumns(Boston)

# The regression problem is to predict medv, the median value of owner-occupied homes in USD
# Therefore, medv is the target features
# Let's configure the regression task and two regression learners:
# 1. linear regression
# 2. knn learner

regrTask  <- makeRegrTask(data = Boston, target = 'medv')
learner1  <- makeLearner('regr.lm')   # linear regression
learner2  <- makeLearner('regr.kknn')  # kknn

# Train model for each learner
mod1  <- train(learner1, regrTask) # linear regression model
mod2  <- train(learner2, regrTask) # knn model

# 2. Performance measures ----
# Let's check what performance measures are available for regression task
listMeasures(regrTask)

# There are so many measures. Some are interpretable. For exampple,
# "rsq" means r-squared and "mse" means mean squared error. How about 
# "kendalltau" and "expvar"?
# 
# So, how can we access their information? Use str!
str(rsq)

# It returns the properties of "rsq". The key properties are:
# 1. minimize: where a lower value is better
# 2. best: the best value to represent the best performance
# 3. worst: the worst value to represent the worst performance
# 4. name: the name of measure
# 5. note: extra description of measure

# Let's predict on full data set and evaluate the performance on each model
pred1 <- predict(mod1, regrTask)   # linear regression model
pred2 <- predict(mod2, regrTask)   # knn model

# Alternative: pred <- predict(mod1, newdata = Boston)

# Default performance is mse (mean squared error)
# Squared-error-type measures
performance(pred1, measures = list(sse, mse, rmse))
performance(pred2, measures = list(sse, mse, rmse))

# other measures
performance(pred1, measures = list(rsq, mae))
performance(pred2, measures = list(rsq, mae))

# what if we assign an object as `rsq`
rsq <- 123
performance(pred1, measures = list(rsq))
# mlr will complain

# To solve it, remove it via rm
rm(rsq)
performance(pred1, measures = list(rsq))
