library(mlr)
library(tidyverse)

# Question 5 ----
Exams <- data.frame( id    = c(1:20),
                     score = c(42, 47, 59, 27, 84, 49, 72, 43, 73, 59,
                               58, 82, 50, 79, 89, 75, 70, 59, 67, 35))


normalizeFeatures(Exams, method = 'range', cols = 'score', range = c(0, 1))
normalizeFeatures(Exams, method = 'range', cols = 'score', range = c(-1, 1))

Exams       <- normalizeFeatures(Exams, method = 'standardize', cols = 'score')
Exams$score <- c( scale(Exams$score) )

?normalizeFeatures
?mad

# Question 6 ----
quiz <- data.frame( id    = c(1:20),
                    score = c(92,  107,  83, 101, 107,  92,  99, 119,  93, 106,
                              105,  88, 106,  90,  97, 118, 120,  72, 100, 104))
quiz
ggplot(quiz, aes(x = score) ) + geom_histogram(bins = 5)

equalFreq <- data.frame(table( cut_number(quiz$score, n = 5) ))
ggplot( equalFreq, aes(x = Var1, y = Freq)) + 
  geom_bar(stat = 'identity') + 
  labs(x = 'score', y = 'Count')

par(mfrow = c(2,1))
hist(quiz$score, xlab = 'score', main = 'Histogram of Score', breaks = 'Sturges')
hist(quiz$score, xlab = 'score', main = 'Histogram of Score', breaks = 'fd')
par(mfrow = c(1,1))

data(iris)
head(iris)

task <- makeClassifTask(data = iris, target = 'Species')
task
h0  <- makeResampleInstance('Holdout', task)
h0

train <- subsetTask( task, subset = h0$train.inds[[1]])
test  <- subsetTask( task, subset = h0$test.inds[[1]])
test
train

iris[h0$train.inds[[1]], ]
