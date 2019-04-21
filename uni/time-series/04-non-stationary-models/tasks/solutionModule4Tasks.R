

library(TSA)
#--- Task 1 --- 

data.cash <- read.csv("~/Documents/MATH1318_TimeSeries/tasks/Task4/data.cash.csv", header=FALSE)$V2
class(data.cash)
data.cash = ts(data.cash,start = 1994)
class(data.cash)
plot(data.cash,type='o',ylab='Los Angelos rainfall series')

par(mfrow=c(1,2)) # To plot both ACF and PACF in the same panel of plots
acf(data.cash)
pacf(data.cash)
par(mfrow=c(1,1)) 

data.cash.transform = BoxCox.ar(data.cash)
data.cash.transform$ci
lambda = 0.75 # 0.001
BC.data.cash = (data.cash^lambda-1)/lambda

diff.BC.data.cash = diff(BC.data.cash,differences=1)
plot(diff.BC.data.cash,type='o',ylab='Quarterly earnings ')

diff.BC.data.cash = diff(BC.data.cash,differences=2)
plot(diff.BC.data.cash,type='o',ylab='Quarterly earnings ')

par(mfrow=c(1,2)) # To plot both ACF and PACF in the same panel of plots
acf(diff.BC.data.cash)
pacf(diff.BC.data.cash)
par(mfrow=c(1,1)) 

#--- Task 2 --- 
data("airpass")
plot(airpass,type='o',ylab='Passenger monthly totals')

plot(airpass,type='o',ylab='Passenger monthly totals')
points(y=airpass,x=time(airpass),pch=as.vector(season(airpass)))

par(mfrow=c(1,2)) # To plot both ACF and PACF in the same panel of plots
acf(airpass, lag.max=50) # To show more lags, use lag.max argument
pacf(airpass, lag.max=50)
par(mfrow=c(1,1)) 

log.airpass = log(airpass)
plot(log.airpass,type='o',ylab='Log-transformed passenger monthly totals')

diff.log.airpass = diff(log(airpass))
plot(diff.log.airpass,type='o',ylab='The first difference of log-transformed passenger monthly totals')

par(mfrow=c(1,2)) # To plot both ACF and PACF in the same panel of plots
acf(diff.log.airpass, lag.max=50)
pacf(diff.log.airpass, lag.max=50)
par(mfrow=c(1,1)) 

#--- Task 3 --- 
data(larain)

plot(larain,type='o',ylab='Los Angelos rainfall series')

qqnorm(larain)
qqline(larain, col = 2)
shapiro.test(larain)

larain.transform = BoxCox.ar(larain)
larain.transform$ci
lambda = 0.25
BC.larain = (larain^lambda-1)/lambda #log(larain) #(
qqnorm(BC.larain)
qqline(BC.larain, col = 2)
shapiro.test(BC.larain)

#As another transformation I apply the log transformation
log.larain = log(larain)
plot(log.larain,type='o',ylab='Log-transformed Los Angelos rainfall series')

qqnorm(log.larain)
qqline(log.larain, col = 2)
shapiro.test(log.larain)

par(mfrow=c(1,2)) # To plot both ACF and PACF in the same panel of plots
acf(log.larain)
pacf(log.larain)
par(mfrow=c(1,1)) 

#--- Task 4 --- 
data(gold)
plot(gold,type='o',ylab='Los Angelos rainfall series')

par(mfrow=c(1,2)) # To plot both ACF and PACF in the same panel of plots
acf(gold)
pacf(gold)
par(mfrow=c(1,1)) 

gold.transform = BoxCox.ar(gold)
gold.transform$ci
lambda = -1.8
BC.gold = (gold^lambda-1)/lambda
qqnorm(BC.gold)
qqline(BC.gold, col = 2)
shapiro.test(BC.gold)

diff.BC.gold = diff(BC.gold)
plot(diff.BC.gold,type='o',ylab='Quarterly earnings ')

par(mfrow=c(1,2)) # To plot both ACF and PACF in the same panel of plots
acf(diff.BC.gold)
pacf(diff.BC.gold)
par(mfrow=c(1,1)) 

#--- Task 5 --- 
data.sim <- read.table("~/Documents/MATH1318_TimeSeries/tasks/Task4/data.sim.csv", quote="\"", comment.char="")
data.sim = ts(data.sim)

plot(data.sim,type='o',ylab='Simulated series')

par(mfrow=c(1,2)) # To plot both ACF and PACF in the same panel of plots
acf(data.sim)
pacf(data.sim)
par(mfrow=c(1,1)) 

data.sim.transform = BoxCox.ar(data.sim + abs(min(data.sim))+1) # You get an error saying the system is singular
data.sim.transform = BoxCox.ar(data.sim + abs(min(data.sim))+1, lambda = seq(-1, 1, 0.01))
#You should change the range of labda to get rid of this case using the lambda argument.
data.sim.transform$ci
lambda = 0.9
BC.gold = (gold^lambda-1)/lambda
qqnorm(BC.gold)
qqline(BC.gold, col = 2)
shapiro.test(BC.gold)

diff.data.sim = diff(data.sim)
plot(diff.data.sim,type='o',ylab='Quarterly earnings ')

par(mfrow=c(1,2)) # To plot both ACF and PACF in the same panel of plots
acf(diff.data.sim)
pacf(diff.data.sim)
par(mfrow=c(1,1)) 

