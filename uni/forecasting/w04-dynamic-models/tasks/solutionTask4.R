library(TSA)
library(car)
library(dynlm)
library(Hmisc)
library(forecast)

source('~/Desktop/Forecasting/Module 4/MATH1307_utilityFunctions.R')

# Task 1
NMFS_Landings = read.csv("/Users/batoulabdelaziz/Desktop/Forecasting/Module 4/Task 4/NMFS_Landings.csv")
class(NMFS_Landings)
head(NMFS_Landings)
# Convert data into a time series object
NMFS_Landings.ts = matrix(NMFS_Landings$Metric_Tons, nrow = 25, ncol = 12)
NMFS_Landings.ts = as.vector(t(NMFS_Landings.ts))
NMFS_Landings.ts = ts(NMFS_Landings.ts,start=c(1991,1), end=c(2015,12), frequency=12)
class(NMFS_Landings.ts)
head(NMFS_Landings.ts)

plot(NMFS_Landings.ts,ylab='Landings in metric tons',xlab='Year',type='o', main = "Time series plot of monthly landings in metric tons.")
par(mfrow=c(1,1))
plot(NMFS_Landings.ts,ylab='Landings in metric tons',xlab='Year',main = "Time series plot of monthly landings in metric tons.")
points(y=NMFS_Landings.ts,x=time(NMFS_Landings.ts), pch=as.vector(season(NMFS_Landings.ts)))

# par(mfrow=c(1,2))
acf(NMFS_Landings.ts,max.lag = 48, main="Sample ACF for monthly landings in metric tons")
# pacf(NMFS_Landings.ts,max.lag = 48, main="Sample PACF for monthly landings in metric tons")

# Intervention results in an immediate and permanent shift in the mean function

landings.tr = log(NMFS_Landings.ts)

plot(landings.tr,ylab='Log of landings in metric tons',xlab='Year',main = "Time series plot of the logarithm of monthly 
     landings in metric tons.")
points(y=landings.tr,x=time(landings.tr), pch=as.vector(season(landings.tr)))

# Log transformation makes it more stabile

Y.t = landings.tr
T = 96
S.t = 1*(seq(Y.t) >= T)
S.t.1 = Lag(S.t,+1) 

model1 = dynlm(Y.t ~ L(Y.t , k = 1 ) + S.t + trend(Y.t) + season(Y.t))
summary(model1)

model2 = dynlm(Y.t ~ L(Y.t , k = 2 ) + S.t + trend(Y.t) + season(Y.t))
summary(model2)

model3 = dynlm(Y.t ~ L(Y.t , k = 1 ) + S.t + S.t.1 + trend(Y.t) + season(Y.t))
summary(model3)

model1.2 = dynlm(Y.t ~ L(Y.t , k = 1 ) + S.t + season(Y.t))
summary(model1.2)

model1.3 = dynlm(Y.t ~ L(Y.t , k = 1 ) + S.t + trend(Y.t) )
summary(model1.3)

aic = AIC(model1, model1.2, model1.3)
bic = BIC(model1, model1.2, model1.3)

sort.score(aic,score = "aic")
sort.score(bic,score = "bic")

residual.analysis((model1))

checkresiduals(model1)

# There is a significant amaount of series correlation left in the residuals

model4.1 = dynlm(Y.t ~ L(Y.t , k = 1 ) + L(Y.t , k = 2 ) + S.t+ S.t.1  + season(Y.t))
summary(model4.1)

model4.2 = dynlm(Y.t ~ L(Y.t , k = 1 ) + L(Y.t , k = 2 ) + S.t.1  + season(Y.t))
summary(model4.2)

aic = AIC(model1, model1.2, model1.3, model4.1, model4.2)
bic = BIC(model1, model1.2, model1.3, model4.1,  model4.2)

sort.score(aic,score = "aic")
sort.score(bic,score = "bic")
checkresiduals(model4.2)

model5 = dynlm(Y.t ~ L(Y.t , k = 1 ) + L(Y.t , k = 2 ) + L(Y.t , k = 3 ) + S.t.1  + season(Y.t))
summary(model5)

aic = AIC(model1, model1.2, model1.3, model4.2, model5)
bic = BIC(model1, model1.2, model1.3, model4.2, model5)

sort.score(aic,score = "aic")
sort.score(bic,score = "bic")
checkresiduals(model5)

model6 = dynlm(Y.t ~ L(Y.t , k = 1 ) + L(Y.t , k = 2 ) + L(Y.t , k = 3 ) + S.t + S.t.1 + trend(Y.t) + season(Y.t))
summary(model6)

aic = AIC(model1, model1.2, model1.3, model4.2, model5, model6)
bic = BIC(model1, model1.2, model1.3, model4.2, model5, model6)

sort.score(aic,score = "aic")
sort.score(bic,score = "bic")
checkresiduals(model6)

model7 = dynlm(Y.t ~ L(Y.t , k = 1 ) + L(Y.t , k = 2 ) + L(Y.t , k = 3 ) + L(Y.t , k = 4 ) + S.t + S.t.1 + trend(Y.t) + season(Y.t))
summary(model7)

aic = AIC(model1, model1.2, model1.3, model4.2, model5, model6, model7)
bic = BIC(model1, model1.2, model1.3, model4.2, model5, model6, model7)

sort.score(aic,score = "aic")
sort.score(bic,score = "bic")
checkresiduals(model7)

# Model 7 did not improve the diagnostic checking results so we will get one step back and try another component

# S.t.2 = Lag(S.t,+2)
# 
# model8 = dynlm(Y.t ~ L(Y.t , k = 1 ) + L(Y.t , k = 2 ) + L(Y.t , k = 3 ) + S.t + S.t.1 + trend(Y.t)
#                + season(Y.t))
# 
# Y.t.2 = diff(Y.t, lag = 12, differences = 1)
# model8 = dynlm(Y.t ~ L(Y.t , k = 1 ) + L(Y.t , k = 2 ) + L(Y.t , k = 3 ) + S.t + S.t.1 + trend(Y.t)  
#                + season(Y.t))

Y.t.2 = diff(Y.t, lag = 12, differences = 1)
S.t2 = 1*(seq(Y.t.2) >= T)
S.t.12 = Lag(S.t2,+1) 
model8 = dynlm(Y.t.2 ~ L(Y.t.2 , k = 1 ) + L(Y.t.2 , k = 2 ) + L(Y.t.2 , k = 3 ) + S.t2 + S.t.12 + trend(Y.t.2)  
               + season(Y.t.2))

summary(model8)

aic = AIC(model1, model1.2, model1.3, model4.2, model5, model6, model7, model8)
bic = BIC(model1, model1.2, model1.3, model4.2, model5, model6, model7, model8)

sort.score(aic,score = "aic")
sort.score(bic,score = "bic")
checkresiduals(model8)


par(mfrow=c(1,1))
plot(Y.t,ylab='Log of landings in metric tons',xlab='Year',main = "Time series plot of the logarithm of monthly 
     landings in metric tons.")
lines(model6$fitted.values,col="red")

q = 24
n = nrow(model6$model)
landings.frc = array(NA , (n + q))
landings.frc[1:n] = Y.t[4:length(Y.t)]

trend = array(NA,q)
trend.start = model6$model[n,"trend(Y.t)"]
trend = seq(trend.start , trend.start + q/12, 1/12)

for (i in 1:q){
  months = array(0,11)
  months[(i-1)%%12] = 1
  print(months)
  data.new = c(1,landings.frc[n-1+i],landings.frc[n-2+i],landings.frc[n-3+i],1,1,trend[i],months) 
  landings.frc[n+i] = as.vector(model6$coefficients) %*% data.new
}

plot(Y.t,xlim=c(1991,2018),ylab='Log of landings in metric tons',xlab='Year',
main = "Time series plot of the logarithm of monthly landings in metric tons.")
lines(ts(landings.frc[(n+1):(n+q)],start=c(2016,1),frequency = 12),col="red")


# Task 2

price <- read.csv("/Users/batoulabdelaziz/Desktop/Forecasting/Module 4/Task 4/fuelPriceData.csv")
price = ts(price, start=c(1998,5),frequency = 12)
price_melb = price[,2]
price_darwin = price[,3]
price.joint=ts.intersect(price_melb,price_darwin)
plot(price)
# plot(temp)
plot(price.joint,yax.flip=T)

ccf(as.vector(price.joint[,1]), as.vector(price.joint[,2]),ylab='CCF', main = "Sample CCF between")

me.dif=ts.intersect(diff(diff(price_melb,12)),diff(diff(price_darwin,12)))
prewhiten(as.vector(me.dif[,1]),as.vector(me.dif[,2]),ylab='CCF', main="Sample CFF after prewhitening ")

#Task 3
inf <- read.csv("/Users/batoulabdelaziz/Desktop/Forecasting/Module 4/Task 4/priceInflation.csv")
inf = ts(inf, start=c(1998,2),frequency = 4)
price_melb = inf[,2]
inflation = inf[,3]
price.joint=ts.intersect(price_melb,inflation)
plot(price.joint,yax.flip=T)

ccf(as.vector(price.joint[,1]), as.vector(price.joint[,2]),ylab='CCF', main = "Sample CCF between")

me.dif=ts.intersect(diff(diff(price_melb,4)),diff(diff(inflation,4)))
prewhiten(as.vector(me.dif[,1]),as.vector(me.dif[,2]),ylab='CCF', main="Sample CFF after prewhitening ")
