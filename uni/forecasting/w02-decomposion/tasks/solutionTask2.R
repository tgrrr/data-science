library(TSA)
library(forecast)
library(x12)

# Exercise 1
NMFS_Landings = read.csv("~/Documents/MATH1307_Forecasting/Tasks/Task 2/NMFS_Landings.csv")
class(NMFS_Landings)
head(NMFS_Landings)
# Convert data into a time series object
NMFS_Landings.ts = matrix(NMFS_Landings$Metric_Tons, nrow = 25, ncol = 12)
NMFS_Landings.ts = as.vector(t(NMFS_Landings.ts))
NMFS_Landings.ts = ts(NMFS_Landings.ts,start=c(1991,1), end=c(2015,12), frequency=12)
class(NMFS_Landings.ts)
head(NMFS_Landings.ts)

plot(NMFS_Landings.ts,ylab='Landings in metric tons',xlab='Year',type='o', main = "Time series plot of monthly landings in metric tons.")

plot(NMFS_Landings.ts,ylab='Landings in metric tons',xlab='Year',main = "Time series plot of monthly landings in metric tons.")
points(y=NMFS_Landings.ts,x=time(NMFS_Landings.ts), pch=as.vector(season(NMFS_Landings.ts)))


acf(NMFS_Landings.ts, max.lag = 48, main="Sample ACF for monthly landings in metric tons")

BC = BoxCox.ar(NMFS_Landings.ts)
landings.tr = log(NMFS_Landings.ts)

plot(landings.tr,ylab='Log of landings in metric tons',xlab='Year',main = "Time series plot of the logarithm of monthly 
     landings in metric tons.")
points(y=landings.tr,x=time(landings.tr), pch=as.vector(season(landings.tr)))


par(mfrow=c(1,1))
landings.diff = diff(landings.tr, differences = 1, lag=12) # First seasonal difference
plot(landings.diff,ylab='Landings in metric tons',xlab='Year',main = "Time series plot of the first difference of monthly 
     landings in metric tons.")
points(y=landings.diff,x=time(landings.diff), pch=as.vector(season(landings.diff)))

landing.decom.x12 = x12(NMFS_Landings.ts)
plot(landing.decom.x12 , sa=TRUE , trend=TRUE)

landing.decom <- stl(landings.tr, t.window=15, s.window="periodic", robust=TRUE)
plot(landing.decom)

landings.seasonally.adjusted = seasadj(landing.decom)
plot(naive(landings.seasonally.adjusted), xlab="New orders index",
     main="Naive forecasts of seasonally adjusted landing series")

# Exercise 2

global_warming <- read.csv("~/Documents/MATH1307_Forecasting/Tasks/Task 2/global_warming.csv")
class(global_warming)

global_warming.ts = ts(global_warming$Annual,start=1880)

plot(global_warming.ts,ylab='Temperature change',xlab='Year',type='o', main = "Time series plot of temperature change relative to
     1951-1980 average temperatures")

par(mfrow=c(1,1))
acf(global_warming.ts, main="Sample ACF for global warming series")

BC = BoxCox.ar(global_warming.ts+0.5)
BC$ci
global_warming.tr = BoxCox(global_warming.ts, lambda = 0.85)

par(mfrow=c(1,1))
plot(global_warming.tr,ylab='Temperature change',xlab='Year',type='o', main = "Time series plot of Box-Cox transformed temperature 
change relative to 1951-1980 average temperatures")

adf.test(global_warming.ts)
global_warming.diff = diff(global_warming.ts)

plot(global_warming.diff,ylab='Temperature change',xlab='Year',type='o', main = "Time series plot of the first difference of temperature 
change relative to 1951-1980 average temperatures")

# Exercise 3

inflation <- read.csv("~/Documents/MATH1307_Forecasting/Tasks/Task 2/inflation.csv")

inflation.ts = ts(inflation$Year_ended_inflation, start = 1924, frequency = 4)

plot(inflation.ts,ylab='Inflation',xlab='Year',main = "Time series plot of inflation series")
points(y=inflation.ts,x=time(inflation.ts), pch=as.vector(season(inflation.ts)))

par(mfrow=c(1,1))
acf(inflation.ts,max.lag = 48, main="Sample ACF for inflation series")

min(inflation.ts)
BC = BoxCox.ar(inflation.ts+abs(min(inflation.ts))+0.01)
BC$ci
inflation.tr = BoxCox(inflation.ts,lambda=0.9)

par(mfrow=c(1,1))
plot(inflation.tr,ylab='Inflation',xlab='Year',main = "Time series plot of Box-Cox transformaed inflation series")
points(y=inflation.tr,x=time(inflation.tr), pch=as.vector(season(inflation.tr)))

adf.test(inflation.ts)
inflation.or.diff = diff(inflation.ts)

par(mfrow=c(1,1))
plot(inflation.or.diff,ylab='Inflation',xlab='Year',main = "Time series plot of the first differenced inflation series")
points(y=inflation.or.diff,x=time(inflation.or.diff), pch=as.vector(season(inflation.or.diff)))

acf(inflation.or.diff,max.lag = 48, main="Sample ACF for the first differenced inflation series")

# inflation.or.seas.diff = diff(inflation.or.diff, differences = 2, lag = 4)
# 
# plot(inflation.or.seas.diff,ylab='Inflation',xlab='Year',main = "Time series plot of the first ordinary and seasonal 
#      differenced inflation series")
# points(y=inflation.or.diff,x=time(inflation.or.diff), pch=as.vector(season(inflation.or.diff)))
# 
# acf(inflation.or.seas.diff,max.lag = 48, main="Sample ACF for the first ordinary and seasonal 
#      differenced inflation series")

inflation.decom <- stl(inflation.ts, t.window=15, s.window="periodic", robust=TRUE)
plot(inflation.decom)

inflation.seasonally.adjusted = seasadj(inflation.decom)
plot(naive(inflation.seasonally.adjusted), xlab="New orders index",
     main="Naive forecasts of seasonally adjusted inflation series")

inflation.decom.frc <- forecast(inflation.decom, h=24)
plot(inflation.decom.frc)
