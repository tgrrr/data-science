Load and execute R file

# Turn your r functions into components

```r
# utils.R file
multiply <- function(x, y) {
    x*y
}
```

Import and run it:

```r
#component.R file

# import
source("utils.R", print.eval=TRUE) # Print isn't implicit

# run
multiply(-4:4, 2)
```

## Spread operator

```r
plt <- function(n, ...)
+ plot(1:n, ...)


par(mfrow = c(1, 2))
plt(5, pch = 19, type = "b")
plt(10, col = rbramp(10), pch = 15)
```

## Functions to generate functions

```r
make.power <- function(n)
+ function(x) x^n

square <- make.power(2)
cube <- make.power(3)
```


## Debugging:

```r
try_catch(log("a"),
  .e = function(e){
    print(paste0("There is an error: ", e))
    print("Ok, let's save this")
    time <- Sys.time()
    a <- paste("+ At",time, ", \nError:",e)
    write(a, "log.txt", append = TRUE) # comment this to prevent log.txt creation
    print(paste("log saved on log.txt at", time))
    print("let's move on now")
  })
```

- `expr` - the expression to be evaluated
- `.e` - a mapper or a function evaluated when an error occurs
- `.w` - a mapper or a function evaluated when a warning occurs
- `.f` - a mapper or an expression which is always evaluated before returning or exiting

```r
library(attempt)
attempt(log("a"), msg = "Nop !", verbose = TRUE)
# returns if true

```

`traceback()` - print the call stack of the last call error

figure out it's from `faultyFunction`

```r
debug(faultyFunction)

# here we step through the function with
undebug(faultyFunction)
fix(faultyFunction)
```

Create breakpoints:

```r

if (dim(matrix)[2] != length(vector)) {
        stop("Can't multiply matrix%*%vector because the dimensions are wrong")
    }
```


`trace()` to insert code into functions
`options(error=recover)`

source:

https://www.bioconductor.org/help/course-materials/2013/CSAMA2013/friday/afternoon/R-programming.pdf

https://gist.github.com/mollietaylor/4472146
https://stackoverflow.com/questions/15797522/load-and-execute-r-source-file
https://cran.r-project.org/web/packages/attempt/vignettes/b_try_catch.html
