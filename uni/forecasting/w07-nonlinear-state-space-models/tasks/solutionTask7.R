library(dynlm)
library(ggplot2)
library(AER)
library(Hmisc)
library(forecast)
library(x12)
library(dLagM)
library(TSA)

# TASK 1
par(mfrow=c(1,1))
unemp = read.csv("~code/data-science/datasets/forecasting/Austria_Unemployment.csv")
unemp.ts = ts(unemp[,2],start = c(1995,1),frequency = 12) 
plot(unemp.ts, ylab="Unemployment rate", main = "Time series plot for monthly unemployment rate data of Austria")

fit.unemp.x12 = x12(unemp.ts)
plot(fit.unemp.x12 , sa=TRUE , trend=TRUE)

fit.unemp.MNN = ets(unemp.ts,model = "MNN")
summary(fit.unemp.MNN)
checkresiduals(fit.unemp.MNN)

fit.unemp.MMN = ets(unemp.ts,model = "MMN")
summary(fit.unemp.MMN)
checkresiduals(fit.unemp.MMN)

fit.unemp.MMM = ets(unemp.ts,model = "MMM")
summary(fit.unemp.MMM)
checkresiduals(fit.unemp.MMM)

fit.unemp.MAM = ets(unemp.ts,model = "MAM")
summary(fit.unemp.MAM)
checkresiduals(fit.unemp.MAM)

fit.unemp.ZZZ = ets(unemp.ts,model = "ZZZ")
summary(fit.unemp.ZZZ)
checkresiduals(fit.unemp.ZZZ)


unemp.ts.diff = diff(unemp.ts,lag = 12)
plot(unemp.ts.diff)

fit.unemp.MAM.diff = ets(unemp.ts.diff+2,model = "MAM")
summary(fit.unemp.MAM.diff)
checkresiduals(fit.unemp.MAM.diff)

fit.unemp.MAdM.diff = ets(unemp.ts.diff+2,model = "MAM",damped = T)
summary(fit.unemp.MAdM.diff)
checkresiduals(fit.unemp.MAdM.diff)

fit.unemp.MMM.diff = ets(unemp.ts.diff+2,model = "MMM")
summary(fit.unemp.MMM.diff)
checkresiduals(fit.unemp.MMM.diff)

frc.unemp.MAdM.diff = forecast(fit.unemp.MAdM.diff)
plot(frc.unemp.MAdM.diff)

# Merge the differenced series and forecasts
comb= ts.union(unemp.ts.diff , frc.unemp.MAdM.diff$mean-2)
unemp.combined.diff  = pmin(comb[,1], comb[,2], na.rm = TRUE)

back.series = diffinv(unemp.combined.diff, xi = unemp.ts[1:12],lag =12)

upper.95.int = frc.unemp.MAdM.diff$upper[,2]
lower.95.int = frc.unemp.MAdM.diff$lower[,2]
centre = frc.unemp.MAdM.diff$mean

length.int = abs(centre - upper.95.int)

# To show what happens if I merge the original series and upper limit of the 
# 95% forecast interval
comb2= ts.union(unemp.ts.diff , upper.95.int-2)
unemp.combined.diff2  = pmin(comb2[,1], comb2[,2], na.rm = TRUE)
back.series.upper = diffinv(unemp.combined.diff2, xi = unemp.ts[1:12],lag =12)

abs(back.series.upper-back.series)
# the difference between back-differenced series and back-differenced upper limit series
# is the same as the difference between forecasts and upper and lower limits of the intervals.
# So, I reckon that there is nothing with differencing and the lenght of the confidence interval 
# of forecasts.

frc.original = window(back.series,start = c(2017,6)) #back-differenced forecasts
frc.original.upper = frc.original + length.int
frc.original.lower = frc.original - length.int

plot(unemp.ts,xlim = c(1993,2020),ylim = c(0,7), ylab="Unemployment rate", main = "Original series, forecasts and 95% forecast interval for the unemployment series")
lines(frc.original, col = "red")
lines(frc.original.upper, col = "blue")
lines(frc.original.lower, col = "blue")
legend("bottomleft", lty=1, cex=0.75, pch=1, pt.cex = 1.9, text.width = 2.3, col=c("black","red","blue"), c("Data","Forecasts","95% confidence limits"))

