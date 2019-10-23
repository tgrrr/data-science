library(dynlm)
library(ggplot2)
library(AER)
library(Hmisc)
library(forecast)
library(x12)
library(dLagM)
library(TSA)

# TASK 1
aerosol = read.csv("/Users/batoulabdelaziz/Desktop/Forecasting/Module 8/Task 8/aerosol.csv")

class(aerosol)
# Be careful about the transpose t() operation here!
aerosol = ts(as.vector(t(as.matrix(aerosol[,2:13]))),start=c(1986,1),frequency = 12) 
class(aerosol)
head(aerosol)

par(mfrow=c(1,1))
plot(aerosol, ylab="Monthly median aerosol optical depth",xlab="Year",main="Time series plot of mean monthly median aerosol 
     optical depth at Cape Grim")
points(y=aerosol,x=time(aerosol), pch=as.vector(season(aerosol)))

# par(mfrow=c(1,2)) # Put the ACF and PACF plots next to each other
acf(aerosol, lag.max = 48, main = "Sample ACF for the median monthly aerosol series")
# pacf(aerosol, lag.max = 48, main = "Sample PACF for the median monthly aerosol series")

aerosol.x12 = x12(aerosol)
plot(aerosol.x12 , sa=TRUE , trend=TRUE)


fit.AAA1 = ets(aerosol, model = "AAA", damped = FALSE, bounds="admiss" )
summary(fit.AAA1)
checkresiduals(fit.AAA1)

fit.AAA2 = ets(aerosol, damped = FALSE, model = "AAA")
summary(fit.AAA2)
checkresiduals(fit.AAA2)

fit.AAA3 = ets(aerosol, damped = FALSE, model = "AAA", upper=rep(1,4))
summary(fit.AAA3)
checkresiduals(fit.AAA3)

fit.AAA4 = ets(aerosol, damped = FALSE, model = "AAA", opt.crit = "mse")
summary(fit.AAA4)
checkresiduals(fit.AAA4)

fit.AAA5 = ets(aerosol, damped = FALSE, model = "AAA", opt.crit = "mae")
summary(fit.AAA5)
checkresiduals(fit.AAA5)


fit.AAdA1 = ets(aerosol, model = "AAA", damped = TRUE, bounds="admiss" )
summary(fit.AAdA1)
checkresiduals(fit.AAdA1)

fit.AAdA2 = ets(aerosol, model = "AAA", damped = TRUE)
summary(fit.AAdA2)
checkresiduals(fit.AAdA2)

fit.AAdA3 = ets(aerosol, model = "AAA", damped = TRUE, upper=rep(1,4))
summary(fit.AAdA3)
checkresiduals(fit.AAdA3)

fit.AAdA4 = ets(aerosol, model = "AAA", damped = TRUE, opt.crit = "mse")
summary(fit.AAdA4)
checkresiduals(fit.AAdA4)

fit.AAdA5 = ets(aerosol, model = "AAA", damped = TRUE, opt.crit = "mae")
summary(fit.AAdA5)
checkresiduals(fit.AAdA5)


# Task 2
A = ts(matrix(NA,120,5000),start=c(2015,1),frequency = 12)
# n = length(aerosol)
# h = 10
M = 5000
for (i in 1:M){
  A[,i] = simulate(fit.AAdA1 , initstate = fit.AAdA1 $states[25,] , nsim=120) 
  # Generate random epsilons and apply model formulation
}

par(mfrow=c(1,1))
plot(aerosol , ylim=range(aerosol,A) , xlim=c(1985,2026) , ylab="Median aerosol optical depth" , xlab="Year")
for(i in 1:10){
  lines(A[,i],col="gray")
}
text(1990,0,"Historical data",adj=0)
text(2015,0,"10 simulated future sample paths",adj=0)

plot(aerosol , ylim=range(aerosol,A) , xlim=c(1985,2026) , ylab="Median aerosol optical depth" , xlab="Year")
for(i in 1:20){
  lines(A[,i],col="gray")
}
text(1990,0,"Historical data",adj=0)
text(2015,0,"20 simulated future sample paths",adj=0)

plot(aerosol , ylim=range(aerosol,A) , xlim=c(1985,2026) , ylab="Median aerosol optical depth" , xlab="Year")
for(i in 1:30){
  lines(A[,i],col="gray")
}
text(1990,0,"Historical data",adj=0)
text(2015,0,"30 simulated future sample paths",adj=0)

plot(aerosol , ylim=range(aerosol,A) , xlim=c(1985,2026) , ylab="Median aerosol optical depth" , xlab="Year")
for(i in 1:100){
  lines(A[,i],col="gray")
}
text(1990,0,"Historical data",adj=0)
text(2015,0,"100 simulated future sample paths",adj=0)

plot(aerosol , ylim=range(aerosol,A) , xlim=c(1985,2026) , ylab="Median aerosol optical depth" , xlab="Year")
for(i in 1:1000){
  lines(A[,i],col="gray")
}
text(1990,0,"Historical data",adj=0)
text(2015,0,"5000 simulated future sample paths",adj=0)


N = 120
data = aerosol
xlim=c(1985,2026)
Pi = array(NA, dim=c(N,2))
avrg = array(NA, N)
# Calcualte the interval estimates and mid point
for (i in 1:N){
  Pi[i,] = quantile(A[i,],type=8,prob=c(.05,.95))
  avrg[i] = mean(A[i,]) # This would be median as well
}
# Create ts objects for plotting
Pi.lb = ts(Pi[,1],start=end(data),f=12)
Pi.ub = ts(Pi[,2],start=end(data),f=12)
avrg.pred = ts(avrg,start=end(data),f=12)

plot(data,xlim=xlim , ylim=range(data,A),ylab="Y",xlab="Year", main=" 
     10 years ahead predictions")
lines(Pi.lb,col="blue", type="l")
lines(Pi.ub,col="red", type="l")
lines(avrg.pred,col="green", type="l")
legend("topleft", lty=1, pch=1, col=c("black","blue","red","green"), text.width = 4,
       c("Data","5% lower limit","95% upper limit","Mean prediction"))