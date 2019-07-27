# Instructions:
# Please answer the following TWO questions based on yearly sales series of a company that is starting from # 1950 and attached to this email.
#

rm(list = ls())

cat("\014") # clear everything

workingDirectory <- "/Users/phil/code/data-science-next/uni/time-series/tests"

dataFilename <- "datasetMidSemTest.csv"



startYear = 1950 # TODO: get start year

endYear = 1996 # TODO: get end

default_ylab = 'yearly sales series'

# default_subtitle = ''

default_xlab = 'Year'



# devtools::install_git('https://gitlab.com/botbotdotdotcom/packagr')

library(packagr)

packages <- c('captioner')

packagr(packages) # alpha package to check, install and load packages


# moved all functions to here

# source('/Users/phil/code/data-science-next/uni/time-series/common/utils.r') 
source('https://raw.githubusercontent.com/tgrrr/data-science/master/uni/time-series/common/utils.r')

# Hint: use read.csv() function with header = FALSE to read the data into R.

setwd(workingDirectory)

data <- read.csv(
  './datasetMidSemTestDef.csv', 
  header = FALSE) 

dim(data)

# Convert to timeseries:

# TODO: check if it needs labelling
# FIXME: 
# rownames(data) <- seq(from = startYear, to = endYear)

isTimeSeries <- function(data) { 

  return(data %>% class() == 'ts') 

}

convertToTimeSeries <- function(data, startYear) {

  isTimeSeries(data) ?

    data.ts <- data :

    data.ts <- ts(

      as.vector(data), 

      start = startYear # FIXME: start_year
      # end = endYear # optional
    );
}

data.ts <- convertToTimeSeries(data, startYear)

cat('converted to time series data: ', isTimeSeries(data.ts))

data.ts %>% tail()

#
# 1. (40 marks)
#
# a) Display and comment on the descriptive plots for this yearly revenue series.
#

doDiffAndPlot(data.ts, 0, T, T, fig_nums('diff_0', 'Sales figures diff=0'))

# From Visual inspection:
# - Positive trend over time
# - ACF - shows exponential decay of lags
# ACF has too many lags to fit a model
# - PACF shows 1 signficant lag - Possible AR(1)
# Is not stationary at diff = 0
# - No obvious Intonation point, 
# - No obvious seasonality

# Check ts correlation:

y = data.ts        # Read data into y

x = zlag(data.ts)  # Generate first lag

index = 2:length(x) # Create an index to get rid of the first NA value

cor(y[index], x[index])

doPar(mfrow = c(1, 1))

plot(

  y = data.ts,

  x = x,

  ylab = 'Closing Price',

  xlab = 'Previous Day Closing Price',

  main = fig_nums("Scatter_neighbouring", 

                  "Scatter plot of neighbouring Closing Prices")

)

# Strong positive correlation of 0.998

# b) Based on ONLY your descriptive analysis in part (a), choose whether a linear or quadratic trend model # is most appropriate for this series. 

# Initial inspection suggest a quadratic model is most appropriate

## Quadratic Model:


time = time(data.ts)

time2 = time ^ 2

model_quadratic = lm(data.ts ~ time + time2) # label the quadratic trend model

summary(model_quadratic)
# - R^2 .9934 is a good fit
# - possible overfit because it's too close to 1


doPar(mfrow = c(1, 1))

plot(

  ts(fitted(model_quadratic)),

  ylim = c(min(c(

    fitted(model_quadratic), as.vector(data.ts)

  )),

  max(c(

    fitted(model_quadratic), as.vector(data.ts)

  ))),

  ylab = default_ylab,

  main = fig_nums(

    "quadratic_model",

    "Quadratic Model")

)

lines(as.vector(data.ts))

# Plot shows good fit of quadratic to our model

# Residual Analysis
# Fit your chosen model and assess its goodness of fit by residual analysis. 


residual.analysis(

  model_quadratic, std = TRUE, start = 1,

  title = fig_nums(

    'quadratic_model_residual', 

    'Quadratic model residual analysis'))

# - histogram:  Fairly normally distributed, possibly bimodal
# - Ljung-Box test: all lags are significant
# - Q-Q plot: left-tailed, doesn't fit along one line, therefore not normally distributed
# - ACF: there are significant lags which does not fit with a white noise series
# - PACF: there are significant lags which does not fit with a white noise series
# - Shapiro-Wilk: p-value > 0.8, therefore reject the null that the residuals are normally distributed, and are white noise
# 
# - Summary: The standardised residuals are not white noise and show that the model has not captured the trend of the data

# How this fits with initial observations:
# For this step, please clearly explain why do you choose that particular trend model in terms of your observations in part (a).
# 
# - Data was not observed to be Stationary
# - Suggests we should transform and diff to the data
# - TODO: expand this

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% #

# 2. (60 marks) Suggest at least 5 candidate ARIMA models for this series using the following tools where # necessary or appropriate:

# check the confidence interval of lambda

doPar(mfrow = c(1,1))

boxcoxCi <- BoxCox.ar(data.ts, method = "yule-walker")$ci

boxcoxCi

title(fig_nums('boxcox_ci','Confidence Interval of Lambda of Bitcoin'), line = -1.5, outer = TRUE)

# Confidence interval 0.1 - 0.5 does not capture 0
# So we will do a Box Cox transform

# Transform:

# Let\'s first apply the Box-Cox transformation.

boxcoxCi

# test-normality

doTestNormality <- function(df) {

  qqnorm(df)

  qqline(df, col = 2)

  shapiro.test(df)

}

lambda <- (max(boxcoxCi)-min(boxcoxCi))/2 

# lambda=0.2 ~midpoint betwen confidence interval

data.ts__boxcox = (data.ts^lambda-1) / lambda 

fig_nums('test-normality', paste('Test Normality of ', default_ylab, sep = '')) %>% cat()

doTestNormality(data.ts)

doTestNormality(data.ts__boxcox)

# The Box-Cox transformation **did not** help to improve the normality of the # series because:
# - Although the dots are moreso aligned with the red line in the QQ plot
# - However, it isn\'t a perfect fit with QQ 
# - The Shapiro Wilks p-value (0.016) is significant for both the original and # Box Cox transformed data


doDiffAndPlot(data.ts, 0, F, F, fig_nums('diff_0', 'Sales figures diff=0'))

# ADF shows diff = 0 is insignificant

# - Plot is still not stationary

doDiffAndPlot(data.ts, 1, F, F, fig_nums('diff_1', 'Sales figures diff=1'))

# ADF shows diff = 1 is insignificant

# - ADF shows Box Cox transform diff = 1 is insignificant

# - Plot is still not stationary

doDiffAndPlot(data.ts, 2, T, T, fig_nums('diff_2', 'Sales figures diff=2'))

data.ts__diff2 <- data.ts %>% diff(2)


# - ADF shows diff = 2 is significant!
# - Plot is now stationary
# - Improvement in ACF and PACF to 1 significant lag
# - EACF does not capture (0,0)

# Possible ARIMA Models:

# From ACF lag = 1, PACF lag = 2

# `{ARIMA(1,2,0)}`

#  From EACF:

# `{ARIMA(1,2,0)}` <- also supported by ACF and PACF
# `{ARIMA(2,2,0)}`
# `{ARIMA(1,2,1)}`
# `{ARIMA(2,2,2)}`

# - BIC table (Hint: use "  nar = 10, nma= 10, ar.method='ols'   " options while displaying BIC table).

res = armasubsets(
  y = data.ts__diff2,
  nar = 10,
  nma = 10,
  y.name = 'test',
  ar.method = 'ols'
  )

plot(res)

# This is much less clear
# Note the graph has a naming error from from error-lag-10 to error-lag1

# `{ARIMA(0,2,1)}`
# `{ARIMA(1,2,1)}`
# `{ARIMA(2,2,1)}` 

# It does show there are possible models at the intercept 0, so we will add:

# `{ARIMA(0,2,1)}`
# `{ARIMA(0,2,2)}`

# findBestModel(data.ts)

# My AIC ranking formula supports the following models:

# | AIC      | Order | Shapiro Residuals p-value |
# | -------- | ----- | ------------------------- |
# | 616.2337 | 0 2 1 | 0.01242433                |
# | 616.5995 | 1 2 1 | 0.005126874               |
# | 616.8455 | 0 2 2 | 0.006979836               |
# | 618.5262 | 2 2 1 | 0.00505252                |
# | 618.5721 | 1 2 2 | 0.005205435               |
# | 620.3772 | 2 2 2 | 0.003805803               |
# | 622.729  | 1 2 0 | 0.0008214681              |
# | 623.7933 | 2 2 0 | 0.002220712               |
# | 629.6419 | 1 1 0 | 0.003886983               |
# | 630.7901 | 0 1 2 | 0.009811891               |
# | 630.7991 | 2 1 0 | 0.01477985                |
# | 630.9516 | 1 1 1 | 0.01379222                |
# | 631.6477 | 0 1 1 | 0.005170221               |
# | 632.4845 | 1 1 2 | 0.009949152               |
# | 632.7494 | 2 1 1 | 0.01327455                |
# | 634.3989 | 2 1 2 | 0.008049782               |
# | 659.6511 | 2 0 0 | 0.001105469               |
# | 665.6713 | 1 0 2 | 0.001519234               |
# | 669.6064 | 1 0 1 | 0.003299923               |
# | 673.417  | 2 0 1 | 0.004234925               |
# | 682.5601 | 2 0 2 | 9.532246e-07              |
# | 684.5171 | 1 0 0 | 0.02484249                |
# | 783.4128 | 0 0 2 | 0.003253528               |
# | 834.2554 | 0 0 1 | 0.001071975               |

# For each of the above, please give clear explanations of why you select the particular model(s) based on # the above tools. In total, you need to come up with at least 5 candidate models in the end.

# Visually Selected Models:
# 
# `{ARIMA(1,2,0)}`
# `{ARIMA(2,2,0)}`
# `{ARIMA(1,2,1)}`
# `{ARIMA(2,2,2)}`
# `{ARIMA(1,2,1)}`
# `{ARIMA(2,2,1)}` 
# `{ARIMA(0,2,1)}`
# `{ARIMA(0,2,2)}`
# 
# Possible models ranked by AIC:
# 
# | AIC      | Order | Shapiro Residuals p-value |
# | -------- | ----- | ------------------------- |
# | 616.2337 | 0 2 1 | 0.01242433                |
# | 616.5995 | 1 2 1 | 0.005126874               |
# | 616.8455 | 0 2 2 | 0.006979836               |
# | 618.5262 | 2 2 1 | 0.00505252                |
# | 618.5721 | 1 2 2 | 0.005205435               |
# | 620.3772 | 2 2 2 | 0.003805803               |
# | 622.729  | 1 2 0 | 0.0008214681              |
# | 623.7933 | 2 2 0 | 0.002220712               |

# Please keep in mind that there is not one unique solution to this exam since different approaches can # come up with different sets of possible models. Main focus is to be able to run the analysis and give # sufficient comments/inferences to back up your approach.

#
#
#
# To submit your answers for marking, follow the steps below:
#
# - Write your R script in R-Studio (DO NOT USE R MARKDOWN),
# 
#
# - Run it and make sure that your R Script runs smoothly without any problem,
#
# - Write your comments for the solution after each relevant line in your R script after a "#",
#
# - Skip one line after each line of your R script, (IF YOU DO NOT DO THIS YOUR R SCRIPT WON'T RUN WHEN I # COPY IT FROM CANVAS)
#
# - When you are ready to submit your answer, please copy your script from R-Studio and paste it into the # text box in Canvas. DO NOT SUBMIT A FILE BY EMAIL.
#
# Good luck!
#
