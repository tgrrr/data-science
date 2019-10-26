#' Author: Haydar Demirhan

library(TSA)
library(car)
library(ggplot2)
library(dynlm)
library(Hmisc)
library(forecast)
library(expsmooth)

data("ausgdp")

plot(ausgdp,ylab = "Quarterly GDP per capita", xlab = "Year", main="Time series plot of Australian quarterly
     gross domestic product per capita")

fit.ausgdp.AAN.conv <- ets(ausgdp,"AAN" , damped=FALSE , upper=rep(1,4))
summary(fit.ausgdp.AAN.conv)

fit.ausgdp.AAN.stable <- ets(ausgdp,"AAN",damped=FALSE,bounds="admiss")
summary(fit.ausgdp.AAN.stable)

plot(fit.ausgdp.AAN.conv$state[,2],xlab="Year",ylab="Growth rate", ylim=c(-120,250))
lines(fit.ausgdp.AAN.stable$state[,2], col="blue", type="l")
legend("topleft",lty=1, pch=1, col=c("black","blue"), c("Conventional","Stability"))

data("usgdp")
plot(usgdp,ylab = "Quarterly GDP per capita", xlab = "Year", main="Time series plot of US quarterly
     gross domestic product per capita")

fit.usgdp.ANN.mse <- ets(ausgdp,"ANN" , damped=FALSE , opt.crit = "mse")
summary(fit.usgdp.ANN.mse)
fit.usgdp.ANN.lik <- ets(ausgdp,"ANN" , damped=FALSE )
summary(fit.usgdp.ANN.lik)

fit.usgdp.ANN.drift <- ets(ausgdp,"AAN" , beta = 0.0001,lambda = 0)
summary(fit.usgdp.ANN.drift)

fit.usgdp.MNN.drift <- ets(ausgdp,"MNN", beta = 0.0001,bounds="admiss")
summary(fit.usgdp.MNN.drift)


plot(fit.usgdp.ANN.drift$state[,2],xlab="Year",ylab="Growth rate")
lines(fit.usgdp.MNN.drift$state[,2], col="red", type="l")
legend("topleft",lty=1, pch=1, col=c("black","blue","red"), c("ANN","ANN with drift","MNN with drift"))






library(expsmooth)

fit <- ets(frexport,model="MAM",damped=FALSE,alpha=0.8185)

z <- ts(matrix(NA,16,5000),s=7,f=4)
for(j in 1:5000)
  z[,j] <- simulate(fit,initstate=fit$states[25,],nsim=16)
pi <- quantile(z[16,],type=8,prob=c(.05,.95))

plot(frexport,xlim=c(1,10.8),ylim=range(frexport,z),ylab="Quarterly sales (thousands of francs)",xlab="Year")
for(i in 1:20)
  lines(z[,i],col="gray")
text(1,600,"Historical data",adj=0)
text(7,600,"Simulated future sample paths",adj=0)
lines(c(10.75,10.75),pi,lwd=3,col=1)

Pi = array(NA, dim=c(16,2))
avrg = array(NA, 16)

for (i in 1:16){
  Pi[i,] = quantile(z[i,],type=8,prob=c(.05,.95))
  avrg[i] = mean(z[i,])
}
Pi.lb = ts(Pi[,1],start=end(frexport),f=4)
Pi.ub = ts(Pi[,2],start=end(frexport),f=4)
avrg.pred = ts(avrg,start=end(frexport),f=4)

plot(frexport,xlim=c(1,10.8),ylim=range(frexport,z),ylab="Sales (thousands of francs)",xlab="Year")
lines(Pi.lb,col="blue", type="l")
lines(Pi.ub,col="red", type="l")
lines(avrg.pred,col="green", type="l")
legend("topleft", lty=1, pch=1, col=c("black","blue","red","green"), text.width = 4,
       c("Data","5% lower limit","95% upper limit","Mean prediction"))



plot(density(z[16,],bw="SJ"),main="Quarterly sales distribution: 16 steps ahead",xlab="Sales (thousands of francs)")
lines(pi,c(0,0),lwd=3,col=1)
text(mean(pi),0.0002,"90% Prediction Interval")

ltd <- colSums(z[1:3,])
ltd.den <- density(ltd/1e3,bw="SJ")

plot(ltd.den,main="Lead time demand distribution: 3-steps ahead",xlab="Sales (millions of francs)")
text(median(ltd)/1e3,0.2,"90% Prediction Interval")
lines(quantile(ltd/1e3,type=8,prob=c(.05,.95)),c(0,0),lwd=3,col=1)

################################
# Compute forecasts
simpi <- forecast(fit,h=24,simulate=TRUE,npaths=20000)
pi <- forecast(fit,h=24,simulate=FALSE)

ff <- simpi$mean # Usual point forecasts
f <- pi$mean # Exact forecast means
v <- ((pi$upper[,2]-pi$lower[,2])/2/qnorm(0.975))^2 # Exact forecast variance

### COMPUTE VARIANCE USING SMALL SIGMA APPROXIMATION
xn <- fit$state[25,1:2]
zn <- fit$state[25,3:6]
vv <- theta <- numeric(24)
mu <- xn[1] + xn[2]*(1:24)
theta[1] <- mu[1]^2
for(j in 1:24)
{
  idx <- (28-j+1) %% 4
  if(idx==0)
    idx <- 4
  k <- as.integer((j-1)/4)
  vv[j] <- ((1+fit$sigma2)*(1+fit$par["gamma"]^2*fit$sigma2)^k*theta[j]-mu[j]^2)*zn[idx]^2
  if(j<24)
    theta[j+1] <- mu[j+1]^2 + fit$sigma2*sum((fit$par["alpha"]+(1:j)*fit$par["beta"])^2*theta[j+1-(1:j)])
}

plot.ts(sqrt(v[1:12]),ylab="Forecast standard deviation",xlab="Forecast horizon")
lines(sqrt(vv[1:12]),lty=2)
legend("topleft",legend=c("Exact","Small sigma approximation"),lty=c(1,2))

plot.ts(c(frexport,rep(NA,12)),ylim=c(300,1500),ylab="",xlab="Quarter")
lines(25:36,ff[1:12],col=2)
lines(25:36,f[1:12],col=3)
lines(25:36,f[1:12]+1.96*sqrt(v[1:12]),lty=1)
lines(25:36,f[1:12]-1.96*sqrt(v[1:12]),lty=1)
lines(25:36,simpi$lower[1:12,2],lty=3)
lines(25:36,simpi$upper[1:12,2],lty=3)
legend("topleft",legend=c("Percentile-based interval", "Variance-based interval"),
       lty=c(2,1))

## STOCHASTIC LEAD TIME

elln = 2
sigma = 1
h = 1:20
alpha = 0.1

var1 <- (elln^2 +sigma^2) * h + sigma^2 * alpha * ((1 + 0.5*alpha)*h + alpha * h^3/3)
var2 <- sigma^2*h * ( 1 + alpha * (h-1) * (1 + 1/6 * alpha * (2*h-1)))

plot(h,var1,type="l",main="Lead-time demand variance",ylab="Variance",xlab="Forecast horizon")
lines(h,var2,lty=2)
text(14,120,"Poisson lead-time",adj=0)
text(15,40,"Fixed lead-time",adj=0)
