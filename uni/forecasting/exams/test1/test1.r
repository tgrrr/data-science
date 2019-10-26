# ---
# title: 'Forecasting Test 1 - Phil Steinke'
# output: html_notebook
# ---

### Setup
# devtools::install_git('https://gitlab.com/botbotdotdotcom/packagr')

library(packagr)
# install.packages('readr')

packages <- c(
  'dLagM', 'forecast', 'expsmooth', 'TSA', 'Hmisc', 'car', 'AER', 'readr', 'tseries', 'lubridate', 'stringr', 'testthis', 'captioner', 'urca', 'xts', 'dynlm', 'changepoint', 'x12')
packagr(packages) # alpha package to check, install and load packages

# source(https://github.com/tgrrr/data-science/tree/master/uni/common/utils-forecasting.R)
source('/Users/phil/code/data-science/uni/common/utils-forecasting.R')

# Mid-Semester Test
# Due 28 Aug by 20:30  Points 100  Submitting a text entry box Available 28 Aug at 18:30 - 28 Aug at 20:50 about 2 hours
# Please answer the following THREE questions based on the given data for each question. Each question is independent of each other. Please prepare the R scripts that answer just the question and articulate your answer by inferences from the output of your code. 
# 
# 1. Quarterly returns of a share in Australian Stock Market from the first quarter of 1994 is available HERE. (30 marks)
# 
# VARIANCE
# Changing ==variance== makes it harder to predict future returns of shares in the stock market. Therefore the existence of changing variance should be evaluated before further analyses. Please investigate the existence of changing variance in the given returns series using appropriate tools covered in this course.
# 
# data %>% head(1) # Initial date: 
tsStart = c(1994,1) # TODO
# data %>% tail(1) # Final date: 
# tsEnd = c(2017, 5)  # TODO
default_ylab = 'ASX data' # TODO
default_xlab = 'time'
# TODO featuresData <- list('ASXdata.ts.ts', 'Golddata.ts.ts', 'CrudeOilBrentUSDbbl.ts', 'CopperUSDtonne.ts')

featuresData <- list('Q1')

dataQ1 <- read_csv(
  '~/code/data-science/datasets/forecasting/dataQ1.csv',
  col_names = FALSE
)

data.ts <- ts(
  dataQ1,
  start = tsStart,
  # TODO: end = tsEnd,
  frequency = 4
);


data.ts %>% dim()

plot(
  data.ts, 
  type = 'l', 
  # xlim = c(1995,1998)
)
points(y=data.ts,x=time(data.ts), pch=as.vector(season(data.ts)))
# - Appears to have obvious seasonality (low point at in Q1, high point in Q4)
# - Possible changing variance 
# Check for seasonality

data.additive.ts <- decompose(data.ts, type='additive')
plot(
  data.additive.ts,
  # xlim = c(1995,1998)
  
)

data.multiplicative.ts <- decompose(
  data.ts, 
  type='multiplicative',
)
plot(data.multiplicative.ts)

# multiplicative is a better fit, due to a more linear residual, bar a spike in 2005
# Data has clear possitive trend
# Seasonality also appears on this graph

doDiffAndPlot(data.ts, 0)

data.diff1.ts <- doDiffAndPlot(data.ts, 1, out=TRUE)
# Diff of 1 improved data
# Significant p > 0 in Augmented Dickey Fuller Test
# Variance is still apparent

# ACF: appears we have exponentially declining feature with lag ~7
# Possible seasonality
# PACF: lag 4

model1 = dlm(x = as.vector(data.ts), y = as.vector(data.ts) , q = 8)
summary(model1)

# confidence Interval is 0.8 - 1.2, which doesn't include 0, so we look to boxcox transform

convertToBoxCox2 <- function(
  df.ts
) {

  if(min(df.ts) < 0) {
    boxcoxCi <- BoxCox.ar(
      (df.ts 
        + abs(min(df.ts))
        +10
      ),
      # plotit = FALSE,
      method = "yule-walker"
    )$ci    
  } else {
    boxcoxCi <- BoxCox.ar(
      df.ts, 
      # plotit = FALSE,
      method = "yule-walker"
    )$ci

    # 
  }

  lambda <- (max(boxcoxCi)-min(boxcoxCi))/2 
  # lambda=~midpoint between CI
  df.boxcox.ts = (df.ts^lambda-1) / lambda
  cat('\nConfidence Interval: \n', boxcoxCi)
  # cat(boxcoxCi)
  cat('\nLambda: ', lambda)
  return(df.boxcox.ts)
}

data.boxcox.ts <- convertToBoxCox2(data.ts)

plot(data.boxcox.ts)
# Strange error

doDiffAndPlot(data.ts, 1, lag = 12)

# diff 1 doesn't clean up data significantly

data.diff1.seasonal.ts <- doDiffAndPlot(data.ts, 1, lag = 12, out=TRUE)
# Seasonal differencing helps, somewhat. However, there is still residual in the data;

# multiplicative works best


# 
# 3. Refer to the quarterly returns of a share in Australian Stock Market from the first quarter of 1994 that is available HERE. (The same dataset is given for Q1 as well.) (40 marks)
# 
# Please do the following to find forecasts of returns of this share for the next 8 quarters:
# 
# a) Fit at least two exponential smoothing models to this series. One of them must include multiplicative seasonality.  Please articulate your findings by commenting on the outputs.

data.ts %>% head(12)

# fit1 <- ses(freight, alpha=0.1, initial="simple", h=8) # Set alpha to a small value

fit1.ses <- ses(data.ts, initial="simple", h=8) 
summary(fit1.ses)
checkresiduals(fit1.ses)

# - skewed data
# -----------------------------

fit1.holt <- holt(data.ts, initial="simple", h=8) 
summary(fit1.holt)
checkresiduals(fit1.holt)

# - Residuals include seasonal lag
# - exponential declining trend in ACF
# - Non normality in residuals - skewed
# 
fit2.holt <- holt(data.ts, initial="simple", h=8) # Let the software estimate both alpha and beta
summary(fit2.holt)
checkresiduals(fit2.holt)

fit3.holt <- holt(data.ts, initial="simple", exponential=TRUE, h=8) # Fit with exponential trend
summary(fit3.holt)
checkresiduals(fit3.holt)

# - Residuals have clear pattern
# - Include exponentially declining trend
# - Not normality
# - ACF show exponential decay, multiple lags

fit4.holt <- holt(data.ts, damped=TRUE, initial="simple", h=8) # Fit with additive damped trend
summary(fit4.holt)
checkresiduals(fit4.holt)

# - exponential is way off, and can be discarded
# Other's all fit reasonabily well.
# -----------------------------


fit1.sea = hw(data.ts,
  seasonal="additive", 
  h=8*frequency(data.ts)
)
summary(fit1.sea) 
checkresiduals(fit1.sea)
# - Significantly better, lag 1 for ACF
# - Residuals appear mostly normal
# - Still capture seasonality
# 
fit2.sea = hw(data.ts,seasonal="additive", damped = TRUE, h=8*frequency(data.ts))
summary(fit2.sea) # Best fit, best time series plot for residuals
checkresiduals(fit2.sea)

# - Similar as fit1, with lag 2

# We add a constant to be able to fit multiplicatie model with negative or zero values
fit3.sea = hw(min(data.ts+50),seasonal="multiplicative", h=8*frequency(data.ts))
summary(fit3.sea) 
checkresiduals(fit3.sea)
# provides the error:
# Error in hw(min(data.ts + 50), seasonal = "multiplicative", h = 5 * frequency(data.ts)): The time series should have frequency greater than 1.
# Traceback:
# 1. hw(min(data.ts + 50), seasonal = "multiplicative", h = 5 * frequency(data.ts))
# 2. stop("The time series should have frequency greater than 1.")


fit4.sea = hw((data.ts+50),seasonal="multiplicative",damped = TRUE, h=8*frequency(data.ts))
summary(fit4.sea) 
checkresiduals(fit4.sea)

# - ACF lag 2, normal residuals, shows some possible seasonality

fit5.sea = hw((data.ts+50),seasonal="multiplicative",damped = FALSE, exponential = TRUE, h=8*frequency(data.ts))
summary(fit5.sea) 
checkresiduals(fit5.sea)

# - ACF lag 2, normal residuals, shows some possible seasonality


fit5.hw <- hw(data.ts,seasonal="additive", h=5*frequency(data.ts))
summary(fit5.hw) 
checkresiduals(fit5.hw)

fit6.hw <- hw(data.ts,seasonal="additive",damped = TRUE, h=5*frequency(data.ts))
summary(fit6.hw)
checkresiduals(fit6.hw)

fit7.hw <- hw(data.ts,seasonal="multiplicative", h=5*frequency(data.ts))
summary(fit7.hw)
checkresiduals(fit7.hw)

fit8.hw <- hw(data.ts,seasonal="multiplicative",exponential = TRUE, h=5*frequency(data.ts))
summary(fit8.hw)
checkresiduals(fit8.hw)

fit1.etsA = ets(data.ts, model="ANN")
summary(fit1.etsA)
checkresiduals(fit1.etsA)

fit1.etsM = ets(data.ts, model="MNN")
summary(fit1.etsM)
checkresiduals(fit1.etsM) # Least autocorrelated - BG test

fit2.etsA = ets(data.ts, model="AAN")
summary(fit2.etsA)
checkresiduals(fit2.etsA)

fit2.etsM = ets(data.ts, model="MAN", damped = TRUE)
summary(fit2.etsM)
checkresiduals(fit2.etsM)

fit3.etsA = ets(data.ts, model="AAA")
summary(fit3.etsA)
checkresiduals(fit3.etsA)

fit3.etsM = ets(data.ts, model="MAA")
summary(fit3.etsM)
checkresiduals(fit3.etsM) # By visual checks residuals of this model is less correlated.

fit4.etsM = ets(data.ts, model="MAM")
summary(fit4.etsM)
checkresiduals(fit4.etsM)

fit5 = ets(data.ts)
summary(fit5)
checkresiduals(fit5) # Autofit actually finds the fit1.etsM which is the least autocorrelated - BG test

plot(forecast(fit1.etsM), ylab="Fuel data.ts",plot.conf=FALSE, type="l", xlab="Year")

plot(forecast(fit3.etsM), ylab="Fuel data.ts",plot.conf=FALSE, type="l", xlab="Year")

# TODO: cleanup model numbers

# -----------------------------

models <- c(
fit1.ses,
fit1.holt,
fit2.holt,
fit3.holt,
fit4.holt,
fit1.sea,
fit2.sea,
fit3.sea,
fit4.sea,
fit5.sea,
fit5.hw,
fit6.hw,
fit7.hw,
fit8.hw,
fit1.etsA,
fit1.etsM,
fit2.etsA,
fit2.etsM,
fit3.etsA,
fit3.etsM,
fit4.etsM,
fit5,
fit1.sea.ets,
fit2.sea.ets,
fit3.sea.ets,
fit4.sea.ets,
fit5.sea.ets,
fit6.sea.ets,
)

plot(fit1.ses, type="l", ylab="ABS data.ts", xlab="Year", 
     fcol="white", plot.conf=FALSE)
for (i in models) {
    lines(i)
}
legend("topleft", lty=1, 
col=c("black","blue","red","green","cyan"), model)


# 
# b) Fit at least three state-space models to this series. One of them must include multiplicative errors. Please articulate your findings by commenting on the outputs.
# 

# State Space ====================================

min(data.ts)
const = 12

errorTypes = c('A', 'M', 'Z')
trendTypes = c('N','A','M', 'Z') 
seasonTypes = c('N','A','M', 'Z')

for (i in errorTypes) {
  for (j in trendTypes) {
    for (k in seasonTypes) {
      out = tryCatch({
        modelType <- paste0(i,j,k)
        model = ets(data.ts, model=modelType)
        modelOut <- assign(
        paste0('fit.', modelType, ".ets"), model, envir = .GlobalEnv);
        # ets(data.ts, model = model)
        # cat(modelOut, '\n')
        print(modelType)
        print(modelName[4])
        print(modelName)
        if ()
      },
      error = function(e) print("No results for this test!"))
    # }
    # return(list(lambda = BC.lam,p.value = BC.y))
    }
  }
}

# Lowest AIC is 630.6722, 




fit1.sea.ets = ets(data.ts, model = "AAA")
summary(fit1.sea.ets)

checkresiduals(fit1.sea.ets)


fit2.sea.ets = ets(log(data.ts+const), model = "AAA", damped = TRUE)
summary(fit2.sea.ets) 
checkresiduals(fit2.sea.ets)

# much better residuals, with possible outliers in 2005, 2006, 2016
# ACF lag = 0 is great
# Not exactly normal residuals, but not bad
# Ljung box test is significant!

fit3.sea.ets = ets((data.ts+12), model = "MAA")
summary(fit3.sea.ets)
checkresiduals(fit3.sea.ets)
# Same as above, more normal. Possible seasonality

fit4.sea.ets = ets((data.ts+12), model = "MAA", damped = TRUE)
summary(fit4.sea.ets)
checkresiduals(fit4.sea.ets)

fit5.sea.ets = ets((data.ts+12), model = "MMM")
summary(fit5.sea.ets)
checkresiduals(fit5.sea.ets)

# - ACF Significantly more lags

fit6.sea.ets = ets((data.ts+12), model = "MMM", damped = TRUE)
summary(fit6.sea.ets)
checkresiduals(fit6.sea.ets)

# - ACF Significantly more lags ~6


fit.auto = ets((data.ts+12))
summary(fit.auto) 

checkresiduals(fit.auto)

# - ACF lag 2
# - Possible seasonality

plot(forecast(fit.auto), ylab="TODO",plot.conf=FALSE, type="l", xlab="Year")
# - Model looks like a good fit
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# TODO:
plot(fit1.ses, type="l", ylab="Fuel price", xlab="Year", 
     fcol="white", plot.conf=FALSE)
lines(fitted(fit1.ses), col="blue") 
lines(fitted(fit2.holt), col="red")
lines(fitted(fit3.holt), col="green")
# lines(fitted(fit4.holt), col="cyan")
lines(fit1.ses$mean, col="blue", type="l") 
lines(fit2.holt$mean, col="red", type="l")
lines(fit3.holt$mean, col="green", type="l")
lines(fit4.holt$mean, col="brown", type="l")
legend("topleft", lty=1, col=c("black","blue","red","green","cyan"), 
       c("Data","SES", "Holt's linear trend", "Exponential trend","Additive damped trend"))



# c) Select the best model according to one of the model selection criteria and display original series, fits and forecasts within the same time series plot over the best model you have chosen. Please articulate your findings by commenting on the goodness of fit and forecasts.
# 

# we returned similar AIC values for most models in the loop, so that wasn't conclusive

# Best model based on Ljung Box test, is the only one that is significant.
# fit2.sea.ets = ets(log(data.ts+const), model = "AAA", damped = TRUE)
# - Model appears to have a high goodness of fit
# State space had better goodness of fit


# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# 2. The yearly amount of CO2 generated by wheat production in a town between 1930 and 2018  is given HERE. (30 marks)
# 
# It's known that a new adaptive practice for wheat production has started to be applied in 1989 in this town. As a result, CO2 emissions significantly increased immediately in 1990 in this town. 

# Please fit a model to the given series and find forecasts of CO2 for the next 10 years. Then, display your fits and forecasts in a plot.
# 
#  
rm(list = ls()) 
# cat("\014") # clear everything

tsStart = c(1930) # TODO
default_ylab = 'CO2 generated by wheat production' # TODO
default_xlab = 'time'

dataQ2 <- read_csv(
  '~/code/data-science/datasets/forecasting/dataQ2.csv',
  col_names = FALSE
)

# convertToTimeseries(data, tsStart)
data.ts <- ts(
  dataQ2,
  start = tsStart,
  freq = 1
);

plot(data.ts)

# Check for seasonality with a couple of functions:

isSeasonal(data.ts)
find.freq(data.ts)

# No seasonality detected


doDiffAndPlot(data.ts)

doDiffAndPlot(data.ts, 1)

# - Diff 1 cleans up data significantly, with minimal lags, and removes  decay from ACF plot.

# FORECASTING
# Find the intonation point:
plot(
  data.ts, 
  type = 'l', 
  xlim = c(1986,1992)
)
# Clear change-point at 1989

doDiffAndPlot(data.ts, 0, F, F)
doDiffAndPlot(data.ts, 1)
# Diff of 1 significantly cleans up data


fit.x12 = x12(data.ts)
plot(fit.x12 , sa=TRUE , trend=TRUE)

# Create data after change-point for forecasting:
yearPoint1989 <- 1989 - 1930 # 59
dataMinusChangePoint.ts <- data.ts[yearPoint1989:89]


# - ACF lag 2
# - Possible seasonality

plot(forecast(fit.auto), ylab="TODO",plot.conf=FALSE, type="l", xlab="Year")
# - Model looks like a good fit
#

# ################################################

q2fit1.ses <- ses(dataMinusChangePoint, initial="simple", h=8) 
summary(fit1.ses)
checkresiduals(fit1.ses)

# - skewed data
# -----------------------------

q2fit1.holt <- holt(dataMinusChangePoint, initial="simple", h=8) 
summary(fit1.holt)
checkresiduals(fit1.holt)

# - Residuals include seasonal lag
# - exponential declining trend in ACF
# - Non normality in residuals - skewed
# 
q2fit2.holt <- holt(dataMinusChangePoint, initial="simple", h=8) # Let the software estimate both alpha and beta
summary(fit2.holt)
checkresiduals(fit2.holt)

q2fit3.holt <- holt(dataMinusChangePoint, initial="simple", exponential=TRUE, h=8) # Fit with exponential trend
summary(fit3.holt)
checkresiduals(fit3.holt)

# - Residuals have clear pattern
# - Include exponentially declining trend
# - Not normality
# - ACF show exponential decay, multiple lags

q2fit4.holt <- holt(dataMinusChangePoint, damped=TRUE, initial="simple", h=8) # Fit with additive damped trend
summary(fit4.holt)
checkresiduals(fit4.holt)

# - exponential is way off, and can be discarded
# Other's all fit reasonabily well.
# -----------------------------


q2fit1.sea = hw(dataMinusChangePoint,
  seasonal="additive", 
  h=8*frequency(dataMinusChangePoint)
)
summary(fit1.sea) 
checkresiduals(fit1.sea)
# - Significantly better, lag 1 for ACF
# - Residuals appear mostly normal
# - Still capture seasonality
# 
q2fit2.sea = hw(dataMinusChangePoint,seasonal="additive", damped = TRUE, h=8*frequency(dataMinusChangePoint))
summary(fit2.sea) # Best fit, best time series plot for residuals
checkresiduals(fit2.sea)

# - Similar as fit1, with lag 2

# We add a constant to be able to fit multiplicatie model with negative or zero values
q2fit3.sea = hw(min(dataMinusChangePoint+50),seasonal="multiplicative", h=8*frequency(dataMinusChangePoint))
summary(fit3.sea) 
checkresiduals(fit3.sea)
# provides the error:
# Error in hw(min(dataMinusChangePoint + 50), seasonal = "multiplicative", h = 5 * frequency(dataMinusChangePoint)): The time series should have frequency greater than 1.
# Traceback:
# 1. hw(min(dataMinusChangePoint + 50), seasonal = "multiplicative", h = 5 * frequency(dataMinusChangePoint))
# 2. stop("The time series should have frequency greater than 1.")


q2fit4.sea = hw((dataMinusChangePoint+50),seasonal="multiplicative",damped = TRUE, h=8*frequency(dataMinusChangePoint))
summary(fit4.sea) 
checkresiduals(fit4.sea)

# - ACF lag 2, normal residuals, shows some possible seasonality

q2fit5.sea = hw((dataMinusChangePoint+50),seasonal="multiplicative",damped = FALSE, exponential = TRUE, h=8*frequency(dataMinusChangePoint))
summary(fit5.sea) 
checkresiduals(fit5.sea)

# - ACF lag 2, normal residuals, shows some possible seasonality


q2fit5.hw <- hw(dataMinusChangePoint,seasonal="additive", h=5*frequency(dataMinusChangePoint))
summary(fit5.hw) 
checkresiduals(fit5.hw)

q2fit6.hw <- hw(dataMinusChangePoint,seasonal="additive",damped = TRUE, h=5*frequency(dataMinusChangePoint))
summary(fit6.hw)
checkresiduals(fit6.hw)

q2fit7.hw <- hw(dataMinusChangePoint,seasonal="multiplicative", h=5*frequency(dataMinusChangePoint))
summary(fit7.hw)
checkresiduals(fit7.hw)

q2fit8.hw <- hw(dataMinusChangePoint,seasonal="multiplicative",exponential = TRUE, h=5*frequency(dataMinusChangePoint))
summary(fit8.hw)
checkresiduals(fit8.hw)

q2fit1.etsA = ets(dataMinusChangePoint, model="ANN")
summary(fit1.etsA)
checkresiduals(fit1.etsA)

q2fit1.etsM = ets(dataMinusChangePoint, model="MNN")
summary(fit1.etsM)
checkresiduals(fit1.etsM) # Least autocorrelated - BG test

q2fit2.etsA = ets(dataMinusChangePoint, model="AAN")
summary(fit2.etsA)
checkresiduals(fit2.etsA)

q2fit2.etsM = ets(dataMinusChangePoint, model="MAN", damped = TRUE)
summary(fit2.etsM)
checkresiduals(fit2.etsM)

q2fit3.etsA = ets(dataMinusChangePoint, model="AAA")
summary(fit3.etsA)
checkresiduals(fit3.etsA)

q2fit3.etsM = ets(dataMinusChangePoint, model="MAA")
summary(fit3.etsM)
checkresiduals(fit3.etsM) # By visual checks residuals of this model is less correlated.

q2fit4.etsM = ets(dataMinusChangePoint, model="MAM")
summary(fit4.etsM)
checkresiduals(fit4.etsM)

q2fit5 = ets(dataMinusChangePoint)
summary(fit5)
checkresiduals(fit5) # Autofit actually finds the fit1.etsM which is the least autocorrelated - BG test

plot(forecast(fit1.etsM), ylab="Fuel dataMinusChangePoint",plot.conf=FALSE, type="l", xlab="Year")

plot(forecast(fit3.etsM), ylab="Fuel dataMinusChangePoint",plot.conf=FALSE, type="l", xlab="Year")

# TODO: cleanup model numbers

# -----------------------------

models <- c(
q2fit1.ses,
q2fit1.holt,
q2fit2.holt,
q2fit3.holt,
q2fit4.holt,
q2fit1.sea,
q2fit2.sea,
q2fit3.sea,
q2fit4.sea,
q2fit5.sea,
q2fit5.hw,
q2fit6.hw,
q2fit7.hw,
q2fit8.hw,
q2fit1.etsA,
q2fit1.etsM,
q2fit2.etsA,
q2fit2.etsM,
q2fit3.etsA,
q2fit3.etsM,
q2fit4.etsM,
q2fit5,
q2fit1.sea.ets,
q2fit2.sea.ets,
q2fit3.sea.ets,
q2fit4.sea.ets,
q2fit5.sea.ets,
q2fit6.sea.ets,
)

plot(fit1.ses, type="l", ylab="ABS dataMinusChangePoint", xlab="Year", 
     fcol="white", plot.conf=FALSE)
for (i in models) {
    lines(i)
}
legend("topleft", lty=1, 
col=c("black","blue","red","green","cyan"), model)


# 
# b) Fit at least three state-space models to this series. One of them must include multiplicative errors. Please articulate your findings by commenting on the outputs.
# 

# State Space ====================================

min(dataMinusChangePoint)
const = 12

errorTypes = c('A', 'M', 'Z')
trendTypes = c('N','A','M', 'Z') 
seasonTypes = c('N','A','M', 'Z')

for (i in errorTypes) {
  for (j in trendTypes) {
    for (k in seasonTypes) {
      out = tryCatch({
        modelType <- paste0(i,j,k)
        model = ets(dataMinusChangePoint, model=modelType)
        modelOut <- assign(
        paste0('fit.', modelType, ".ets"), model, envir = .GlobalEnv);
        # ets(dataMinusChangePoint, model = model)
        # cat(modelOut, '\n')
        print(modelType)
        print(modelName[4])
        print(modelName)
        if ()
      },
      error = function(e) print("No results for this test!"))
    # }
    # return(list(lambda = BC.lam,p.value = BC.y))
    }
  }
}

# Lowest AIC is 630.6722, 




q2fit1.sea.ets = ets(dataMinusChangePoint, model = "AAA")
summary(fit1.sea.ets)

checkresiduals(fit1.sea.ets)


q2fit2.sea.ets = ets(log(dataMinusChangePoint+const), model = "AAA", damped = TRUE)
summary(fit2.sea.ets) 
checkresiduals(fit2.sea.ets)

# much better residuals, with possible outliers in 2005, 2006, 2016
# ACF lag = 0 is great
# Not exactly normal residuals, but not bad
# Ljung box test is significant!

q2fit3.sea.ets = ets((dataMinusChangePoint+12), model = "MAA")
summary(fit3.sea.ets)
checkresiduals(fit3.sea.ets)
# Same as above, more normal. Possible seasonality

q2fit4.sea.ets = ets((dataMinusChangePoint+12), model = "MAA", damped = TRUE)
summary(fit4.sea.ets)
checkresiduals(fit4.sea.ets)

q2fit5.sea.ets = ets((dataMinusChangePoint+12), model = "MMM")
summary(fit5.sea.ets)
checkresiduals(fit5.sea.ets)

# - ACF Significantly more lags

q2fit6.sea.ets = ets((dataMinusChangePoint+12), model = "MMM", damped = TRUE)
summary(fit6.sea.ets)
checkresiduals(fit6.sea.ets)

# - ACF Significantly more lags ~6


q2fit.auto = ets((dataMinusChangePoint+12))
summary(fit.auto) 

checkresiduals(fit.auto)


#  
# 
#  
# 
# To submit your answers for marking, follow the steps below:
# 
# - Write your R script in R-Studio,
# 
# - Run it and make sure that your R Script runs without any problem,
# 
# - Write your interpretations after each relevant line in your R script after a "#",
# 
# - When you are ready to submit your answer, please copy your script from R-# Studio and paste it into the text box in Canvas.
# 
# Good luck!
# 
