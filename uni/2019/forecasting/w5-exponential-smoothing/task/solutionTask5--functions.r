# Module 5: Tasks
# Exponential smoothing methods

# ----------------------------------------------------------
library(TSA)
library(car)
library(dynlm)
library(Hmisc)
library(forecast)
library(xts)
library(readr)

# Task 2
# High-quality measurements of global sea level have been made since late 1992 by satellite altimeters. The series in file `SeaLevel.csv` shows the global mean sea level (mm) between January 1993 and August 2016 (http://www.cmar.csiro.au/sealevel/sl_hist_last_decades.html).

# ----------------------------------------------------------
data <- read_csv(
  '~/code/data-science-next/datasets/forecasting/seaLevel.csv',
  col_names = TRUE, 
)

data %>% head()
# data <- read.csv("~/Documents/MATH1307_Forecasting/Tasks/Task 5/SeaLevel.csv")
# data.ts = ts(data.ts$SeaLevel, start=c(1993,1), frequency = 12)

# - [ ] Display the series using suitable descriptive plots and draw inferences about the mechanism behind the series.

# ----------------------------------------------------------
# plot(data.ts, ylab="TODOThe global mean sea level (mm)", xlab= "Time", main="Time series plot for global mean sea level series.")
# Seasonality, trend and changing variance

# - [ ] Fit a set of suitable classical exponential smoothing methods and choose one of the models as the best fitting one within the set of tentative models considering diagnostic checking as well.

# ----------------------------------------------------------
# TODO why abs(min())?
data.ts2 = log(data.ts+abs(min(data.ts))+0.1)
plot(data.ts2, ylab="TODO", xlab= "Time", main="Time series plot for TODO")
# Log transformation did not help.

# --------------------------------------------------------

# TODO: function
# TODO: repeat about 5 times
  # createVariableNames

# We add a constant to be able to fit multiplicatie model with negative or zero values
doFitHw <- function (
  data.ts,
  # seasonalType= c("additive","multiplicative")[1],
  # constant = 0,
 ) {
   fit1.sea = hw(data.ts,
     seasonal="additive", 
     h=5*frequency(data.ts)
   )
   summary(fit1.sea) 
   checkresiduals(fit1.sea)

   fit2.sea = hw(data.ts,seasonal="additive", damped = TRUE, h=5*frequency(data.ts))
   summary(fit2.sea) # Best fit, best time series plot for residuals
   checkresiduals(fit2.sea)

    fit3.sea = hw(
      min(data.ts + constant),
      seasonal = seasonalType,
      h=5*frequency(data.ts))
    
    summary(fit3.sea) 
    checkresiduals(fit3.sea)
    
    fit4.sea = hw(
      (data.ts + constant),
      seasonal = seasonalType,
      damped = TRUE,
      h=5*frequency(data.ts))
    
    summary(fit4.sea) 
    checkresiduals(fit4.sea)
    
    fit5.sea = hw(
      (data.ts + constant),
      seasonal = seasonalType,
      damped = FALSE,
      exponential = TRUE,
      h=5*frequency(data.ts))
    
    summary(fit5.sea) 
    checkresiduals(fit5.sea)  
}

# doFitHw <- function (
#   data.ts,
#   seasonalType = "multiplicative"
#   constant = 0,
# )[1]
#  )

# return(list(first=1, second=2))


fit1.sea = hw(data.ts,
  seasonal="additive", 
  h=5*frequency(data.ts)
)
summary(fit1.sea) 
checkresiduals(fit1.sea)

fit2.sea = hw(data.ts,seasonal="additive", damped = TRUE, h=5*frequency(data.ts))
summary(fit2.sea) # Best fit, best time series plot for residuals
checkresiduals(fit2.sea)

# We add a constant to be able to fit multiplicatie model with negative or zero values
fit3.sea = hw(min(data.ts+50),seasonal="multiplicative", h=5*frequency(data.ts))
summary(fit3.sea) 
checkresiduals(fit3.sea)

fit4.sea = hw((data.ts+50),seasonal="multiplicative",damped = TRUE, h=5*frequency(data.ts))
summary(fit4.sea) 
checkresiduals(fit4.sea)

fit5.sea = hw((data.ts+50),seasonal="multiplicative",damped = FALSE, exponential = TRUE, h=5*frequency(data.ts))
summary(fit5.sea) 
checkresiduals(fit5.sea)

### State Space
# - [ ] Apply state-space versions of exponential smoothing methods focused on the previous task and select the best fitting model using model selection criteria and diagnostic checking results.

# ----------------------------------------------------------

# TODO: function
# TODO: repeat about 5 times
#  - twice for AAA, MAA, MMM

fit1.sea.ets = ets(data.ts, model = "AAA")
summary(fit1.sea.ets)
checkresiduals(fit1.sea.ets)

fit2.sea.ets = ets(log(data.ts+50), model = "AAA", damped = TRUE)
summary(fit2.sea.ets) # MASE = 0.4553113
checkresiduals(fit2.sea.ets)

fit3.sea.ets = ets((data.ts+50), model = "MAA")
summary(fit3.sea.ets)
checkresiduals(fit3.sea.ets)

fit4.sea.ets = ets((data.ts+50), model = "MAA", damped = TRUE)
summary(fit4.sea.ets)
checkresiduals(fit4.sea.ets)

fit5.sea.ets = ets((data.ts+50), model = "MMM")
summary(fit5.sea.ets)
checkresiduals(fit5.sea.ets)

fit6.sea.ets = ets((data.ts+50), model = "MMM", damped = TRUE)
summary(fit6.sea.ets)
checkresiduals(fit6.sea.ets)

# - [ ] Use the automatic model fitting feature of the forecast package and compare the results with those found in the previous two bullets in terms of the selected model, diagnostic check results and the accuracy of forecasts and model fitting.

# ----------------------------------------------------------
fit.auto = ets((data.ts+50))
summary(fit.auto) # BEST MASE = 0.4613409 but better time series plot of residuals, non of the models is able to remove autocorrelations in residuals.

# ----------------------------------------------------------
checkresiduals(fit.auto)

# ----------------------------------------------------------
plot(forecast(fit.auto), ylab="TODO",plot.conf=FALSE, type="l", xlab="Year")
