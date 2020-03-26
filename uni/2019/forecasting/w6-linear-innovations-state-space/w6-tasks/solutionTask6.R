library(dynlm)
library(ggplot2)
library(AER)
library(Hmisc)
library(forecast)
library(x12)
library(dLagM)
library(TSA)
library(readr)
library(forecast)

# TASK 1
par(mfrow=c(1,1))
gold = read_csv("~/Documents/MATH1307_Forecasting/Tasks/Task 6/ausOlympics.csv")
gold1 = ts(gold[1:5,2])
plot(gold1)

fit.ses1 = ses(gold1)
summary(fit.ses1)

gold[6,2] = 1.573825 # Read from the output of ses()
gold2 = ts(gold[1:11,2])
plot(gold2)

fit.ses2 = ses(gold2)
summary(fit.ses2)
checkresiduals(fit.ses2)

fit.ANN2 = ets(gold2, model = "ANN")
summary(fit.ANN2) # Best in terms of MASE
checkresiduals(fit.ANN2) # REsidual diagnostics are all similar

fit.MNN2 = ets(gold2+0.001, model = "MNN")
summary(fit.MNN2)
checkresiduals(fit.MNN2)

frc2 = forecast(fit.ANN2)
frc2

gold[12:13,2] = 1.41618
gold3 = ts(gold[,2])
plot(gold3)

fit.holt3 = holt(gold3)
summary(fit.holt3) # MASE = 0.9787968
checkresiduals(fit.holt3)

fit.holt.dmp3 = holt(gold3, damped = TRUE)
summary(fit.holt.dmp3) # MASE = 0.9706257 Smallest MASE
checkresiduals(fit.holt.dmp3)
  
fit.holt.exp3 = holt(gold3+0.0001, exponential = TRUE)
summary(fit.holt.exp3) # MASE = 1.008822
checkresiduals(fit.holt.exp3) # Problematic residual diagnostics

fit.AAN3 = ets(gold3, model = "AAN")
summary(fit.AAN3)# MASE = 0.9787988
checkresiduals(fit.AAN3)

fit.AAdN3 = ets(gold3, model = "AAN", damped = TRUE)
summary(fit.AAdN3)# MASE = 0.9706257 Smallest MASE - one them can be taken
checkresiduals(fit.AAdN3)

fit.MAN3 = ets(gold3+0.001, model = "MAN")
summary(fit.MAN3)# MASE = 0.9907215
checkresiduals(fit.MAN3)

fit.MAdN3 = ets(gold3+0.001, model = "MAN", damped = TRUE)
summary(fit.MAdN3)# MASE = 1.002406
checkresiduals(fit.MAdN3)

fit.MMdN3 = ets(gold3+0.001, model = "MMN", damped = TRUE)
summary(fit.MMdN3)# MASE = 
checkresiduals(fit.MMdN3)

fit.auto = ets(gold3)
summary(fit.auto)# MASE = 1.097428
checkresiduals(fit.auto)

frc.holt = forecast(fit.AAdN3)
plot(gold3+0.0001,xlim = c(0,40))
lines(frc.holt$mean, col = "Blue")


# TASK 2
employed <- read_csv("~/Documents/MATH1307_Forecasting/Tasks/Task 6/employed.csv")
employed = ts(employed$employed, start = c(1978,2), frequency = 12)

plot(employed)

acf(employed, lag.max = 60, main = "Sample ACF plot of employment series")

employed.diff = diff(employed)
acf(employed.diff, lag.max = 60, main = "Sample ACF plot of the first difference of employment series")
# There is a repeating pattern implying the existence of seasonality

employment.x12 = x12(employed.diff)
plot(employment.x12, sa = TRUE, trend = TRUE)

fit.stl = stl(employed,  t.window=15, s.window="periodic", robust=TRUE)
plot(fit.stl)
fit.employed.trend = fit.stl$time.series[,"trend"] # Extract the trend component from the output
employed.trend.adjusted = employed - fit.employed.trend

employment.x12.ta = x12(employed.trend.adjusted)
plot(employment.x12.ta, sa = TRUE, trend = TRUE)

# After removing the trend both ways show the existence of seasonality.

fit.hw.add = hw(employed, seasonal = "additive", h = 2*12)
summary(fit.hw.add)
checkresiduals(fit.hw.add)
# Seasonality remains in the residuals (significant lag 12). Not really successful to deal with the seasonality

fit.hw.mult = hw(employed, seasonal = "multiplicative", h = 2*12)
summary(fit.hw.mult)
checkresiduals(fit.hw.mult)
# There is no seasonality in the residuals but still significant autocorrelations
# AIC     AICc      BIC 
# 5481.885 5483.227 5552.626 
# 
# Error measures:
#                  ME     RMSE      MAE       MPE      MAPE      MASE     ACF1
# Training set 0.228513 14.28893 11.16299 0.0101023 0.5131299 0.2273902 0.103852

fit.hw.add.dmp = hw(employed, seasonal = "additive", damped = TRUE,  h = 2*12)
summary(fit.hw.add.dmp)
checkresiduals(fit.hw.add.dmp)
# Seasonality remains in the residuals. Not really successful to deal with the seasonality


fit.hw.mult.dmp = hw(employed, seasonal = "multiplicative",damped = TRUE, h = 2*12)
summary(fit.hw.mult.dmp)
checkresiduals(fit.hw.mult.dmp)
# There is no seasonality in the residuals but still significant autocorrelations
# AIC     AICc      BIC 
# 5456.515 5458.018 5531.417 
# 
# Error measures:
#                  ME     RMSE      MAE      MPE      MAPE     MASE       ACF1
# Training set 1.254401 14.02942 10.83966 0.052943 0.4952056 0.220804 0.08741187

fit.hw.mult.exp = hw(employed, seasonal = "multiplicative", exponential = TRUE, h = 2*12)
summary(fit.hw.mult.exp)
checkresiduals(fit.hw.mult.exp)
# Nearly no autocorrelation left on in the residuals. 
# Residual time series plot looks nearly random and residaul histogram looks symmetric around 0.
# AIC     AICc      BIC 
# 5477.837 5479.179 5548.577 
# 
# Error measures:
#                   ME    RMSE      MAE        MPE      MAPE      MASE       ACF1
# Training set 0.4097163 14.2633 11.12577 0.02324744 0.5095267 0.2266321 0.04816132


fit.ANA = ets(employed, model = "ANA")
summary(fit.ANA)
checkresiduals(fit.ANA)
# Seasonality remains in the residuals (significant lag 12). Not really successful to deal with the seasonality

fit.AAA = ets(employed, model = "AAA")
summary(fit.AAA)
checkresiduals(fit.AAA)
# Seasonality remains in the residuals (significant lag 12). Not really successful to deal with the seasonality


fit.AAdA = ets(employed, model = "AAA", damped = TRUE)
summary(fit.AAdA)
checkresiduals(fit.AAdA)
# Seasonality remains in the residuals (significant lag 12). Not really successful to deal with the seasonality


fit.MNA = ets(employed, model = "MNA")
summary(fit.MNA)
checkresiduals(fit.MNA)
# Seasonality remains in the residuals (significant lag 12). Not really successful to deal with the seasonality


fit.MNM = ets(employed, model = "MNM")
summary(fit.MNM)
checkresiduals(fit.MNM)
# There is no seasonality in the residuals but still significant autocorrelations
# AIC     AICc      BIC 
# 5583.204 5584.252 5645.622 
# 
# Training set error measures:
#                  ME    RMSE      MAE       MPE      MAPE      MASE     ACF1
# Training set 4.779352 15.7376 12.16943 0.2000103 0.5588745 0.2478915 0.163585

fit.MAA = ets(employed, model = "MAA")
summary(fit.MAA)
checkresiduals(fit.MAA)
# Seasonality remains in the residuals (significant lag 12). Not really successful to deal with the seasonality


fit.MAdA = ets(employed, model = "MAA", damped = TRUE)
summary(fit.MAdA)
checkresiduals(fit.MAdA)
# Seasonality remains in the residuals (significant lag 12). Not really successful to deal with the seasonality

frc.hw.mult.exp = forecast(fit.hw.mult.exp$model) # fit.hw.mult.exp is the only model satisfy residual checks although its MASE is the second best
plot(frc.hw.mult.exp)
