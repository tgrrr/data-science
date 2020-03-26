library(TSA)
library(urca)

# Exercise 1

earthquakes = read.csv("/Users/phil/code/data-science-next/datasets/forecasting/Austria_Unemployment.csv")
class(earthquakes) # Current class is data frame and we need to convert it to a ts object
earthquakes = ts(earthquakes$Number, start=1900)
class(earthquakes)
head(earthquakes)

plot(earthquakes, ylab="Number of earthquakes", xlab = "Year", main = "Number of earthquakes per year magnitude 7.0 or greater")
par(mfrow=c(1,2)) # Put the ACF and PACF plots next to each other
acf(earthquakes, main = "Sample ACF for the number of earthquakes series")
pacf(earthquakes, main = "Sample PACF for the number of earthquakes series")

adf.earthquakes = ur.df(earthquakes, type = "none", lags = 1,  selectlags =  "AIC")
summary(adf.earthquakes)
pp.earthquakes = ur.pp(earthquakes, type = "Z-alpha", lags = "short")
summary(pp.earthquakes)

# Exercise 2

flow = read.csv("~/Documents/MATH1307_Forecasting/Tasks/Task 1/flow.csv")
class(flow)
flow = ts(flow$Flow,start=c(1953,1),frequency = 12) 
class(flow)
head(flow)

par(mfrow=c(1,1))
plot(flow, ylab="Mean monthly flow", xlab = "Year", main = "Nmean monthly flow series recorded for Piper’s Hole River")
points(y=flow,x=time(flow), pch=as.vector(season(flow)))

par(mfrow=c(1,2)) # Put the ACF and PACF plots next to each other
acf(flow, lag.max = 48, main = "Sample ACF for the mean monthly flow series")
pacf(flow, lag.max = 48, main = "Sample PACF for the mean monthly flow series")

adf.flow = ur.df(flow, type = "none", lags = 1,  selectlags =  "AIC")
summary(adf.flow)
pp.flow = ur.pp(flow, type = "Z-alpha", lags = "short")
summary(pp.flow)

# Exercise 3

aerosol = read.csv("~/Documents/MATH1307_Forecasting/Tasks/Task 1/aerosol.csv")

class(aerosol)
# Be careful about the transpose t() operation here!
aerosol = ts(as.vector(t(as.matrix(aerosol[,2:13]))),start=c(1986,1),frequency = 12) 
class(aerosol)
head(aerosol)

par(mfrow=c(1,1))
plot(aerosol, ylab="Monthly median aerosol optical depth",xlab="Year",main="Time series plot of mean monthly median aerosol 
     optical depth at Cape Grim")
points(y=aerosol,x=time(aerosol), pch=as.vector(season(aerosol)))

par(mfrow=c(1,2)) # Put the ACF and PACF plots next to each other
acf(aerosol, lag.max = 48, main = "Sample ACF for the median monthly aerosol series")
pacf(aerosol, lag.max = 48, main = "Sample PACF for the median monthly aerosol series")

adf.aerosol = ur.df(aerosol, type = "none", lags = 1,  selectlags =  "AIC")
summary(adf.aerosol)
pp.aerosol = ur.pp(aerosol, type = "Z-alpha", lags = "short")
summary(pp.aerosol)

# Exercise 4

y = array(NA,100)
y[1] = 0.3
sigma = 1
for (i in 2:100){
  y[i] = 0.3*y[i-1] + rnorm(1,0,sigma)
}

y = ts(y)

par(mfrow=c(1,1))
plot(y,ylab = "Random measurements",xlab="Time", main="Time series plot for randomly 
     generated random walk")


par(mfrow=c(1,2)) # Put the ACF and PACF plots next to each other
acf(y, lag.max = 48, main = "Sample ACF for the random walk series")
pacf(y, lag.max = 48, main = "Sample PACF for the random walk series")

adf.y = ur.df(y, type = "none", lags = 1,  selectlags =  "AIC")
summary(adf.y)
pp.y = ur.pp(y, type = "Z-alpha", lags = "short")
summary(pp.y)

