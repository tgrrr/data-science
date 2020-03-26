
library(TSA)
library(fUnitRoots)
library(forecast)
library(CombMSC)
library(lmtest)
library(fGarch)
sort.score <- function(x, score = c("bic", "aic")){
  if (score == "aic"){
    x[with(x, order(AIC)),]
  } else if (score == "bic") {
    x[with(x, order(BIC)),]
  } else {
    warning('score = "x" only accepts valid arguments ("aic","bic")')
  }
}
residual.analysis <- function(model, std = TRUE){
  library(TSA)
  library(FitAR)
  if (std == TRUE){
    res.model = rstandard(model)
  }else{
    res.model = residuals(model)
  }
  par(mfrow=c(3,2))
  plot(res.model,type='o',ylab='Standardised residuals', main="Time series plot of standardised residuals")
  abline(h=0)
  hist(res.model,main="Histogram of standardised residuals")
  qqnorm(res.model,main="QQ plot of standardised residuals")
  qqline(res.model, col = 2)
  acf(res.model,main="ACF of standardised residuals")
  print(shapiro.test(res.model))
  k=0
  LBQPlot(res.model, lag.max = length(model$residuals)-1 , StartLag = k + 1, k = 0, SquaredQ = FALSE)
}
#--- Task 1 ---

NMFS_Landings <- read.csv("~/Desktop/MATH1318/Week2/Task2/NMFS_Landings.csv")
# NMFS_Landings <- read.csv("~/Documents/Haydar/MATH1318_TimeSeries/Tasks/Module2/NMFS_Landings.csv")
class(NMFS_Landings)
head(NMFS_Landings)
# Convert data into a time series object
NMFS_Landings.ts = matrix(NMFS_Landings$Metric_Tons, nrow = 25, ncol = 12)
NMFS_Landings.ts = as.vector(t(NMFS_Landings.ts))
NMFS_Landings.ts = ts(NMFS_Landings.ts,start=c(1991,1), end=c(2015,12), frequency=12)
class(NMFS_Landings.ts)

plot(NMFS_Landings.ts,ylab='Landings in metric tons',xlab='Year',type='o', main = "Time series plot of monthly landings in metric tons.")
# There are two different periods of time that the series are bouncing around two different mean levels. Although there is not a trend for each 
# time period, as a whole the mean level is changing through the time. Seasonality and changing variance are obvious from the series. 
# To see the autocorrelation structure clearly, we need to filtrate out the effect of seasonality.

par(mfrow=c(1,2))
acf(NMFS_Landings.ts,  lag.max = 36,main="The sample ACF of landings series")
pacf(NMFS_Landings.ts,  lag.max = 36,main="The sample PACF of landings series")

# Seasonality and existence of trend are obvious from the ACF and PACF plots

# First fit a plain model with only the first seasonal difference with order D = 1 
# and see if we can get rid of the seasonal trend effect
# by inspecting the autocorrelation structure of the residuals.
#                                          p,d,q                        P,D,Q
m1.landing = arima(NMFS_Landings.ts,order=c(0,0,0),seasonal=list(order=c(0,1,0), period=12))
res.m1 = residuals(m1.landing);  
par(mfrow=c(1,1))
plot(res.m1,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m1, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m1, lag.max = 36, main = "The sample PACF of the residuals")
# From the time series plot, we can conclude that we got rid of the trend. Seasonal autocorrelations are seen clearly in 
# ACF and PACF now at the lags corresponding to the periods. 
# We have one significant correlation at the first seasonal lag in both ACF and PACF. 

#So, we will add the SARMA(1,1) component and see if we get rid of seasonal component.
m2.landing = arima(NMFS_Landings.ts,order=c(0,0,0),seasonal=list(order=c(1,1,1), period=12))
res.m2 = residuals(m2.landing);  
par(mfrow=c(1,1))
plot(res.m2,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m2, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m2, lag.max = 36, main = "The sample PACF of the residuals")
# Although we have one significant correlation at the first seasonal lag in PACF, we can conclude that the seasonality is filtrated out.
# The significant correlation in PACF would be due to the change point in the series.
# Now, we will specify the orders of ARIMA component. The first ordinary correlation in ACF is highly significant, and after a gap, 
# there are four significant correlations before the first seasonal lag. Also, there is a jagged pattern in PACF. This is an indication of
# trend but it's not apparent. This would be due to the highly changing variance. So, it would help to apply a transformation at this stage. 

# So, we will apply the log transformation and see if we can see the trend more clearly.
m3.landing = arima(log(NMFS_Landings.ts),order=c(0,0,0),seasonal=list(order=c(1,1,1), period=12))
res.m3 = residuals(m3.landing);  
par(mfrow=c(1,1))
plot(res.m3,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m3, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m3, lag.max = 36, main = "The sample PACF of the residuals")
# The variation in the residuals decreased after the transformation. We have a very high correlation at the first lag of PACF and nearly all the 
# correlations before the first seasonal lag are significant in ACF. So, we need to take the first ordinary difference to get rid of this trend 
# effect before going on with the specification of ARMA orders.

m4.landing = arima(log(NMFS_Landings.ts),order=c(0,1,0),seasonal=list(order=c(1,1,1), period=12))
res.m4 = residuals(m4.landing);  
par(mfrow=c(1,1))
plot(res.m4,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m4, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m4, lag.max = 36, main = "The sample PACF of the residuals")
# In ACF, there are 5 significant lags and the significant correlations in PACF could be seen as a decreasing pattern 
# or we can set p = 6. So, we can add MA component
# up to order 5. We can use EACF over the residuals.

eacf(res.m4)

# The tentative models are specified as 
# SARIMA(0,1,4)x(1,1,1)_12
# SARIMA(0,1,5)x(1,1,1)_12
# SARIMA(6,1,4)x(1,1,1)_12
# From the EACF, we will include AR(1) order as well.
# SARIMA(1,1,4)x(1,1,1)_12
# And for overdifferencing # SARIMA(0,1,6)x(1,1,1)_12 and SARIMA(2,1,4)x(1,1,1)_12 will be fitted

m5_014.landing = arima(log(NMFS_Landings.ts),order=c(0,1,4),seasonal=list(order=c(1,1,1), period=12),method = "ML")
coeftest(m5_014.landing)
res.m5 = residuals(m5_014.landing);  
par(mfrow=c(1,1))
plot(res.m5,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m5, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m5, lag.max = 36, main = "The sample PACF of the residuals")

m5_015.landing = arima(log(NMFS_Landings.ts),order=c(0,1,5),seasonal=list(order=c(1,1,1), period=12))
coeftest(m5_015.landing)
res.m5 = residuals(m5_015.landing);  
par(mfrow=c(1,1))
plot(res.m5,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m5, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m5, lag.max = 36, main = "The sample PACF of the residuals")

m5_615.landing = arima(log(NMFS_Landings.ts),order=c(6,1,5),seasonal=list(order=c(1,1,1), period=12))
coeftest(m5_615.landing)
res.m5 = residuals(m5_615.landing);  
par(mfrow=c(1,1))
plot(res.m5,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m5, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m5, lag.max = 36, main = "The sample PACF of the residuals")

m5_114.landing = arima(log(NMFS_Landings.ts),order=c(1,1,4),seasonal=list(order=c(1,1,1), period=12))
coeftest(m5_114.landing)
res.m5 = residuals(m5_114.landing);  
par(mfrow=c(1,1))
plot(res.m5,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m5, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m5, lag.max = 36, main = "The sample PACF of the residuals")

m5_016.landing = arima(log(NMFS_Landings.ts),order=c(0,1,6),seasonal=list(order=c(1,1,1), period=12))
coeftest(m5_016.landing)
res.m5 = residuals(m5_016.landing);  
par(mfrow=c(1,1))
plot(res.m5,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m5, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m5, lag.max = 36, main = "The sample PACF of the residuals")

m5_214.landing = arima(log(NMFS_Landings.ts),order=c(2,1,4),seasonal=list(order=c(1,1,1), period=12))
coeftest(m5_214.landing)
res.m5 = residuals(m5_214.landing);  
par(mfrow=c(1,1))
plot(res.m5,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m5, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m5, lag.max = 36, main = "The sample PACF of the residuals")


sc.AIC=AIC(m5_014.landing, m5_015.landing, m5_615.landing, m5_114.landing)
sc.BIC=AIC(m5_014.landing, m5_015.landing, m5_615.landing, m5_114.landing, k = log(length(NMFS_Landings.ts)))

sort.score(sc.AIC, score = "aic")
sort.score(sc.BIC, score = "aic")

residual.analysis(model = m5_014.landing)
residual.analysis(model = m5_015.landing)
residual.analysis(model = m5_114.landing)
residual.analysis(model = m5_615.landing)

m5_014.landing = Arima(log(NMFS_Landings.ts),order=c(0,1,4),seasonal=list(order=c(1,1,1), period=12),method = "ML")
preds1 = forecast(m5_014.landing, h = 24)
plot(preds1)

m5_615.landing = Arima(log(NMFS_Landings.ts),order=c(6,1,5),seasonal=list(order=c(1,1,1), period=12),method = "ML")
preds1 = forecast(m5_615.landing, h = 24)
plot(preds1)

m5_114.landing = Arima(log(NMFS_Landings.ts),order=c(1,1,4),seasonal=list(order=c(1,1,1), period=12),method = "ML")
preds2 = forecast(m5_114.landing, h = 36)
plot(preds2)


# ------------- Taking the first 8 years of data as the first part. -----------------

par(mfrow=c(1,1))
NMFS_Landings.p1 = ts(NMFS_Landings.ts[1:96],start=c(1991,1), frequency=12)

plot(NMFS_Landings.p1,ylab='Landings in metric tons',xlab='Year',type='o', main = "Time series plot of monthly landings in metric tons for the first 8 years.")

par(mfrow=c(1,2))
acf(NMFS_Landings.p1, lag.max = 36,main="The sample ACF of landings series")
pacf(NMFS_Landings.p1, lag.max = 36,main="The sample PACF of landings series")


# Start with the first seasoal difference
m1.landing = arima(log(NMFS_Landings.p1),order=c(0,0,0),seasonal=list(order=c(0,1,0), period=12))
res.m1 = residuals(m1.landing);  
par(mfrow=c(1,1))
plot(res.m1,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m1, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m1, lag.max = 36, main = "The sample PACF of the residuals")
# We got rid of seasonal effect as there is no significant correlation at seasonal lags in ACF and PACF both.
# And there is no sign of an ordinary trend as well. So we will go on with specification of ARMA component. 

# We have one significant correlation in ACF and one significant and one slightly significant correlation in PACF. So can think of an ARMA(1,1) model.
m2.landing = arima(NMFS_Landings.p1,order=c(1,0,1),seasonal=list(order=c(0,1,0), period=12))
res.m2 = residuals(m2.landing);  
par(mfrow=c(1,1))
plot(res.m2,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m2, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m2, lag.max = 36, main = "The sample PACF of the residuals")
# We got the white noise series with ARMA(1,1) component.
# For overfitting, we will consider ARMA(2,1) and ARMA(1,2). 

m2_201.landing = arima(NMFS_Landings.p1,order=c(2,0,1),seasonal=list(order=c(0,1,0), period=12))
m2_102.landing = arima(NMFS_Landings.p1,order=c(1,0,2),seasonal=list(order=c(0,1,0), period=12))


coeftest(m2.landing)
          
coeftest(m2_201.landing)
coeftest(m2_102.landing)
# For overfitting the added coefficients are insignificant at 5% level of significant.

residual.analysis(model = m2.landing)

m2.landing = Arima(NMFS_Landings.p1,order=c(1,0,1),seasonal=list(order=c(0,1,0), period=12))
future = forecast(m2.landing, h = 48)
plot(future)


# ------------ Taking the second period of data as the first part. -----------

NMFS_Landings.p2 =  ts(NMFS_Landings.ts[97:300],start=c(1999,1), frequency=12)

plot(NMFS_Landings.p2,ylab='Landings in metric tons',xlab='Year',type='o', main = "Time series plot of monthly landings in metric tons for the first 8 years.")
# Notice the changing variance in this plot. So, a log transformation would be useful.

par(mfrow=c(1,2))
acf(NMFS_Landings.p2,lag.max = 36, main="The sample ACF of landings series")
pacf(NMFS_Landings.p2,lag.max = 36, main="The sample PACF of landings series")



# Start with the first seasoal difference
m1.landing = arima(log(NMFS_Landings.p2),order=c(0,0,0),seasonal=list(order=c(0,1,0), period=12))
res.m1 = residuals(m1.landing);  
par(mfrow=c(1,1))
plot(res.m1,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m1, lag.max = 60, main = "The sample ACF of the residuals")
pacf(res.m1, lag.max = 60, main = "The sample PACF of the residuals")
# The highly significant first seasonal lag in ACF and slowly decreasing seasonal lags in PACF indicates a SMA(1) model.

m2.landing = arima(NMFS_Landings.p2,order=c(0,0,0),seasonal=list(order=c(0,1,1), period=12))
res.m2 = residuals(m2.landing);  
par(mfrow=c(1,1))
plot(res.m2,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m2, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m2, lag.max = 36, main = "The sample PACF of the residuals")
# There is no seasonal effect left in the residuals. From the time series plot and ACF-PACF pair, we do not observe an ordinary trend. 
# We consider 3 significant ordinary lags in ACF and 2 significant ordinary lags in PACF for model specification.
# Tentative models are 
# SARIMA(2,0,3)x(0,1,1)_12
# SARIMA(2,0,2)x(0,1,1)_12

m3.landing = arima(NMFS_Landings.p2,order=c(2,0,3),seasonal=list(order=c(0,1,1), period=12))
coeftest(m3.landing) #AR parameters and one MA parameter are insignificant at 5% level of significance
res.m3 = residuals(m3.landing);  
par(mfrow=c(1,1))
plot(res.m3,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m3, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m3, lag.max = 36, main = "The sample PACF of the residuals")

m4.landing = arima(NMFS_Landings.p2,order=c(2,0,2),seasonal=list(order=c(0,1,1), period=12))
coeftest(m4.landing) # All parameters are significant at 5% level of significance.
# So, the model  SARIMA(2,0,3)x(0,1,1)_12 would be seen as an overfitting for  SARIMA(2,0,2)x(0,1,1)_12 model.
res.m4 = residuals(m4.landing);  
par(mfrow=c(1,1))
plot(res.m4,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m4, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m4, lag.max = 36, main = "The sample PACF of the residuals")
# Both models seem to be suitable in terms of residuals.


residual.analysis(model = m4.landing)

m4.landing = Arima(NMFS_Landings.p2,order=c(2,0,2),seasonal=list(order=c(0,1,1), period=12))
future = forecast(m2.landing, h = 48)
plot(future)


