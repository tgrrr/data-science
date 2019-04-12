# R shorthand


| Syntax | Evaluate as |
| --- | --- |
| x %>>% f | f(x) |
| x %>>% f(...) | f(x,...) |

The syntax of first argument piping is that, on the right-hand side of %>>%, whenever a function name or call is supplied, the left-hand side value will always be put to the first unnamed argument to that function.

## Piping

In v. 1.5 there are two options:

`list(x = rnorm(100), y = runif(100)) %$% cor(x, y) `
Which is essemtially the same as

`list(x = rnorm(100), y = runif(100)) %>% with(cor(x, y))` # you could also do this earlier
Or

`list(x = rnorm(100), y = runif(100)) %>% { cor(.$x, .$y) } `
The { pair creates a lambda (unary function) on the fly so you don't have to do the whole (function(x) { ... }) thing.

source: https://stackoverflow.com/questions/25958627/how-to-use-magrittr-piping-with-multi-argument-functions


## pipeR:
```r
set.seed(123)
rnorm(100) %>>% cor(runif(100))  ## see double >> format
# [1] 0.05564807
```
## margrittr:
```r
set.seed(123)
rnorm(100) %>% cor(y = runif(100))
# [1] 0.05564807
```
