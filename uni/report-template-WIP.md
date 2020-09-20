FIXME: ---
title: "MATH2349 Semester 1, 2018"
author: "Phil Steinke s3725547"
subtitle: Assignment 1
output:
  html_document:
    df_print: paged
  html_notebook: default
---

## Introduction*
- **Goals/Objectives**
	- [ ] Analyse the ...
	- [ ] Use the analysis method...
	- [ ] Chose the best model from ...
	- [ ] Provide forecast of egg deposits for next 5 years
	> eg In this task, the main goal of your analysis is to demonstrate whether the correlation between these two series is spurious or not.
	> eg. This report investigates if there is a general, easy to determine, body circumference measurement that could be used as a general indicator for body fat percentage. 
- **Interest** Describe why it is interesting to answer the questions / meet the goal of this topic
- **Obstacles** What obstacles do we need to overcome?
- **Data Collection** - Describe how you collected the data, and briefly why you chose that approach
	- eg. A sample of 252 men and women from was obtained from [JSE-DA]
- **how evaluated** (hypothesis, diagnostics, etc)
	> eg. The data which was collected was then visualised to find any potential outliers and form hypothesis to test.
- TODO: **Methodology**
- Problem Statement

<!-- --------------------- -->


## Data Inspection

### Data description*
**A clear description of data and its source should be provided in this section.**

> Eg. The dataset includes monthly averages of ASX All Ordinaries (Ords) Price Index, Gold price (AUD), Crude Oil (Brent, USD/bbl) and copper (USD/tonne) between January 2004 and May 2017.
> Egg depositions (in millions) of age-3 [Lake Huron Bloaters (Coregonus hoyi)](https://en.wikipedia.org/wiki/Coregonus_hoyi) between years 1981 and 1996 are available in BloaterLH dataset of FSAdata package.

- Read/Import Data
```{r}
library('here')
read.csv(here(), TODO:)
```

- Inspect and Understand
- Report some statistics of your collected data

#### Dimensions and attributes
+ plots
```{r}
# check the dimensions of the data frame.
dim(family_violence)
# check the attributes in the data.
attributes(family_violence)
```

#### Features 
- aka Factors / Data types

Features in this data set are as follows:
- Feature Name
- Data Type
- Description
- **Factors**: check the data types (i.e., character, numeric, integer, factor, and logical) of the variables in the data set.
	> As the original dataset is >200k rows, we have taken a random sample of 5000 rows and then split this sample further into training and testing data. The target variable, 'y', is a continuous numeric variable so we will be using regression algorithms to predict the outcome.

- as a docstring:
```{r}
#' Prices of 50,000 round cut diamonds
#'
#' A dataset containing the prices and other attributes of almost 54,000
#'  diamonds. The variables are as follows:
#'
#' \itemize{
#'   \item price. price in US dollars (\$326--\$18,823)
#'   \item carat. weight of the diamond (0.2--5.01)
#'   \item cut. quality of the cut (Fair, Good, Very Good, Premium, Ideal)
#'   \item colour. diamond colour, from J (worst) to D (best)
#'   \item clarity. a measurement of how clear the diamond is (I1 (worst), SI1, SI2, VS1, VS2, VVS1, VVS2, IF (best))
#'   \item x. length in mm (0--10.74)
#'   \item y. width in mm (0--58.9)
#'   \item z. depth in mm (0--31.8)
#'   \item depth. total depth percentage = z / mean(x, y) = 2 * z / (x + y) (43--79)
#'   \item table. width of top of diamond relative to widest point (43--95)
#' }
#'
#' @docType data
#' @keywords datasets
#' @name diamonds
#' @usage data(diamonds)
#' @format A data frame with 53940 rows and 10 variables
```

- Describe what/who is your selected data 
	> eg - *percentage* of body fat measured using the **Brozek** method - underwater weighing technique of density. Ten other body circumference measures (e.g. abdomen) are included as factors.

Table: The Data

* check the levels of factor variables, rename/rearrange them if required.

### Testing Assumption of Homoscedasticity
+ plots
```{r}
mplot(bodyAbdomenMaxModel, 1)
```

```{r}
xyplot(Abdomen ~ BFP_Brozek, data = body, ylab = "Abdomen", xlab = "BFP_Brozek", panel=panel.lmbands)
```

```{r}
pf(489.9,1,250,lower.tail = FALSE ) # 7.71020869865819e-61
```
p (7.71020869865819e-61) is less than the  Confidence Level
<!-- Therefore we can reject the null hypothesis -->

### Confidence Interval
+ plots
```{r}
confint(bodyAbdomenMaxModel, level = .99)
```

#### Test Intercept (α)
+ plots

- H<sub>0</sub>: α = 0
- H<sub>a</sub>: α ≠ 0

### Distribution Fitting
- histogram
- compare the data to a normal distribution

> eg. Compare the empirical distribution of selected body measurement to a normal distribution separately in men and in women. You need to do this visually by plotting the histogram with normal distribution overlay

<!-- --------------------- -->

## Data Visualisation

## Transformation
aka preprocessing/cleaning/transform
- Check the column names in the data frame, rename them if required.

- Describe what pre-processing you performed
- Show examples of noisy data, plot some graphs, etc to show why you decided to do those pre-processing
- Normalisation
- Transform

<!-- --------------------- -->

## Model*
	> eg. Each of these algorithms were optimised within a pipeline to fine tune the hyperparameters. 
	> This includes feature selection.

- Algorithm Performance Analysis
	> eg. The pipeline algorithm for the decision tree regressor included feature selection, and hyperparameters max depth, and minimum sample split.

	As you can see above:
	the K-Nearest Neighbor has the best MSE (closest to 0)
	The execution time required to run the decision tree was most efficient
	Setup


<!-- --------------------- -->

## Diagnostics
- Error Checking

### Testing the Residuals
```{r}
qqPlot(bodyAbdomenMaxModel$residuals, dist="norm")
```

<!-- --------------------- -->

## Forecast

<!-- --------------------- -->

## Analysis
- Discussion

Analysis Approach

- Describe what analysis you performed to answer the questions
- What type of sentiment analysis did you do?  Briefly explain your rationale for doing it as such.
- What type of topic modelling did you do?  Again, briefly explain your rationale for your approach.

Analysis & Insights

- Present your analysis, to answer the questions 
- Present and discuss your insights
- Use plots, tables, example of prints, visualisation, word clouds etc that supports your analysis and insights

<!-- --------------------- -->
## Conclusion
_Provide a short conclusion about your entity, analysis and what you found_

- Going back to your problem statement, what insight has been gained from the investigation? Discuss the extent to how your theoretical normal distribution fits the empirical data.
- You will end by discussing the extent to how your theoretical normal distribution fits the empirical data and make recommendations regarding the modelling of this body measurement.

- dot point 1
- dot point 2
- dot point 3

## My Recommendation:

- dot point 1
- dot point 2
- dot point 3


Eg. The forcast shows a possible 3,000,000,000 eggs laid in 2006. Given the dataset is limited to 16 values, a more detailed dataset should be examined to check accuracy of fit. 
- The model may also be adjusted because of the scarcity of food and high mortality rate of larval Bloaters
If the model still fits, recommendations include investing in the cavier industry in Lake Huron

### Limitations of Report
- Our methodology has several weaknesses and limitations:
	- Sample size
	- These limitations were put in place to reduce execution time; to improve the accuaracy of these models in future the hyperparameters of each algorithm could be further optimised
	- As our data required us to perform regression our only performance metric was mean squared error.
	- Please note that the dataset is quite small, so we have limited most of our decisions to programatic output
	- execution time was ...

### Summary

The results of the above tests summarised:
- p-value(0.02) < 0.05 in our adfTest
- ma2 and ma1 p < 0.05 in coefficient test
- Residuals are not apparent in arima(1,4,0) and arima(0,4,2)
The AIC and BIC score for is higher for arima(0,4,2), which is why we have selected {arima(0,4,2)} as our best fitting time-series model
- The t-test p-value is significant (p < 0.05) when we compare it to both the Neural Network, and the Decision Tree model.

<!-- #### Draw an overall conclusion to help the investigators -->
This report examined an unknown companies Google Ads exported data. It compared three machine learning models to find the best parameters to maximise the ROI on advertising against an unknown parameter (y).
Ranked by MSE, the Nearest Neighbour (KNN) is the most performant model with the parameters: n_neighbors: 10 and p: 1 using the feature selection of SelectKBest()

## Bibleography / Sources

<!-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% -->

