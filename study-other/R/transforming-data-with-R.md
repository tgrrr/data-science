# Transforming data with R

## Useful Functions
```r
BoxCox() # from forecast library(forecast)
scale()
discretize() # from infotheo library(infotheo)

minmaxnormalise <- function(x){(x- min(x)) /(max(x)-min(x))} # write it yourself

```

## Maths functions

| --- | --- | --- |
| --- | --- | --- |
| Transformation | Power	R | function |
| --- | --- | --- |
| logarithm base 10 | NA | `log10(y)` |
| logarithm base e | NA | `log(y)` |
| reciprocal square | -2 | `y^(-2)` |
| reciprocal | -1 | `y^(-1)` |
| cube root | 1/3 | `y^(1/3)` |
| square root | 1/2 | `y^(1/2) or sqrt()` |
| square | 2 | `y^2` |
| cube | 3 | `y^3` |
| fourth power | 4 | `y^4` |

## Normalisation technique

```r
# Centering
scale(y, center = TRUE, scale = FALSE)

# Scaling (using RMS)
scale(y, center = FALSE, scale = TRUE)

# Scaling (using SD)
scale(y, center = FALSE, scale = sd(y))

# z-score transformation
scale(y, center = TRUE, scale = TRUE)

# Min-max transformation
(y- min(y)) /(max(y)-min(y))

```

Note: See slides for maths formulas

Binning strategy (from infotheo)

```r
# Equal width (distance) binning
discretize(y, disc = "equalwidth")
# Equal depth (frequency) binning
discretize(y, disc = "equalfreq", )
```
