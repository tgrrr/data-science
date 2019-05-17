# Module 6: Tasks Parameter estimation

library(TSA)
library(fUnitRoots)
library(lmtest)
source('~/code/data-science/uni/time-series/common/sort.score.R')
# The sort.score.R file is available under Module 7 on Canvas

#--- Task 1 ---
# 1. The dataset given in “earnings.Preview the documentcsv” file contains average weekly earnings (AUD) in Australia on each November between 1994 and 2016. This dataset is available through http://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/6302.0Nov%202016?OpenDocument#Time (Links to an external site.)Links to an external site. webpage. Load the dataset, convert it into a ts object and do the following tasks:
# 
# - Conduct a hypothesis test to decide on the existence of a trend in this series.
# - Overcome the nonstationary nature of this series by using suitable tools.
# - Specify the orders of ARIMA(p,d,q) model by using
# - ACF and PACF plots
# - EACF plot
# - BIC table
# - Estimate the model parameters using at least two approaches and select the best model based on AIC and BIC.

earnings <- read.table("~/code/data-science/uni/time-series/raw-data/earnings.csv", quote="\"", comment.char="")

earnings = ts(earnings,start = 1994)
class(earnings)

plot(earnings,type='o',ylab='Time series plot of earnings series')

acf(earnings)
pacf(earnings)

earnings.transform = BoxCox.ar(earnings) # The default method for fitting is MLE here
# If do not get a smooth curve with MLE, you can change the method to least squares or Method of Moments
earnings.transform = BoxCox.ar(earnings, method = "yule-walker") 
# earnings.transform = BoxCox.ar(earnings, method = "ols")
earnings.transform$ci
earnings.log = log(earnings) # 0 is in the interval or you can go for mid point of the interval as well

diff.earnings.log = diff(earnings.log,differences = 1)
plot(diff.earnings.log,type='o',ylab='Quarterly earnings ')

order = ar(diff(diff.earnings.log))$order
adfTest(diff.earnings.log, lags = order,  title = NULL,description = NULL)

diff.earnings.log = diff(earnings.log,differences = 2)
plot(diff.earnings.log,type='o',ylab='Quarterly earnings ')

order = ar(diff(diff.earnings.log))$order
adfTest(diff.earnings.log, lags = order,  title = NULL,description = NULL)

acf(diff.earnings.log)
pacf(diff.earnings.log)
# {ARIMA(1,2,1)}

eacf(diff.earnings.log,ar.max = 5, ma.max = 5)
# {ARIMA(1,2,1), ARIMA(0,2,1)}

res = armasubsets(y=diff.earnings.log,nar=6,nma=6,y.name='test',ar.method='ols')
plot(res)

#The final set of possible models is {ARIMA(0,2,1),ARIMA(1,2,1),ARIMA(1,2,2),ARIMA(1,2,4), ARIMA(4,2,1)}
# I'm not including ARIMA(4,2,4) considering the length of the series

# ARIMA(0,2,1)
model_021_css = arima(earnings.log,order=c(0,2,1),method='CSS')
coeftest(model_021_css)

model_021_ml = arima(earnings.log,order=c(0,2,1),method='ML')
coeftest(model_021_ml)

# ARIMA(1,2,1)
model_121_css = arima(earnings.log,order=c(1,2,1),method='CSS')
coeftest(model_121_css)

model_121_ml = arima(earnings.log,order=c(1,2,1),method='ML')
coeftest(model_121_ml)

# ARIMA(1,2,2)
model_122_css = arima(earnings.log,order=c(1,2,2),method='CSS')
coeftest(model_122_css)

model_122_ml = arima(earnings.log,order=c(1,2,2),method='ML')
coeftest(model_122_ml)

# ARIMA(1,2,4)
model_124_css = arima(earnings.log,order=c(1,2,4),method='CSS')
coeftest(model_124_css)

model_124_ml = arima(earnings.log,order=c(1,2,4),method='ML')
coeftest(model_124_ml)

# ARIMA(4,2,1)
model_421_css = arima(earnings.log,order=c(4,2,1),method='CSS')
coeftest(model_421_css)

model_421_ml = arima(earnings.log,order=c(4,2,1),method='ML')
coeftest(model_421_ml)

# The models with all coefficients significant are ARIMA(0,2,1) and ARIMA(1,2,2)-CSS. 

# AIC and BIC values
# you need to source the sort.score() function, which is available in Canvas shell
sort.score(AIC(model_021_ml,model_121_ml,model_122_ml,model_124_ml,model_421_ml), score = "aic")
sort.score(BIC(model_021_ml,model_121_ml,model_122_ml,model_124_ml,model_421_ml), score = "bic" )

# Both AIC and BIC select ARIMA(0,2,1) model for this series.
# ARIMA(1,2,1) is an overfitting model for ARIMA(0,2,1) and we find AR(1) coefficient insignificant.
# Another overfitting model is ARIMA(0,2,2), which is fitted below to check the overfitting:

# ARIMA(0,2,2)
model_022_css = arima(earnings.log,order=c(0,2,2),method='CSS')
coeftest(model_022_css)

model_022_ml = arima(earnings.log,order=c(0,2,2),method='ML')
coeftest(model_022_ml)

# here MA(2) component is also insignificant. So we can confirm that ARIMA(0,2,1) model is a suitable specification.

#--- Task 2 --- 
# 2. The dataset given in “data.cash.Preview the documentcsv” file contains yearly averages of monthly total values of ATM cash withdrawals ($ million) in Australia between 1994 and 2016. This dataset is available through http://www.rba.gov.au/statistics/tables/#interest-rates (Links to an external site.)Links to an external site. webpage. Load the dataset, convert it into a ts object and do the following tasks:
# 
# Conduct a hypothesis test to decide on the existence of a trend in this series.
# Overcome the nonstationary nature of this series by using suitable tools.
# Specify the orders of ARIMA(p,d,q) model by using
# ACF and PACF plots
# EACF plot
# BIC table
# Estimate the model parameters using at least two approaches and select the best model based on AIC and BIC.

data.cash <- read.csv("~/Documents/MATH1318_TimeSeries/tasks/Task4/data.cash.csv", header=FALSE)$V2
class(data.cash)
data.cash = ts(data.cash,start = 1994)
class(data.cash)
plot(data.cash,type='o',ylab='Time series plot of cash series')

acf(data.cash)
pacf(data.cash)

data.cash.transform = BoxCox.ar(data.cash)
data.cash.transform = BoxCox.ar(data.cash, method = "yule-walker")
data.cash.transform$ci
lambda = 1.65
BC.data.cash = (data.cash^lambda-1)/lambda

diff.BC.data.cash = diff(BC.data.cash,differences=1)
plot(diff.BC.data.cash,type='o',ylab='Quarterly earnings ')

order  = ar(diff(diff.BC.data.cash))$order # To pass the order to adfTest function
adfTest(diff.BC.data.cash, lags = order,  title = NULL,description = NULL)

diff.BC.data.cash = diff(BC.data.cash,differences=2)
plot(diff.BC.data.cash,type='o',ylab='Quarterly earnings ')

order  = ar(diff(diff.BC.data.cash))$order # To pass the order to adfTest function
adfTest(diff.BC.data.cash, lags = order,  title = NULL,description = NULL)

diff.BC.data.cash = diff(BC.data.cash,differences=3)
plot(diff.BC.data.cash,type='o',ylab='Quarterly earnings ')

order  = ar(diff(diff.BC.data.cash))$order # To pass the order to adfTest function
adfTest(diff.BC.data.cash, lags = order,  title = NULL,description = NULL)


acf(diff.BC.data.cash)
pacf(diff.BC.data.cash)
# {ARIMA(2,3,1)}

eacf(diff.BC.data.cash,ar.max = 4, ma.max = 4)
# {ARIMA(2,3,1),ARIMA(0,3,1),ARIMA(1,3,1)}

res = armasubsets(y=diff.BC.data.cash,nar=5,nma=5,y.name='test',ar.method='ols')
plot(res)
# Not taking very high orders like p = 5 and q = 5
#The final set of possible models is {ARIMA(2,3,1),ARIMA(0,3,1),ARIMA(1,3,1)}

# ARIMA(2,3,1)
model_231_css = arima(BC.data.cash,order=c(2,3,1),method='CSS')
coeftest(model_231_css)

model_231_ml = arima(BC.data.cash,order=c(2,3,1),method='ML')
coeftest(model_231_ml)

# ARIMA(0,3,1)
model_031_css = arima(BC.data.cash,order=c(0,3,1),method='CSS')
coeftest(model_031_css)

model_031_ml = arima(BC.data.cash,order=c(0,3,1),method='ML')
coeftest(model_031_ml)

# ARIMA(1,3,1)
model_131_css = arima(BC.data.cash,order=c(1,3,1),method='CSS')
coeftest(model_131_css)

model_131_ml = arima(BC.data.cash,order=c(1,3,1),method='ML')
coeftest(model_131_ml)

# AIC and BIC values
# you need to source the sort.score() function, which is available in Canvas shell
sort.score(AIC(model_231_ml,model_031_ml,model_131_ml), score = "aic")
sort.score(BIC(model_231_ml,model_031_ml,model_131_ml), score = "bic" )

# ARIMA(1,3,1) model is the best one among the set of specified models.
# To check with the overfitting we will fit ARIMA(2,3,1) and ARIMA(1,3,2) models.

# ARIMA(2,3,1)
model_231_css = arima(BC.data.cash,order=c(2,3,1),method='CSS')
coeftest(model_231_css) 

model_231_ml = arima(BC.data.cash,order=c(2,3,1),method='ML')
coeftest(model_231_ml)

# ARIMA(1,3,2)
model_132_css = arima(BC.data.cash,order=c(1,3,2),method='CSS')
coeftest(model_132_css) 

model_132_ml = arima(BC.data.cash,order=c(1,3,2),method='ML')
coeftest(model_132_ml)

# Because MA(2) component is found significant and AR(1) is insignificant, I'll fit ARIMA(0,3,2) model as well.

# ARIMA(0,3,2)
model_032_css = arima(BC.data.cash,order=c(0,3,2),method='CSS')
coeftest(model_032_css) 

model_032_ml = arima(BC.data.cash,order=c(0,3,2),method='ML')
coeftest(model_032_ml)

# AIC and BIC values

sort.score(AIC(model_231_ml,model_031_ml,model_131_ml,model_032_ml), score = "aic")
sort.score(BIC(model_231_ml,model_031_ml,model_131_ml,model_032_ml), score = "bic" )

# ARIMA(0,3,2) gives better AIC and BIC values. So, I can use this model for forecasting.



#--- Task 3 ---
# 3. Load the simulated dataset “data.sim” available in "data.sim.Preview the documentcsv” file and convert it into a ts object and do the following tasks:
# Conduct a hypothesis test to decide on the existence of a trend in this series.
# Overcome the nonstationary nature of this series by using suitable tools.
# Specify the orders of ARIMA(p,d,q) model by using
# ACF and PACF plots
# EACF plot
# BIC table
# Estimate the model parameters using at least two approaches and select the best model based on AIC and BIC.

arima.data1 <- read.csv("~/Documents/MATH1318_TimeSeries/tasks/Task4/data.sim.csv", header=FALSE)
arima.data1 = ts(arima.data1,start = 1994)
class(arima.data1)
plot(arima.data1,type='o',ylab='Time sereis plots of simulated series')

acf(arima.data1)
pacf(arima.data1)

arima.data1.transform = BoxCox.ar(arima.data1+abs(min(arima.data1))+0.1, lambda=c(-1,1))
arima.data1.transform = BoxCox.ar(arima.data1+abs(min(arima.data1))+0.1, method = "yule-walker")
arima.data1.transform$ci # Because the interval is very narrow around 1, I won't go for a Box-Cox transformation

diff.arima.data1= diff(arima.data1,difference=1)
plot(diff.arima.data1,type='o',ylab='Quarterly earnings ')

order = ar(diff(diff.arima.data1))$order
adfTest(diff.arima.data1, lags = order,  title = NULL,description = NULL)

acf(diff.arima.data1)
pacf(diff.arima.data1)

#{ARIMA(2,1,2), ARIMA(3,1,2)}

eacf(diff.arima.data1)

#{ARIMA(2,1,2), ARIMA(3,1,2), ARIMA(0,1,2), ARIMA(1,1,2)}

res = armasubsets(y=diff.arima.data1,nar=7,nma=7,y.name='test',ar.method='ols')
plot(res)

#The final set of possible models is {ARIMA(2,1,2), ARIMA(3,1,2), ARIMA(0,1,2), ARIMA(1,1,2), ARIMA(4,1,0)}

# ARIMA(2,1,2)
model_212_css = arima(arima.data1,order=c(2,1,2),method='CSS')
coeftest(model_212_css)

model_212_ml = arima(arima.data1,order=c(2,1,2),method='ML')
coeftest(model_212_ml)

# ARIMA(3,1,2)
model_312_css = arima(arima.data1,order=c(3,1,2),method='CSS')
coeftest(model_312_css)

model_312_ml = arima(arima.data1,order=c(3,1,2),method='ML')
coeftest(model_312_ml)

# ARIMA(0,1,2)
model_012_css = arima(arima.data1,order=c(0,1,2),method='CSS')
coeftest(model_012_css)

model_012_ml = arima(arima.data1,order=c(0,1,2),method='ML')
coeftest(model_012_ml)

# ARIMA(1,1,2)
model_112_css = arima(arima.data1,order=c(1,1,2),method='CSS')
coeftest(model_112_css)

model_112_ml = arima(arima.data1,order=c(1,1,2),method='ML')
coeftest(model_112_ml) 

# ARIMA(4,1,0)
model_410_css = arima(arima.data1,order=c(4,1,0),method='CSS')
coeftest(model_410_css)

model_410_ml = arima(arima.data1,order=c(4,1,0),method='ML')
coeftest(model_410_ml) 

# AIC and BIC values

sort.score(AIC(model_212_ml,model_312_ml,model_012_ml,model_112_ml,model_410_ml), score = "aic")
sort.score(BIC(model_212_ml,model_312_ml,model_012_ml,model_112_ml,model_410_ml), score = "bic" )

# ARIMA(0,1,2) is the best model according to both AIC and BIC
# To check the overfitting I'll fit ARIMA(1,1,2) and ARIMA(0,1,3) model. ARIMA(1,1,2)'s already fitted and AR(1) coefficient is found
# insignificant. 

# ARIMA(0,1,3)
model_013_css = arima(arima.data1,order=c(0,1,3),method='CSS')
coeftest(model_013_css)

model_013_ml = arima(arima.data1,order=c(0,1,3),method='ML')
coeftest(model_013_ml) 

# Because MA(3) component is also found insignificant, we can confirm that ARIMA(0,1,2) is a suitable model for forecasting. This is also the true model for this series.
