library(TSA)
library(fUnitRoots)
library(forecast)
library(CombMSC)
library(lmtest)
library(fGarch)
library(rugarch)
library(AID)


source('~/Documents/MATH1318_TimeSeries/Utility Functions/TSHandy.r')

sort.score <- function(x, score = c("bic", "aic")){
  if (score == "aic"){
    x[with(x, order(AIC)),]
  } else if (score == "bic") {
    x[with(x, order(BIC)),]
  } else {
    warning('score = "x" only accepts valid arguments ("aic","bic")')
  }
}

library(FSAdata) # For Example 1
library(TSA) # For Example 2
library(AID) # For the boxcoxnc() function
library(nortest)

BoxCoxSearch = function(y, lambda=seq(-3,3,0.01), 
                        m= c("sf", "sw","ad" ,"cvm", "pt", "lt", "jb"), plotit = T, verbose = T){
  N = length(m)
  BC.y = array(NA,N)
  BC.lam = array(NA,N)
  for (i in 1:N){
    if (m[i] == "sf"){
      wrt = "Shapiro-Francia Test"
    } else if (m[i] == "sw"){
      wrt = "Shapiro-Wilk  Test"
    } else if (m[i] == "ad"){
      wrt = "Anderson-Darling Test"
    } else if (m[i] == "cvm"){
      wrt = "Cramer-von Mises Test"
    } else if (m[i] == "pt"){
      wrt = "Pearson Chi-square Test"
    } else if (m[i] == "lt"){
      wrt = "Lilliefors Test"
    } else if (m[i] == "jb"){
      wrt = "Jarque-Bera Test"
    } 
    
    print(paste0("------------- ",wrt," -------------"))
    out = tryCatch({boxcoxnc(y, method = m[i], lam = lambda, lambda2 = NULL, plot = plotit, alpha = 0.05, verbose = verbose)
      BC.lam[i] = as.numeric(out$lambda.hat)}, 
      error = function(e) print("No results for this test!"))
    
  }
  return(list(lambda = BC.lam,p.value = BC.y))
}


residual.analysis <- function(model, std = TRUE,start = 2, class = c("ARIMA","GARCH","ARMA-GARCH")[1]){
  # If you have an output from arima() function use class = "ARIMA"
  # If you have an output from garch() function use class = "GARCH"
  # If you have an output from ugarchfit() function use class = "ARMA-GARCH"
  library(TSA)
  library(FitAR)
  if (class == "ARIMA"){
    if (std == TRUE){
      res.model = rstandard(model)
    }else{
      res.model = residuals(model)
    }
  }else if (class == "GARCH"){
    res.model = model$residuals[start:model$n.used]
  }else if (class == "ARMA-GARCH"){
    res.model = model@fit$residuals
  }else {
    stop("The argument 'class' must be either 'ARIMA' or 'GARCH' ")
  }
  par(mfrow=c(3,2))
  plot(res.model,type='o',ylab='Standardised residuals', main="Time series plot of standardised residuals")
  abline(h=0)
  hist(res.model,main="Histogram of standardised residuals")
  acf(res.model,main="ACF of standardised residuals")
  pacf(res.model,main="PACF of standardised residuals")
  qqnorm(res.model,main="QQ plot of standardised residuals")
  qqline(res.model, col = 2)
  print(shapiro.test(res.model))
  k=0
  LBQPlot(res.model, lag.max = 30, StartLag = k + 1, k = 0, SquaredQ = FALSE)
}


# ---- TREND MODELS ---
build <- read.csv("~/Desktop/MATH1318/Week12/buildingapproval.csv", col.names = FALSE)

build = ts(build,start=c(1983,7), end=c(2017,3),frequency=12) #

par(mfrow=c(1,1))
plot(build,type='o',main="Time series plot of total number of dwelling units by private sector")

plot(build,type='l',ylab='Sales')
points(y=build,x=time(build), pch=as.vector(season(build)))

par(mfrow=c(2,1))
acf(build)
pacf(build)
eacf(build)

model1 = lm(build~time(build)) # label the linear trend model as model1
summary(model1)

par(mfrow=c(1,1))
plot(build,type='o',ylab='y')
abline(model1)

residual.analysis(model1, std = TRUE,start = 1)

t = time(build)
t2 = t^2
model2 = lm(build~ t + t2) # label the quadratic trend model as model1
summary(model2)
par(mfrow=c(1,1))
plot(ts(fitted(model2)), ylim = c(min(c(fitted(model2), as.vector(build))), max(c(fitted(model2),as.vector(build)))),ylab='y',
     main = "Fitted quadratic curve.")
lines(as.vector(build),type="o")
residual.analysis(model2, std = TRUE,start = 1)

month.=season(build) # period added to improve table display and this line sets up indicators
model3=lm(build~month.,-1) # -1 removes the intercept term
summary(model3)
par(mfrow=c(1,1))
plot(ts(fitted(model3)), ylim = c(min(c(fitted(model3), as.vector(build))), max(c(fitted(model3),as.vector(build)))),ylab='y',
     main = "Fitted quadratic curve.",type='p')
lines(as.vector(build),type="o")
residual.analysis(model3, std = TRUE,start = 1)

sc.AIC = AIC(model1,model2,model3)
sort.score(sc.AIC, score = "aic")


#---- ARIMA MODELLING - Purchase Value ----

value <- read.csv("~/Desktop/MATH1318/Week12/purchaseValue.csv", col.names = FALSE)

value = ts(value,start=1976) #

par(mfrow=c(1,1))
plot(value,type='o',main="Time series plot of total purchase value")
# We observe trend, successive points. There is no seasonality and no certain sign of changeing variance.

par(mfrow=c(1,2))
acf(value)
pacf(value)

diff.value = diff(value,differences = 2)
par(mfrow=c(1,1))
plot(diff.value,type='o',ylab='Time series plot of the first difference of total purchase value')

ar(diff(diff.value))
adfTest(diff.value, lags = 4,  title = NULL,description = NULL)

# After detrending the sereis we observe, volatility clustering!

bc.search = BoxCoxSearch(y=value, lam=seq(-3,3,0.01), m= c("sf", "sw","ad" ,"cvm", "pt", "lt", "jb","ac"), plotit = T, verbose = T)

lambda = 0.17
BC.value = ((value^lambda)-1)/lambda

ar(diff(BC.value))
adfTest(BC.value, lags = 0,  title = NULL,description = NULL)

diff.value.BC = diff(BC.value,differences = 1)
ar(diff(diff.value.BC))
adfTest(diff.value.BC, lags = 3,  title = NULL,description = NULL)


par(mfrow=c(1,1))
plot(diff.value.BC,type='o',ylab='Time series plot of the first difference of total purchase value')

par(mfrow=c(1,2))
acf(diff.value.BC)
pacf(diff.value.BC)
# Time series plot, ACF and PACF do not show a clear trend. So I'll go on with the first difference.

eacf(diff.value.BC,ar.max = 5, ma.max = 5)
#{ARIMA(0,1,1), ARIMA(1,1,1)}

par(mfrow=c(1,1))
res = armasubsets(y=diff.value.BC,nar=5,nma=5,y.name='test',ar.method='ols')
plot(res)


# ARIMA(0,1,1)
model_011_css = arima(BC.value,order=c(0,1,1),method='CSS')
coeftest(model_011_css)

model_011_ml = arima(BC.value,order=c(0,1,1),method='ML')
coeftest(model_011_ml)

# ARIMA(1,1,1)
model_111_css = arima(BC.value,order=c(1,1,1),method='CSS')
coeftest(model_111_css)

model_111_ml = arima(BC.value,order=c(1,1,1),method='ML')
coeftest(model_111_ml)

residual.analysis(model_111_ml, std = TRUE,start = 1)

# What if we go on with the second difference

diff.value= diff(value,differences = 2)
ar(diff(diff.value))
adfTest(diff.value, lags = 4,  title = NULL,description = NULL)

par(mfrow=c(1,1))
plot(diff.value,type='o',ylab='Time series plot of the first difference of total purchase value')

par(mfrow=c(1,2))
acf(diff.value)
pacf(diff.value)
eacf(diff.value,ar.max = 5, ma.max = 5)

# ARIMA(1,2,0); ARIMA(1,2,1); ARIMA(2,2,1)

modelList <- list(c(1,2,0), c(1,2,1), c(2,2,1))
modelEstimation <- myCandidate(value, orderList = modelList, methodType = "ML")


modelEstimation$significanceTest

modelEstimation$IC

residual.analysis(modelEstimation$model[[1]], std = TRUE,start = 1)
residual.analysis(modelEstimation$model[[2]], std = TRUE,start = 1)
residual.analysis(modelEstimation$model[[3]], std = TRUE,start = 1)


abs.diff.value = abs(diff.value)
sqr.diff.value = diff.value^2

par(mfrow=c(1,2))
acf(abs.diff.value)
pacf(abs.diff.value)
eacf(abs.diff.value,ar.max = 5, ma.max = 5)
#{ARMA(1,2), ARMA(2,2)} ==> {GARCH(1,1), GARCH(2,2)}

par(mfrow=c(1,2))
acf(sqr.diff.value)
pacf(sqr.diff.value)
eacf(sqr.diff.value,ar.max = 5, ma.max = 5)
#{ARMA(2,1), ARMA(2,0)} ==> {GARCH(2,2)}


model2<-ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1, 1)), 
                   mean.model = list(armaOrder = c(1, 0), include.mean = FALSE), 
                   distribution.model = "norm")
m.2<-ugarchfit(spec=model2,data=diff.value)
# It is not possbile to apply GARCH models with a small dataset 

model_120_ml = arima(diff.value, order=c(1,0,0),method='ML')
res.m.120 = residuals(model_120_ml)

m.11 = garch(res.m.120,order=c(1,1),trace = FALSE)
m.11_2 = garchFit(formula = ~garch(1,1), data =res.m.120, algorithm = "lbfgsb" )
summary(m.11_2)
res = m.11_2@residuals
acf(res)
pacf(res)
par(mfrow=c(1,1))
plot(m.11_2@residuals)

#---- SARIMA MODELLING ---

jobs <- read.csv("~/Desktop/MATH1318/Week12//numberJobs.csv", col.names = FALSE)

jobs = ts(jobs,start=c(1980,1),end=c(2016,2),frequency = 4)

par(mfrow=c(1,1))
plot(jobs,type='o',main="Time series plot of the number jobs advertised")
par(mfrow=c(1,2))
acf(jobs)
pacf(jobs)
eacf(jobs)

m1.jobs = arima(jobs,order=c(0,0,0),seasonal=list(order=c(0,1,0), period=4))
res.m1 = residuals(m1.jobs);  
par(mfrow=c(1,1))
plot(res.m1,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m1, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m1, lag.max = 36, main = "The sample PACF of the residuals")


m2.jobs = arima(jobs,order=c(0,1,0),seasonal=list(order=c(0,1,0), period=4))
res.m2 = residuals(m2.jobs);  
par(mfrow=c(1,1))
plot(res.m2,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m2, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m2, lag.max = 36, main = "The sample PACF of the residuals")
#Significant seasonal lags

m3.jobs = arima(jobs,order=c(0,1,0),seasonal=list(order=c(2,1,1), period=4))
res.m3 = residuals(m3.jobs);  
par(mfrow=c(1,1))
plot(res.m3,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m3, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m3, lag.max = 36, main = "The sample PACF of the residuals")

eacf(res.m3)
# SARIMA(1,1,1)x(2,1,1)_4; SARIMA(1,1,2)x(2,1,1)_4; SARIMA(2,1,2)x(2,1,1)_4

m4.jobs = arima(jobs,order=c(1,1,1),seasonal=list(order=c(2,1,1), period=4))
res.m4 = residuals(m4.jobs);  
par(mfrow=c(1,1))
plot(res.m4,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m4, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m4, lag.max = 36, main = "The sample PACF of the residuals")

m5.jobs = arima(jobs,order=c(2,1,1),seasonal=list(order=c(2,1,1), period=4))
coeftest(m5.jobs )
res.m5 = residuals(m5.jobs);  
par(mfrow=c(1,1))
plot(res.m5,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m5, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m5, lag.max = 36, main = "The sample PACF of the residuals")

m6.jobs = arima(jobs,order=c(2,1,2),seasonal=list(order=c(2,1,1), period=4))
coeftest(m6.jobs )
res.m6 = residuals(m6.jobs);  
par(mfrow=c(1,1))
plot(res.m6,xlab='Time',ylab='Residuals',main="Time series plot of the residuals")
par(mfrow=c(1,2))
acf(res.m6, lag.max = 36, main = "The sample ACF of the residuals")
pacf(res.m6, lag.max = 36, main = "The sample PACF of the residuals")

coeftest(m4.jobs)
coeftest(m5.jobs)
coeftest(m6.jobs)

residual.analysis(m6.jobs, std = TRUE,start = 1)

sc.AIC = AIC(m4.jobs,m5.jobs,m6.jobs)
sort.score(sc.AIC, score = "aic")

m6.jobs_2 = Arima(jobs,order=c(2,1,2),seasonal=list(order=c(2,1,1), period=4))
future = forecast(m6.jobs_2, h = 24)
par(mfrow=c(1,1))
plot(future)


# --- GARCH MODELS ---

rate <- read.csv("~/Desktop/MATH1318/Week12//exchangeRate.csv", col.names = FALSE)

rate = ts(rate) 

return = diff(log(rate))*100
par(mfrow=c(1,1))
plot(return,type='o',ylab="Exchange rate AUD/USD",main="Time series plot of exchange rate AUD/USD")
acf(return)
pacf(return)
eacf(return)
# ACF, PACF and EACF all shows pattern of white noise for the correlation structure. However, there is an ARCH effect present in the series.
par(mfrow=c(1,1))
McLeod.Li.test(y=return,main="McLeod-Li Test Statistics for return series")
# McLeod-Li test is significnat at 5% level of significance for most of the lags. This gives a strong idea about existence of volatiliy clustering.
qqnorm(return,main="Q-Q Normal Plot of seismic Lg wave series")
qqline(return) # Relatively fat tails is in accordance with volatiliy clustering

#So we'll use absolute value and square transformations to figure out this ARCH effect.
abs.return = abs(return)
sq.return = return^2

par(mfrow=c(1,2))
acf(abs.return, ci.type="ma",main="The sample ACF plot for absolute return series")
pacf(abs.return, main="The sample PACF plot for absolute return series")
eacf(abs.return)
# After the absolute value transformation, we observe many signficicant lags in both ACF and PACF. Also, EACF does not suggest an ARMA(0,0) model.
# From the EACF, we can identify ARMA(1,1) and ARMA(1,2) models for absolute value series. 
# These models correspond to parameter settings of [max(1,1),1] and [max(1,2),1]. So the corresponding 
# tentative GARCH models are GARCH(1,1) and GARCH(2,1).

par(mfrow=c(1,2))
acf(sq.return, ci.type="ma",main="The sample ACF plot for squared return series")
pacf(sq.return, main="The sample PACF plot for squared return series")
eacf(sq.return)
# After the square transformation, we boserve many signficicant lags in both ACF and PACF. Also, EACF does not suggest an ARMA(0,0) model.
# From the EACF, we can identify ARMA(1,1) and ARMA(1,2) models for squared series. 
# These models correspond to parameter settings of [max(1,1),1] and [max(1,2),1]. So the corresponding 
# tentative GARCH models are GARCH(1,1) and GARCH(2,1).


model1<-ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1, 1)), 
                  mean.model = list(armaOrder = c(0, 0), include.mean = FALSE), 
                  distribution.model = "norm")
m.11<-ugarchfit(spec=model1,data=return, out.sample = 100)
plot(m.11)


model2<-ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(2, 1)), 
                   mean.model = list(armaOrder = c(0, 0), include.mean = FALSE), 
                   distribution.model = "norm")
m.21<-ugarchfit(spec=model2,data=return, out.sample = 100)
plot(m.21)


forc = ugarchforecast(m.11, data = return, n.ahead = 10, n.roll =10)
plot(forc, which ="all")
