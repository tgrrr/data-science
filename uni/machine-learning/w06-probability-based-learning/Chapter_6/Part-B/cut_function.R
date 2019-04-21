x <- rnorm(50, 10, 2)
x
cut(x, breaks = 3)
?cut
library(arules)
discretize(x, method = 'interval')
discretize(x, method = 'frequency')
discretize(x, method = 'cluster')
