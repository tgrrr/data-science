# 7 - Transform TODO
### Data Transformation, Standardisation, and Reduction

#### Dr. Anil Dolgun
#### Last updated: 15 June, 2018

TODOLATER: add histograms
TODOLATER: add math images to box cox

<aside class="notice">
  <strong>tl;dr</strong>
  <ul>
    <li>
      To reduce right skewness in the distribution, taking roots or logarithms or reciprocals work well.
    </li>
    <li>
      To reduce left skewness, taking squares or cubes or higher powers work well.
    </li>
  </ul>

TODOLATER:
  The most useful data transformation functions are:
  - the logarithm (`base 10` and `base e`) reciprocal
  - cube root
  - square root
  - square

  ## Learning Objectives
  - Apply well-known transformations
  - Apply normalisation and standardisation
  - Learn commonly used approaches for data discretisation
  - Apply different variable selection, ranking and feature extraction techniques for data reduction

</aside>

Data transformation is perhaps the most important step in the data preprocessing for the development and deployment of statistical analysis and machine learning models. In almost all statistical and machine learning analyses, it is necessary to perform some data transformations (i.e., data transformation, scaling, centering, standardisation and normalisation) on the raw (but tidy and clean!) data before it can be used for modelling.

In this module, we focus on the most common and useful data transformations that can be easily implemented in R. The number of possible data transformations is indeed large and the selection of proper and useful transformations would definitely depend on the context of the data and the type of the statistical analysis. This is why specific types of analyses may require specific types of transformations. As you move forward in your master’s program, you will learn the details of these specific transformations used in different data analysis subjects (i.e., Introduction to Statistics, Machine Learning, Analysis of Categorical Data, Time Series Analysis, Forecasting and Applied Bayesian Analysis courses, etc.). Our aim in this course is not to give technical details of these transformations, but you may refer to the “Additional Resources and Further Reading” section to find out more on the topic.


# Data Transformation

Data transformation is often a requisite to further proceed with statistical analysis. Below are the situations where we might need transformations:

### Why?

- **Understanding** - We may need to change the **scale** of a variable or **standardise the values** of a variable for better understanding.
- Get **Linear relationships** - We may need to transform complex non-linear relationships into linear relationships. Transformation helps us to convert a non-linear relation into linear one.

### Why? Normal distribution

- **Normal distribution** In statistical inference, symmetric (normal) distribution is preferred over skewed distribution.
- For **Statistical Analysis** Also, some statistical analysis techniques (i.e., `parametric tests`, `linear regression`, etc) requires normal distribution of variables and homogeneity of variances.
- Reduce the **skewness**
- Reduce **heterogeneity of variances**

So, whenever we have a skewed distribution and/or heterogeneous of variances, we can use transformations which can reduce skewness and/or heterogeneity of variances.

### Data Transformation via Mathematical Operations

TODOLATER: turn this into a summary card with links

Often, mathematical operations are applied to the data to achieve `normality` and/or `variance homogeneity`. Such transformations through mathematical operations like:

- logarithmic (i.e., ln and log),
- square root,
- power transformations
- etc.

can easily be done in R using arithmetic functions.

The most useful transformations in introductory data analysis are:

- the logarithm (`base 10` and `base e`) reciprocal
- cube root
- square root
- square

## Log transformation

**The Log transformation** (`base 10 - log10` or `base e - loge`) compresses high values and spreads low values by expressing the values as orders of magnitude. This transformation is commonly used for reducing right skewness. It can not be applied to zero or negative values directly. In order to apply the log transformation to a zero or negative value, we can add a non-negative constant to all observations and then take the logarithm.

Let’s have a look at the hypothetical data on the salaries data ( `salary.csv` ).

TODOLATER: Add histogram of salary$salary

From the histogram, we observe that salaries have a right-skewed distribution. By applying a logarithmic transformation, the salary distribution would be more symmetrical.
We can apply the logarithmic transformation (`base 10`) using the `log10()` function in R as follows:


```r
log_salary <- log10(salary$salary)

hist(log_salary)
```

TODOLATER: Add histogram of log_salary


### `log()` and `ln()` natural logarithm transformation
Another logarithmic transformation is the natural logarithm (often called ln or log<sub>e</sub>). This transformation can be easily done using the `log()` function in R.

For the salaries data, we can also apply the `ln` transformation as follows:

```r
ln_salary <- log10(salary$salary)

hist(ln_salary)
```

TODOLATER: Add histogram of ln_salary

As seen from the histograms, the `log10` transformation worked slightly better than the `ln` transformation for this example.

Usually, analysts apply different transformations on the same data and then select the one that works well or is useful.

## `sqrt()` - square root transformation
Another transformation is the square root transformation. It is also used for reducing right skewness, and also has the advantage that it can be applied to zero values. In R, the function `sqrt()` will apply the square root transformation. Let’s apply the square root transformation and see the effect of this transformation on the salary distribution:

```r
sqrt_salary <- sqrt(salary$salary)
hist(sqrt_salary)
```

TODOLATER: Add histogram of sqrt_salary

The square root transformation has reduced the skewness in the salary distribution a bit, however it didn’t

## `x^2` square transformation

The **square transformation** has a moderate effect on distribution shape and it can be used to reduce left skewness. It spreads out the high values relative to the smaller values. In R, the mathematical operation x^2 would apply the square transformation.
To illustrate the square transformation, let’s read in `left_skewed1.csv` and have a look at the shape of the distribution using histogram:


```r
x1<- read.csv("data/left_skewed1.csv")

x1<-x1[,-1] # dropping the first column

hist(x1)
```

This distribution is left skewed, we can try and see the effect of square transformation on the distribution using the following:


```r
xsquare1 <- x1^2

hist(xsquare1)
```

TODOLATER: Add histogram of xsquare1


As seen above, the square transformation was not helpful at all to get a symmetrical distribution for this data set. Now, let’s look at another example data left_skewed2.csv having less skewed distribution:


```r
x2<- read.csv("data/left_skewed2.csv")

x2<-x2[,-1] # dropping the first column

hist(x2)
```

TODOLATER: Add histogram of x2

Let’s apply square transformation to x2 and see the effect:


```r
x2square <- x2^2

hist(x2square)
```

TODOLATER: Add histogram of x2square


As seen in the last histogram, square transformation was able to transform the shape of the distribution into a more symmetric one when the distribution is mildly left skewed.

## reciprocal transformation
The **reciprocal transformation** is a very strong transformation with a drastic effect on the distribution shape. It will compress large values to smaller values. The mathematical operation `1/x` or `x^(-1)` would apply the reciprocal transformation.

Let’s apply the reciprocal transformation to the x3 variable in the right_skewed1.csv data and see its drastic effect on the shape of the distribution:


```r
x3<- read.csv("data/right_skewed1.csv")

x3<-x3[,-1] # dropping the first column

hist(x3)

x3recip <- 1/x3

hist(x3recip)
```

TODOLATER: Add histogram of x3recip


As seen above, reciprocal transformation worked very well in this case.

## Power transformation

The main transformations mentioned previously, with the exception of the logarithm, are all powers. Therefore, these transformations are also called as power transformations. Here is the list of power transformations:

TODOLATER:

| Transformation | Power |
| --- | --- |
| reciprocal | square	-2 |
| reciprocal | -1 |
| (  yields one) | 0 |
| cube | root	1/3 |
| square | root	1/2 |
| identity | 1 |
| square | 2 |
| cube | 3 |
| fourth | power	4 |
|  |  |
There are also some recommendations on useful transformations for specific types of distributions. For example:

<aside class="notice">
  <strong>tl;dr</strong>
  <ul>
    <li>
      To reduce right skewness in the distribution, taking roots or logarithms or reciprocals work well.
    </li>
    <li>
      To reduce left skewness, taking squares or cubes or higher powers work well.
    </li>
  </ul>
</aside>

Note that these are general recommendations on mathematical transformations and may not work for every data set. Usually, the best approach is to apply different transformations on the same data and select the one that works best.

## Box-Cox Transformation
Normal distribution assumption is very crucial for many statistical hypothesis tests especially for the parametric hypothesis testing, linear regression, time series analysis, etc. The Box-Cox transformation is a type of power transformation to transform non-normal data into a normal distribution. This transformation is named after statisticians George Box and Sir David Cox who collaborated on a 1964 paper and developed the technique (Box and Cox (1964)).
Let y denote the variable at the original scale and y′ the transformed variable. The Box-Cox transformation is defined as:
`y′={yλ−1λ,if λ≠0log(y),if λ=0`

If the data include any negative observations, a shifting parameter λ2 can be included in the Box-Cox transformation as given by:
`y′={(y+λ2)λ−1λ,if λ≠0log(y+λ2),if λ=0`

As seen in the equations, the λ parameter is very important for applying this transformation. Essentially, finding a good λ parameter satisfying the normality assumption is also a hard task and can be done by a search algorithm or the maximum likelihood estimation.
There are many powerful packages that can be used to apply the Box-Cox transformation. Among them the

- `caret`
- `MASS`
- `forecast`
- `geoR`
- `EnvStats`
- `AIS`

 packages are only some of them. In this module, I will introduce the forecast package, as this package has very useful functions to find the best `λ` parameter for the Box-Cox transformation.


```r
library(forecast)
BoxCox(salary$salary,lambda = "auto")
##   [1] 0.9854516 0.9843098 0.9880776 0.9836914 0.9839247 0.9884059 0.9851253
## and soforth
##  [99] 0.9843304 0.9868072
## attr(,"lambda")
## [1] -0.9999242
```

This function returns the transformed data values. From this output the optimum λ value is found as `-0.9999242`. We can also see the distribution of transformed values using histogram.
`hist(boxcox_salary)`

```r
x3<- read.csv("data/right_skewed1.csv")

x3<-x3[,-1] # dropping the first column

hist(x3)

boxcox_x3<- BoxCox(x3,lambda = "auto")

hist(boxcox_x3)
```

Transforms skewed distributions into a symmetric distribution.

# Data Normalisation
Some statistical analysis methods are sensitive to the scale of the variables and there can be instances found in data sets where values for one variable could range between 1-10 and values for other variable could range from 1-10000000. In scenarios like these, the impact on response variables by the variables having greater numeric range (i.e., 1-10000000), could be more than the one having less numeric range (i.e. 1-10).

Especially for the distance based methods in machine learning, this could in turn impact the prediction accuracy. For such cases, we may need to normalise or scale the values under different variables such that they fall under common range.

There are different normalisation techniques used in machine learning. These are centering using mean, scaling using

- `standard deviation`
- `z-score transformation`
  - (i.e. **centering and scaling** using both `mean` and `standard deviation`)
- `min-max`
- `range`
- `(0-1) transformation`

## Mean-centering and scaling
**Centering (a.k.a. mean-centering)** involves the subtraction of the variable average from the data.
Let y denote the variable at the original scale and the y¯ is the average. The centered variable y‘ is defined as:

TODOLATER:
`y′=y−y¯`

If we have more than one variable to center, we can calculate the average value of each variable and then subtract it from the data. This implies that each column will be transformed in such a way that the resulting variable will have a **zero mean**.

## `scale()`

We can use simple user-defined functions or built-in functions available in R to center variables. One of the functions to apply mean-centering is the `scale()` function under Base R.

The `scale()` function has the following arguments:

| if center = | TRUE | FALSE |
| --- | --- | --- |
|  | column values - column means | no centering |
| Scaling = TRUE | Divided by columns `standard deviation` | Divided by `root-mean-squared` |
| Scaling = FALSE | no scaling | no scaling |


- `x:` a numeric object
- `center:` if TRUE, the objects’ column means are subtracted from the values in those columns (ignoring NAs); if FALSE, centering is not performed.
- `scale:`
  - if `TRUE`, the centered column values are divided by the column’s standard deviation (when center is also TRUE) or
  - divided by the root-mean-square (when center is FALSE).
  If scale = FALSE, scaling is not performed.

```r
df <- data.frame(x1 = c(10, 20, 40, 50, 10),
                 x2 = c(1000, 5000, 3000, 2000, 1500),
                 x3 = c(0.1, 0.12, 0.11, 0.14, 0.16),
                 x4 = c(2.5, 4.2, 3.2, 4.5, 3.8) )
```

## `scale()` - Mean Centering => standard deviation

> To apply **mean-centering**:

```r
center_x <-scale(df, center = TRUE, scale = FALSE)

center_x
##       x1    x2     x3    x4
## [1,] -16 -1500 -0.026 -1.14
## [2,]  -6  2500 -0.006  0.56
## [3,]  14   500 -0.016 -0.44
## [4,]  24  -500  0.014  0.86
## [5,] -16 -1000  0.034  0.16
## attr(,"scaled:center")
##       x1       x2       x3       x4
##   26.000 2500.000    0.126    3.640
```

In the output, the new centered values for each column are given along with the column (variables’) averages.

Scaling involves the division of the values to its **standard deviation** (or **root-mean-square** value).
Let y denote the variable at the original scale and the SDy is the standard deviation. The scaled variable y‘ is defined as:
`y′=ySDy`


## `Scale()` => column root-mean-square values

### How: without centering => root-mean-square



In order to apply just scaling (without centering) to the data frame we can use `center = FALSE` and `scale = TRUE` arguments as follows:

> scaled with the **column** `root-mean-square` values

```r
  scale(df,
    center = FALSE,
    scale = TRUE)

##           x1        x2        x3        x4
## [1,] 0.29173 0.3113996 0.6997114 0.6027159
## [2,] 0.58346 1.5569979 0.8396537 1.0125628
## [3,] 1.16692 0.9341987 0.7696826 0.7714764
## [4,] 1.45865 0.6227992 0.9795960 1.0848887
## [5,] 0.29173 0.4670994 1.1195383 0.9161282
## attr(,"scaled:scale")
##           x1           x2           x3           x4
##   34.2782730 3211.3081447    0.1429161    4.1478910
```


Note that, when we scale values without centering, the `scale()` function divides the values to the root-mean-square value instead of standard deviation. Therefore, in this output the new scaled variables are actually **scaled with the column root-mean-square values**.

## `scale()` by standard deviation without centering (and gets columns standard deviation)

If we want to scale by the standard deviations without centering, we can use the following:


```r
scale(
  df,
  center = FALSE,
  scale =
    apply(
      df,
      2,
      sd,
      na.rm = TRUE))
##             x1        x2       x3       x4
## [1,] 0.5504819 0.6324555 4.152274 3.117701
## [2,] 1.1009638 3.1622777 4.982729 5.237738
## [3,] 2.2019275 1.8973666 4.567501 3.990658
## [4,] 2.7524094 1.2649111 5.813184 5.611863
## [5,] 0.5504819 0.9486833 6.643638 4.738906
## attr(,"scaled:scale")
##           x1           x2           x3           x4
## 1.816590e+01 1.581139e+03 2.408319e-02 8.018728e-01
```

The output above now reports the scaled values (by standard deviation) along with the column standard deviations.
Usually, scaling is not used alone, instead, it is used together with mean-centering and then it is called as the `z-score` standardisation.

## z score standardisation

- transformed data values have a zero mean and one standard deviation.

`z=y−y¯SDy`
The mean of observations are first subtracted from each individual data point, then divided by the standard deviation of all points.
In the equation below, y denotes the values of observations, y¯ and SDy are the sample mean and standard deviation, respectively.

```r
scale(df, center = TRUE, scale = TRUE)

##              x1         x2         x3         x4
## [1,] -0.8807710 -0.9486833 -1.0795912 -1.4216719
## [2,] -0.3302891  1.5811388 -0.2491364  0.6983651
## [3,]  0.7706746  0.3162278 -0.6643638 -0.5487155
## [4,]  1.3211565 -0.3162278  0.5813184  1.0724893
## [5,] -0.8807710 -0.6324555  1.4117732  0.1995329
## attr(,"scaled:center")
##       x1       x2       x3       x4
##   26.000 2500.000    0.126    3.640
## attr(,"scaled:scale")
##           x1           x2           x3           x4
## 1.816590e+01 1.581139e+03 2.408319e-02 8.018728e-01
```

Note that we can also use other functions (i.e., `scores()` from other packages to get the same result.

## Min- Max Normalisation (a.k.a. range or (0-1) normalisation)

`y′=y−yminymax−ymin`

- In contrast to z-score standardisation this normalisation can suppress the effect of outliers.

```r
minmaxnormalise <- function(x){(x- min(x)) /(max(x)-min(x))}

# `lapply()` one can apply this function to a data frame.
lapply(df, minmaxnormalise)
## $x1
## [1] 0.00 0.25 0.75 1.00 0.00
##
## $x2
## [1] 0.000 1.000 0.500 0.250 0.125
##
## $x3
## [1] 0.0000000 0.3333333 0.1666667 0.6666667 1.0000000
##
## $x4
## [1] 0.00 0.85 0.35 1.00 0.65
If you would like to store the normalised values as a data frame you may also use as.data.frame() function:
as.data.frame(lapply(df, minmaxnormalise))
##     x1    x2        x3   x4
## 1 0.00 0.000 0.0000000 0.00
## 2 0.25 1.000 0.3333333 0.85
## 3 0.75 0.500 0.1666667 0.35
## 4 1.00 0.250 0.6666667 1.00
## 5 0.00 0.125 1.0000000 0.65
```

# Binning (a.k.a. Discretisation)

- Good for outliers
  - by placing them to the first or last category
- to get discrete values as an input or output variable
- i.e., most versions of Naive Bayes and CHAID analysis
- transform numerical variables into categorical counterparts

2 kinds:

- equal-width binning
- equal-frequency binning.

## Equal width (distance) binning

variable is divided into n intervals of equal size

ymax and ymin are the maximum and the minimum values in the variable, the width of the intervals will be:

TODOLATER:
`w=ymax−yminn`

Thus, we need to define the number of intervals n prior to binning. However, this is not an easy task for the analysts and constitutes one of the disadvantages of this method.

```r
library(infotheo)
iris <- read.csv("data/iris.csv")

iris %>%
  filter( Species == "versicolor" ) %>%  
  dplyr::select(Sepal.Length) %>%
  head()
##   Sepal.Length
## 1          7.0
## 2          6.4
## 3          6.9
## 4          5.5
## 5          6.5
## 6          5.7
```

Let’s apply equal-width binning to the `Sepal.Length` variable.

TODOLATER:


```r
ew_binned<-
  discretize(
    versicolor,
    disc = "equalwidth")
versicolor %>%
bind_cols(ew_binned) %>%
head(5)
##    Sepal.Length Sepal.Length1
## 1           7.0             3
## 2           6.4             3
## 3           6.9             3
## 4           5.5             1
## 5           6.5             3
## 6           5.7             2
## 7           6.3             3
## 8           4.9             1
## 9           6.6             3
## 10          5.2             1
## 11          5.0             1
## 12          5.9             2
## 13          6.0             2
## 14          6.1             2
## 15          5.6             1
```

## Equal depth (frequency) binning `disc = "equalfreq"`

`discretize(disc = "equalfreq")`

- divided into n intervals,
- each containing approximately the same number of observations (frequencies).

```r
ed_binned<-discretize(versicolor, disc = "equalfreq")
versicolor %>% bind_cols(ed_binned) %>% head(5)
##    Sepal.Length Sepal.Length1
## 1           7.0             3
## 2           6.4             3
## 3           6.9             3
## 4           5.5             1
## 5           6.5             3
```

# Data (dimension) reduction

- For too many variables
  - reduces risk of overfitting
  - because machine learning algorithms and regression are sensitive

- feature selection
- feature extraction
  
# `mlr` A quick look to the mlr package

- missing values imputation
- normalising
- centering
- standardising
- transforming
- feature extraction and
- selection)

```r
library(mlr)
```

[mlr] steps:

1. Create a task ->
2. Create a learner ->
3. Fit a model ->
4. Make predictions ->
5. Evaluate the learner

## 1. Create a task

- specifying the type of analysis
- providing the data and response variable

- `makeClassifTask()` = define the task as a classification, similarly
- `makeRegrTask()` = specify the task as a regression analysis.

Eg. To predict the Sepal.Length using other variables.

> 1. Define the task. Ie. regression

```r
iris.task =
  makeRegrTask(
    data = iris,
    target = "Sepal.Length")
```

## 2. `makeLearner()` Create a [learners]
- Choosing a specific algorithm (learner) which learns from task (or data).

With `makeLearner()` function we can easily specify the learner.

> 2. Define the learner

> e.g generalised linear model (a.k.a classical regression)

```r
## Choose a specific algorithm (e.g. generalised linear model - classical regression)
lrn = makeLearner("regr.glm")
```

## 3. Fit the model - `train()` and `test`

Fitting the model = get a random subset of data (i.e. training set).

1. divide the data set into train and test sets.

- training data `sample()` to get train
- testing set `setdiff()` from `dplyr` package:

```r
n = nrow(iris)
train.set = sample(n, size = 2/3*n)
test.set = setdiff(1:n, train.set)

## 3) Fit the model
## Train the learner on the task using a random subset of the data as training set

model = mlr::train(lrn, iris.task, subset = train.set)
```

## 4. `predict()` Make predictions

Apply the model in the test set to predict the **response variable** for new observations.

```r
## 4) Make predictions
prediction = predict(model, task = iris.task, subset = test.set)
```

## 5. Evaluate the learner with `performance()`

- Calculate the performance metrics for learners
- e.g. mean misclassification error and accuracy

```r
## 5) Evaluate the learner
## Calculate the mean squared error and mean absolute error
performance(prediction, measures = list(mse, mae))
##       mse       mae
## 0.1007054 0.2718763
```

So far, I’ve introduced the main workflow of mlr package in a general sense. In the next sections we will see the details of how to use these functions for feature selection and feature extraction.

# Feature selection
In feature selection, we try to find a subset of the original set of variables, or features which are best representatives of the data. There are different strategies to select features depending on the problem that you are dealing with. The most basic ones are given in the following subsections.

## Feature filtering
In feature filtering, redundant features are filtered out and the ones that are most useful or most relevant for the problem are selected. Feature filtering methods include removing features with zero and near zero-variance and removing highly correlated variables (i.e., greater than 0.8).
To illustrate feature filtering, we will continue with the iris.task (given above). In the iris data frame, we have 5 features (one of them Sepal.Length is defined as response/target variable).


```r
iris.task
## Supervised task: iris
## Type: regr
## Target: Sepal.Length
## Observations: 150
## Features:
##    numerics     factors     ordered functionals
##           4           1           0           0
## Missings: FALSE
## Has weights: FALSE
## Has blocking: FALSE
## Has coordinates: FALSE
# Print the feature names in the task

getTaskFeatureNames(iris.task)
## [1] "X"            "Sepal.Width"  "Petal.Length" "Petal.Width"
## [5] "Species"
```

> To drop specific features, let’s say Species, we can use dropFeatures(task, features) function.


```r
# Drop the Species and write it into the iris.task1

iris.task1 <-dropFeatures(iris.task, features = "Species")
iris.task1
## Supervised task: iris
## Type: regr
## Target: Sepal.Length
## Observations: 150
## Features:
##    numerics     factors     ordered functionals
##           4           0           0           0
## Missings: FALSE
## Has weights: FALSE
## Has blocking: FALSE
## Has coordinates: FALSE
# Print the feature names

getTaskFeatureNames(iris.task1)
## [1] "X"            "Sepal.Width"  "Petal.Length" "Petal.Width"
```

To remove/keep the features using a specific rule (i.e., remove/keep features with zero or near zero variance, remove/keep highly correlated features, etc) we can use the filterFeatures function. This function again requires the task and a character string specifying the filter method.

```r
filterFeatures(task, method, perc, abs, threshold)
```

```r
## Filter out all features with zero variance
filtered.task1 = filterFeatures(iris.task1, method = "variance", threshold = 0)

filtered.task1
## Supervised task: iris
## Type: regr
## Target: Sepal.Length
## Observations: 150
## Features:
##    numerics     factors     ordered functionals
##           4           0           0           0
## Missings: FALSE
## Has weights: FALSE
## Has blocking: FALSE
## Has coordinates: FALSE
getTaskFeatureNames(filtered.task1)
## [1] "X"            "Sepal.Width"  "Petal.Length" "Petal.Width"
```

> From the output, no features have zero variance, that’s why the filterFeatures function kept all features.

```r
## Filter all features with high correlation (i.e r>0.7)
filtered.task2 = filterFeatures(iris.task1, method = "linear.correlation", threshold = 0.7)

filtered.task2
## Supervised task: iris
## Type: regr
## Target: Sepal.Length
## Observations: 150
## Features:
##    numerics     factors     ordered functionals
##           3           0           0           0
## Missings: FALSE
## Has weights: FALSE
## Has blocking: FALSE
## Has coordinates: FALSE
getTaskFeatureNames(filtered.task2)
## [1] "X"            "Petal.Length" "Petal.Width"
```

check manually which features have high correlation with the target variable `(Sepal.Length)` using

> **bivariate correlations**.

```r
# Check correlations in the data
cor(iris$Sepal.Length, iris$Petal.Length)
## [1] 0.8717538
```
The correlations indicate that the correlation between Sepal.Length and Petal.Length is r=0.87 and the correlation between Sepal.Length and Petal.Width is r=0.82. Therefore, Sepal.Length and Petal.Width were being the filtered features. More in [filter features]

[filter features]:https://www.rdocumentation.org/packages/mlr/versions/2.12.1/topics/filterFeatures.

## Feature ranking `filterFeatures()`

- Ranked by an `importance criteria`, ie.
  - chi-square test
  - correlation test
  - entropy based tests
  - random forest
- selecting those which are `above a defined threshold`
- to be kept or removed from the data set

```r
## Rank all features using chi square test importance and select the two most important ones

filterFeatures(iris.task1, method = "chi.squared", abs = 2)

## Supervised task: iris
## Type: regr
## Target: Sepal.Length
## Observations: 150
## Features:
##    numerics     factors     ordered functionals
##           2           0           0           0
## Missings: FALSE
## Has weights: FALSE
## Has blocking: FALSE
## Has coordinates: FALSE
getTaskFeatureNames(filtered.task3)
## [1] "Petal.Length" "Petal.Width"
```

> Petal.Length and Petal.Width are the two most important features according to the chi-square criteria, so we keep them.

```r
## Rank all features using correlation test importance and select the most important one

filterFeatures(iris.task1, method = "linear.correlation", abs = 1)

## Supervised task: iris
## Type: regr
## Target: Sepal.Length
## Observations: 150
## Features:
##    numerics     factors     ordered functionals
##           1           0           0           0
## Missings: FALSE
## Has weights: FALSE
## Has blocking: FALSE
## Has coordinates: FALSE
getTaskFeatureNames(filtered.task4)
## [1] "Petal.Length"
```

The output suggest that the Petal.Length is the most important feature according to the correlation criteria.

# Feature extraction - reduces the dimensions of data

Feature extraction reduces the data in a high dimensional space to a lower dimension space,
- Creating a new combinations of attributes,

Feature selection - include and exclude attributes present in the data without changing them. Eg. with PCA

## Principal Component Analysis (PCA)

- an unsupervised algorithm that creates `linear combinations of the original features`.
- Orthoganal and uncorrelated
- Ranked by “explained variance”
- Eg. the first principal component (PC1) explains the most variance in the data, and so on.
- Down to 90% a cumulative explained variance of 90%
- Pros: fast and simple to impliment
- Cons: PCA's aren't interpretable

Packages include:
`prcomp()`
`caret` - any caret functions can also be converted into the mlr functions.

`preProcess()` function as follows:


```r
library(caret)
library(mlbench) # to load the sonar data
Note that this data has 208 observations and 60 features.
data(Sonar)

head(Sonar)
##       V1     V2     V3     V4     V5     V6     V7     V8     V9    V10
## 1 0.0200 0.0371 0.0428 0.0207 0.0954 0.0986 0.1539 0.1601 0.3109 0.2111
## 2 0.0453 0.0523 0.0843 0.0689 0.1183 0.2583 0.2156 0.3481 0.3337 0.2872
## 3 0.0262 0.0582 0.1099 0.1083 0.0974 0.2280 0.2431 0.3771 0.5598 0.6194
## 4 0.0100 0.0171 0.0623 0.0205 0.0205 0.0368 0.1098 0.1276 0.0598 0.1264
## 5 0.0762 0.0666 0.0481 0.0394 0.0590 0.0649 0.1209 0.2467 0.3564 0.4459
## 6 0.0286 0.0453 0.0277 0.0174 0.0384 0.0990 0.1201 0.1833 0.2105 0.3039

## ... more here

##   Class
## 1     R
## 2     R
## 3     R
## 4     R
## 5     R
## 6     R
```

reach a cumulative explained variance of 90% by specifying thresh = 0.90 argument.


```r
preProcess(Sonar, method = "pca", thresh = 0.90)

## Created from 208 samples and 61 variables
##
## Pre-processing:
##   - centered (60)
##   - ignored (1)
##   - principal component signal extraction (60)
##   - scaled (60)
##
## PCA needed 22 components to capture 90 percent of the variance
```
According to the summary output, the PCA extracted 22 components to reach a cumulative explained variance of 90%. Note that the variables were centered and scaled in default for this analysis.

> Inspect the extracted components using  `pca1$rotation`.

```r
head(pca1$rotation)
##           PC1        PC2          PC3         PC4        PC5        PC6
## V1 0.13637827 -0.1223047  0.015992208 -0.01398332 0.13559873 -0.1102138
## V2 0.14605308 -0.1310784  0.016703474 -0.06095574 0.16977542 -0.1432289
## V3 0.11572088 -0.1424144  0.008359428 -0.11166025 0.18842191 -0.2173942
## V4 0.09390192 -0.1544207 -0.023779899 -0.10136333 0.17819174 -0.2512730
## V5 0.05534548 -0.1604564  0.025419982 -0.07332698 0.07256160 -0.2126554
## V6 0.05175506 -0.1458544  0.068286250  0.10835565 0.06708443 -0.1715077

## and more up to PC22

```
When we have a prior knowledge on the number of dimensions we can also set the specific number of PCA components to keep using the pcaComp argument.

```r
preProcess(Sonar, method = "pca", pcaComp = 3)
## Created from 208 samples and 61 variables
##
## Pre-processing:
##   - centered (60)
##   - ignored (1)
##   - principal component signal extraction (60)
##   - scaled (60)
##
## PCA used 3 components as specified
```
In this example, I applied a PCA analysis with 3 components by specifying pcaComp = 3 argument. We can further inspect the extracted components using pca2$rotation.


```r
pca2$rotation
##              PC1          PC2          PC3
## V1   0.136378273 -0.122304688  0.015992208
## V2   0.146053080 -0.131078408  0.016703474
## V3   0.115720878 -0.142414435  0.008359428

## and soforth

## V59  0.143756315 -0.090282629 -0.072818633
## V60  0.117841717 -0.075271297 -0.069013391
```

`prcomp()`

- centers the variable to have mean equals to zero. With
- parameter `scale. = T`, variables are normalised to have standard deviation of 1.

```r
prcomp(Sonar, scale. = T)

# Error in colMeans(x, na.rm = TRUE) : 'x' must be numeric
```
because PCA does not work on categorical variables.
`prcomp()` we need to manually filter out this factor variable before conducting the analysis.

```r
# Exclude Class variable and then apply prcomp

pca3 <- prcomp(Sonar[,-61], scale. = T)
We can see the output of this analysis using the names():
names(pca3)
## [1] "sdev"     "rotation" "center"   "scale"    "x"
```

- The rotation gives the principal component loading, and this is another useful measure used to understand the contribution of each variable to the extracted components/dimensions.
- `head(pca3$x)` - x gives the extracted principal components (equal to rotation in preProcess).

[mlr]: https://mlr-org.github.io/mlr-tutorial/release/html/task/index.html
[learners]: https://mlr-org.github.io/mlr-tutorial/release/html/learner/index.html
