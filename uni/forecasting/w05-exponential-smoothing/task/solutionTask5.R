library(TSA)
library(car)
library(dynlm)
library(Hmisc)
library(forecast)
library(xts)

price <- read.csv('~/code/data-science/datasets/forecasting/seaLevel.csv',)
price = ts(price[,2], start=c(1998,4),frequency = 12)

plot(price,ylab='Fuel price',xlab='Year',main = "Time series plot of the monthly retail unleaded fuel prices series.")
points(y=price,x=time(price), pch=as.vector(season(price)))

fit1.ses <- ses(price, initial="simple", h=5) 
summary(fit1.ses)
checkresiduals(fit1.ses)

fit2.holt <- holt(price, initial="simple", h=5) # Let the software estimate both alpha and beta
summary(fit2.holt)
checkresiduals(fit2.holt)

fit3.holt <- holt(price, initial="simple", exponential=TRUE, h=5) # Fit with exponential trend
summary(fit3.holt)
checkresiduals(fit3.holt)

fit4.holt <- holt(price, damped=TRUE, initial="simple", h=5) # Fit with additive damped trend
summary(fit4.holt)
checkresiduals(fit4.holt)

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


fit5.hw <- hw(price,seasonal="additive", h=5*frequency(price))
summary(fit5.hw) 
checkresiduals(fit5.hw)

fit6.hw <- hw(price,seasonal="additive",damped = TRUE, h=5*frequency(price))
summary(fit6.hw)
checkresiduals(fit6.hw)

fit7.hw <- hw(price,seasonal="multiplicative", h=5*frequency(price))
summary(fit7.hw)
checkresiduals(fit7.hw)

fit8.hw <- hw(price,seasonal="multiplicative",exponential = TRUE, h=5*frequency(price))
summary(fit8.hw)
checkresiduals(fit8.hw)


fit1.etsA = ets(price, model="ANN")
summary(fit1.etsA)
checkresiduals(fit1.etsA)

fit1.etsM = ets(price, model="MNN")
summary(fit1.etsM)
checkresiduals(fit1.etsM) # Least autocorrelated - BG test

fit2.etsA = ets(price, model="AAN")
summary(fit2.etsA)
checkresiduals(fit2.etsA)

fit2.etsM = ets(price, model="MAN", damped = TRUE)
summary(fit2.etsM)
checkresiduals(fit2.etsM)

fit3.etsA = ets(price, model="AAA")
summary(fit3.etsA)
checkresiduals(fit3.etsA)

fit3.etsM = ets(price, model="MAA")
summary(fit3.etsM)
checkresiduals(fit3.etsM) # By visual checks residuals of this model is less correlated.

fit4.etsM = ets(price, model="MAM")
summary(fit4.etsM)
checkresiduals(fit4.etsM)

fit5 = ets(price)
summary(fit5)
checkresiduals(fit5) # Autofit actually finds the fit1.etsM which is the least autocorrelated - BG test

plot(forecast(fit1.etsM), ylab="Fuel price",plot.conf=FALSE, type="l", xlab="Year")

plot(forecast(fit3.etsM), ylab="Fuel price",plot.conf=FALSE, type="l", xlab="Year")

# Task 2

seaLevel <- read.csv("~/Documents/MATH1307_Forecasting/Tasks/Task 5/seaLevel.csv")
seaLevel = ts(seaLevel$SeaLevel, start=c(1993,1), frequency = 12)

plot(seaLevel, ylab="The global mean sea level (mm)", xlab= "Time", main="Time series plot for global mean sea level series.")
# Seasonality, trend and changing variance

seaLevel2 = log(seaLevel+abs(min(seaLevel))+0.1)
plot(seaLevel2, ylab="The global mean sea level (mm)", xlab= "Time", main="Time series plot for global mean sea level series.")
# Log transformation did not help.

fit1.sea = hw(seaLevel,seasonal="additive", h=5*frequency(seaLevel))
summary(fit1.sea) 
checkresiduals(fit1.sea)

fit2.sea = hw(seaLevel,seasonal="additive", damped = TRUE, h=5*frequency(seaLevel))
summary(fit2.sea) # Best fit, best time series plot for residuals
checkresiduals(fit2.sea)

# We add a constant to be able to fit multiplicatie model with negative or zero values
fit3.sea = hw(min(seaLevel+50),seasonal="multiplicative", h=5*frequency(seaLevel))
summary(fit3.sea) 
checkresiduals(fit3.sea)

fit4.sea = hw((seaLevel+50),seasonal="multiplicative",damped = TRUE, h=5*frequency(seaLevel))
summary(fit4.sea) 
checkresiduals(fit4.sea)

fit5.sea = hw((seaLevel+50),seasonal="multiplicative",damped = FALSE, exponential = TRUE, h=5*frequency(seaLevel))
summary(fit5.sea) 
checkresiduals(fit5.sea)

fit1.sea.ets = ets(seaLevel, model = "AAA")
summary(fit1.sea.ets)
checkresiduals(fit1.sea.ets)

fit2.sea.ets = ets(log(seaLevel+50), model = "AAA", damped = TRUE)
summary(fit2.sea.ets) # MASE = 0.4553113
checkresiduals(fit2.sea.ets)

fit3.sea.ets = ets((seaLevel+50), model = "MAA")
summary(fit3.sea.ets)
checkresiduals(fit3.sea.ets)

fit4.sea.ets = ets((seaLevel+50), model = "MAA", damped = TRUE)
summary(fit4.sea.ets)
checkresiduals(fit4.sea.ets)

fit5.sea.ets = ets((seaLevel+50), model = "MMM")
summary(fit5.sea.ets)
checkresiduals(fit5.sea.ets)

fit6.sea.ets = ets((seaLevel+50), model = "MMM", damped = TRUE)
summary(fit6.sea.ets)
checkresiduals(fit6.sea.ets)

fit.auto = ets((seaLevel+50))
summary(fit.auto) # BEST MASE = 0.4613409 but better time series plot of residuals, non of the models is able to remove autocorrelations in residuals.
checkresiduals(fit.auto)

plot(forecast(fit.auto), ylab="Sea level",plot.conf=FALSE, type="l", xlab="Year")

