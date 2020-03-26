
library(TSA)
library(fUnitRoots)
library(lmtest)
library(FitAR)
source('~/Desktop/MATH1318/Week8/Task6/sort.score.R')
# The sort.score.R file is available under Module 7 on Canvas

#--- Task 1 ---

unemployment <- read.table("~/Documents/MATH1318_TimeSeries/tasks/Task7/unemployment.csv", quote="\"", comment.char="")

unemployment = ts(unemployment,start = 1978)
class(unemployment)
unemployment.raw = unemployment


plot(unemployment,type='o',ylab='Time series plot of unemployment series')

acf(unemployment)
pacf(unemployment)

unemployment.transform = BoxCox.ar(unemployment)
unemployment.transform = BoxCox.ar(unemployment, method = "yule-walker")
unemployment.transform$ci

unemployment = log(unemployment) # Since 0 is in the interval. Alternatively you can go for the mid point as well.
plot(unemployment,type='o',ylab='Time series plot of log of unemployment series')


diff.unemployment = diff(unemployment, differences = 1) # Be careful I'm using log-transformed series
plot(diff.unemployment,type='o',ylab='QThe first difference of unemployment series')

order = ar(diff(diff.unemployment))$order
adfTest(diff.unemployment, lags = order,  title = NULL,description = NULL)

diff.unemployment = diff(unemployment, differences = 2) # Be careful I'm using log-transformed series
plot(diff.unemployment,type='o',ylab='QThe second difference of unemployment series')

order = ar(diff(diff.unemployment))$order
adfTest(diff.unemployment, lags = order,  title = NULL,description = NULL)


acf(diff.unemployment)
pacf(diff.unemployment)
# {ARIMA(2,2,1)}

eacf(diff.unemployment,ar.max = 7, ma.max = 7)
# {ARIMA(2,2,1), ARIMA(0,2,1), ARIMA(1,2,1)}

res = armasubsets(y=diff.unemployment,nar=6,nma=6,y.name='test',ar.method='ols')
plot(res)

#The final set of possible models is {ARIMA(2,2,1), ARIMA(0,2,1), ARIMA(1,2,1)}

# ARIMA(2,2,1)
model_221_css = arima(unemployment,order=c(2,2,1),method='CSS')
coeftest(model_221_css)

model_221_ml = arima(unemployment,order=c(2,2,1),method='ML')
coeftest(model_221_ml)

# ARIMA(0,2,1)
model_021_css = arima(unemployment,order=c(0,2,1),method='CSS')
coeftest(model_021_css)

model_021_ml = arima(unemployment,order=c(0,2,1),method='ML')
coeftest(model_021_ml)


# ARIMA(1,2,1)
model_121_css = arima(unemployment,order=c(1,2,1),method='CSS')
coeftest(model_121_css)

model_121_ml = arima(unemployment,order=c(1,2,1),method='ML')
coeftest(model_121_ml)

# AIC and BIC values
# you need to source the sort.score() function, which is available in Canvas shell
sort.score(AIC(model_221_ml,model_021_ml,model_121_ml), score = "aic")
sort.score(BIC(model_221_ml,model_021_ml,model_121_ml), score = "bic" )

# The ARIMA(1,2,1) model is the best one according to both AIC and BIC
# I'll try over-fitting with ARIMA(2,2,1) and ARIMA(1,2,2) models. In ARIMA(2,2,1) model AR(2) is 
# insignificant according to MLE and significant according to CSS. However, this model was not promising 
# in terms of AIC and BIC.

# ARIMA(1,2,2)
model_122_css = arima(unemployment,order=c(1,2,2),method='CSS')
coeftest(model_122_css)

model_122_ml = arima(unemployment,order=c(1,2,2),method='ML')
coeftest(model_122_ml)

# In ARIMA(1,2,2) model, AR(1) coefficient goes insignificant. So I'll stop at ARIMA(1,2,1) model.

# We will go on with residual analysis of the models with sgnificant coefficients.

# The following function provides a handy way of displaying the diagnostic plots.
# You need to install FitAR package to run this function.
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
  par(mfrow=c(1,1))
}

residual.analysis(model = model_121_ml)
par(mfrow=c(1,1))
# There is no problem with the diagnostic plots.

# We applied log transformation and second difference. To take them back:
log.data = log(unemployment.raw)
log.data.diff2.back = diffinv(diff.unemployment, differences = 2, xi = data.matrix(log.data[1:2]))
log.data.diff2.back = exp(log.data.diff2.back)

library(forecast)
# In the forecasts differencing will already been taken back! 
# We need to specify the lambda of Box-Cox transformation:
fit = Arima(unemployment.raw,c(1,2,1), lambda = 0) 
plot(forecast(fit,h=10)) 

#--- Task 2 ---
# arima.data1 = arima.sim(list(order = c(2,1,3),ar = c(-0.89,-0.26), ma=c(0.71,0.31,0.2)), n = 200) 
# This is how I have simulated this series. So you know the true values of parameters and the trure oreders. 
# You can compare your final results with the true values to see how good is your model.

arima.data1 <- read.csv("~/Documents/MATH1318_TimeSeries/tasks/Task7/data.sim.csv", header=FALSE)
arima.data1 = ts(arima.data1,start = 1794)
class(arima.data1)

plot(arima.data1,type='o',ylab='Time sereis plots of simulated series')

acf(arima.data1)
pacf(arima.data1)

arima.data1.transform = BoxCox.ar(arima.data1+abs(min(arima.data1))+0.1)
arima.data1.transform$ci # No transformation

diff.arima.data1= diff(arima.data1,difference=1)
plot(diff.arima.data1,type='o',ylab='Quarterly earnings ')

order = ar(diff(diff.arima.data1))$order
adfTest(diff.arima.data1, lags = order,  title = NULL,description = NULL)

acf(diff.arima.data1)
pacf(diff.arima.data1)
#{ARIMA(2,1,0), ARIMA(2,1,4), ARIMA(2,1,3)}

eacf(diff.arima.data1)
#{ARIMA(2,1,0), ARIMA(2,1,4), ARIMA(2,1,3), ARIMA(1,1,2), ARIMA(1,1,3), ARIMA(2,1,2)}

res = armasubsets(y=diff.arima.data1,nar=7,nma=7,y.name='test',ar.method='ols')
plot(res)


#The final set of possible models is {ARIMA(2,1,0), ARIMA(2,1,4), ARIMA(1,1,2), ARIMA(1,1,3), ARIMA(2,1,2)}

# ARIMA(2,1,0)
model_210_css = arima(arima.data1,order=c(2,1,0),method='CSS')
coeftest(model_210_css)

model_210_ml = arima(arima.data1,order=c(2,1,0),method='ML')
coeftest(model_210_ml)

# ARIMA(2,1,3)
model_213_css = arima(arima.data1,order=c(2,1,3),method='CSS')
coeftest(model_213_css)

model_213_ml = arima(arima.data1,order=c(2,1,3),method='ML')
coeftest(model_213_ml)

# ARIMA(2,1,4)
model_214_css = arima(arima.data1,order=c(2,1,4),method='CSS')
coeftest(model_214_css)

model_214_ml = arima(arima.data1,order=c(2,1,4),method='ML')
coeftest(model_214_ml)

# ARIMA(1,1,2)
model_112_css = arima(arima.data1,order=c(1,1,2),method='CSS')
coeftest(model_112_css)

model_112_ml = arima(arima.data1,order=c(1,1,2),method='ML')
coeftest(model_112_ml)

# ARIMA(1,1,3)
model_113_css = arima(arima.data1,order=c(1,1,3),method='CSS')
coeftest(model_113_css)

model_113_ml = arima(arima.data1,order=c(1,1,3),method='ML')
coeftest(model_113_ml)

# ARIMA(2,1,2)
model_212_css = arima(arima.data1,order=c(2,1,2),method='CSS')
coeftest(model_212_css)

model_212_ml = arima(arima.data1,order=c(2,1,2),method='ML')
coeftest(model_212_ml)

# AIC and BIC values
# you need to source the sort.score() function, which is available in Canvas shell
sort.score(AIC(model_210_ml,model_214_ml,model_213_ml,model_112_ml,model_212_ml,model_113_ml), score = "aic")
sort.score(BIC(model_210_ml,model_214_ml,model_213_ml,model_112_ml,model_212_ml,model_113_ml), score = "bic" )

# AIC and BIC do not agree on one particular model. According to AIC ARIMA(2,1,3) is the best and according to BIC, ARIMA(1,1,2) is the best.
# But in ARIMA(1,1,2) model, not all coefficients are significant. Also, ARIMA(2,1,2) is the second best according to AIC
# and it has all parameters significant. So, we can consider both ARIMA(2,1,2) and ARIMA(2,1,3) models. 

# For overfitting, ARIMA(2,1,3) is an overfit for ARIMA(2,1,2) and MA(3) is slightly insignificant. I'll fit ARIMA(3,1,2) as another overfitting model.

# ARIMA(3,1,2)
model_312_css = arima(arima.data1,order=c(3,1,2),method='CSS')
coeftest(model_312_css)

model_312_ml = arima(arima.data1,order=c(3,1,2),method='ML')
coeftest(model_312_ml)

# AR(3) is insignificant at 5% level as well. So we can use ARIMA(2,1,2) model. 

residual.analysis(model = model_212_ml)
par(mfrow=c(1,1))
# There is no problem in the residuals of ARIMA(2,1,2) model.

library(forecast)
fit = Arima(arima.data1,c(2,1,2)) 
plot(forecast(fit,h=10))
