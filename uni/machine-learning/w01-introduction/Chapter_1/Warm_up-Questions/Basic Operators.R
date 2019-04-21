# variable assignments ----
x <- 1
x
x <- "Machine is not learning"
x
exists('x')
exists(x)

# Operators
x <- c(1, 2, 3, NA)
y <- 2
z <- c(-1, -2, -4)
x + y
z + x
z - x
x - z 
2*x

x == z 
x == -z
na.omit(x) == -z
all(na.omit(x) == -z)
any(na.omit(x) == -z)

x[1:2]
x[-1]
x[c(4, 1)]

# Data Structures ----
# Array
myarray <- array( c(1:12), dim = c(3,4) )
myarray 

myarray[, 1]
myarray[2, ]
myarray[2, 2]

secondarray <- array( c(1:12), dim = c(3,2,2) )
secondarray 

# Matrix
mymatrix <- matrix(1:16, ncol = 2)
mymatrix

mymatrix[, 1]
mymatrix[1, ]

# List

mylist <- list(mymatrix, "hello")
mylist

mylist[[1]]
mylist[[2]]

mylist <- list(matrix = mymatrix, greeting = "hello")
mylist$matrix 
mylist$greeting

# a list in a list
mylist <- list(matrix = mymatrix, greeting = "hello", mylist)
mylist

# Data table vs data frame



# Class
# from character to factor
# factor vs as.factor
# NaN, NA, NULL, Inf


# Formula and model


# Table

# Getting help


# Libraries vs packages
# creating projects
getOption('defaultPackages')
(.packages())
(.packages(all.available = TRUE))
library()


# Expression
x <- 1:5
x

`[<-`(x, 4, 'duck')

`<-`(apples, 3)
apples

`->`(4, oranges) # does not work
`+`(4, 5)

`if`(4 > 5, 'hello R', 'goodbye R')

# typeof and class
x <- seq(1, 5, by = 10)
typeof(x)
class(x)
?raw
as.raw(x)
as.raw(1)
?AsIs
I(x)
y <- 'hello world'
I(y)
`<-`
typeof(quote(if (x > 1) "orange" else "apple"))
quote(if (x > 1) "orange" else "apple")
as( quote(if (x > 1) "orange" else "apple"), 'list') 

lapply( as( quote(if (x > 1) "orange" else "apple"), 'list'), typeof)

0xFFFF
(2^2018 + 1) == 2^2018
