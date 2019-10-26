library(packagr)
packages <- c('dynlm','ggplot2','AER','Hmisc','forecast','x12','dLagM','TSA')
packagr(packages)

# TASK 1
par(mfrow=c(1,1))
data = read.csv("~/code/data-science/datasets/forecasting/Austria_Unemployment.csv")
data.ts = ts(data[,2],start = c(1995,1),frequency = 12)
plot(data.ts, ylab="Unemployment rate", main = "Time series plot for monthly dataloyment rate data of Austria")

doFitX12 <- function(
  data.ts
) {
  fit.data.x12 = x12(data.ts)
  plot(fit.data.x12 , sa=TRUE , trend=TRUE)
}
doFitX12(data.ts)

doFit <- function(
  data.ts = 'data.ts',
  models = c('MNN', 'MMN', 'MMM', 'MAM', 'ZZZ'),
  showSummary = TRUE,
  showResiduals = TRUE,
  isDiff = FALSE,
  isDamp = FALSE,
  k = 0
  ) {
  for (modelType in models){
    isModelDiff <- ifelse(isDiff, 'diff.', '')
    isModelDamp <- ifelse(isDamp, 'damp.', '')

  tryCatch(
    {
      # Assign our Exponential Smoothing State Space Model
      modelName <- paste0("fit.data.", isModelDiff, isModelDamp, modelType)

      # Exponential Smoothing State Space Model
      etsToAssign <- ets(data.ts + k, model = modelType, damped = isDamp)
      assign(modelName, etsToAssign, envir = .GlobalEnv)
      modelToTest <- get(modelName)
      # This is the equivalent to fit.data.MNN = ets(data.ts,model = "MNN")


      print('MODEL')
      print(modelName)
      print("mase: \n")

      # modelsToTest.assign(modelToTest)
      if(showSummary == TRUE) {
        summary(modelToTest)
      }

      if(showResiduals == TRUE) {
        checkresiduals(modelToTest)
      }

    },
    error = function(e) print(e)
    # ,
    # finally=print("finished")
  )

  }
}

doFit(data.ts, showSummary=TRUE, showResiduals=FALSE)

              MASE
fit.data.MNN  0.6836032
fit.data.MMN  0.6875727 
fit.data.MMM  0.5665041
fit.data.MAM  0.5666683
fit.data.ZZZ  0.5412835

# @focus



summary(fit.data.MNN)$class

for (i in 19) {
  print(fit.data.MNN[i])
}

length(fit.data.MNN)


summary()

doFit(data.ts, showSummary = FALSE, isDamp=TRUE)

# source('/Users/phil/code/data-science/uni/common/utils-forecasting.R')
# summarySummary(fit.data.MNN)

# TODO: seasonal = "additive"
data.diff.ts = diff(data.ts, lag = 12)
doFit(data.diff.ts, isDiff=TRUE, k=2, showSummary = FALSE)
doFit(data.diff.ts, isDiff=TRUE, isDamp=TRUE, k=2, showSummary = FALSE)

# plot(data.diff.ts)



# Merge the differenced series and forecasts
comb= ts.union(data.ts.diff , frc.data.MAdM.diff$mean-2)
data.combined.diff  = pmin(comb[,1], comb[,2], na.rm = TRUE)

back.series = diffinv(data.combined.diff, xi = data.ts[1:12],lag =12)

upper.95.int = frc.data.MAdM.diff$upper[,2]
lower.95.int = frc.data.MAdM.diff$lower[,2]
centre = frc.data.MAdM.diff$mean

length.int = abs(centre - upper.95.int)

# To show what happens if I merge the original series and upper limit of the
# 95% forecast interval
comb2= ts.union(data.ts.diff , upper.95.int-2)
data.combined.diff2  = pmin(comb2[,1], comb2[,2], na.rm = TRUE)
back.series.upper = diffinv(data.combined.diff2, xi = data.ts[1:12],lag =12)

abs(back.series.upper-back.series)
# the difference between back-differenced series and back-differenced upper limit series
# is the same as the difference between forecasts and upper and lower limits of the intervals.
# So, I reckon that there is nothing with differencing and the lenght of the confidence interval
# of forecasts.

frc.original = window(back.series,start = c(2017,6)) #back-differenced forecasts
frc.original.upper = frc.original + length.int
frc.original.lower = frc.original - length.int

plot(data.ts,xlim = c(1993,2020),ylim = c(0,7), ylab="Unemployment rate", main = "Original series, forecasts and 95% forecast interval for the dataloyment series")
lines(frc.original, col = "red")
lines(frc.original.upper, col = "blue")
lines(frc.original.lower, col = "blue")
legend("bottomleft", lty=1, cex=0.75, pch=1, pt.cex = 1.9, text.width = 2.3, col=c("black","red","blue"), c("Data","Forecasts","95% confidence limits"))

