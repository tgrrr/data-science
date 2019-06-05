# TS Handy: Handy Tools for Univariate Time Series Analysis
# Author(s): Yong Kai, Wong
# Version Number: 0.1
# Objective: To automate repetitive processes in time series analysis

## Install packages and load libraries
# pkgs <- c('TSA', 'fUnitRoots', 'forecast', 'lmtest')
# invisible(lapply(pkgs, require, character.only = T))

myCandidate <- function(timeSeries, orderList,
                        methodType = c("CSS-ML", "ML", "CSS")[1],
                        fixedList = NULL, includeConstant = c(TRUE, FALSE)[1]){
  
  # timeSeries = the time series (a ts object)
  # orderList = a list object of c(p, d, q)
  # methodType = estimation method; default = "CSS-ML"
  # fixedList = a list object of free/fixed coefficient
  # includeConstant = if true, an intercept term is included in the model
  
  myCandidateEst <- list()
  
  for(i in 1:length(orderList)){
    order <- sapply(orderList,function(x) unlist(x))[,i]
    myCandidateEst[[i]] <- Arima(y = timeSeries, order = order, method = methodType,
                                 include.constant = includeConstant)
  }
  return(myCandidateEst)
  
}


ARIMAdiagnostic <- function(model, lagNumber){
  
  e <- residuals(model)   # residuals
  er <- rstandard(model)   # standardized residuals
  
  # QQ Plot
  
  qqnorm(er, main = "", ylab = "QQ of Residuals")
  qqline(er, col = "red")
  
  # Standardised residual plot
  
  plot(er, type = "n", main = "", ylab = "Standardized Residuals")
  abline(h=c(-3,0,3),col = c("red","black", "red"), lty = c("dotted", "solid", "dotted"))
  points(e, pch = 1, cex = 0.5)
  
  # ACF/PACF Graphs
  
  Acf(e, main = "", lag.max = lagNumber)
  Pacf(e, main = "", lag.max =lagNumber)
  
  # Histogram
  
  hist(er, breaks = "FD", freq  = FALSE, col = "gray", border = "white",
       main = "", ylab = "Density Function", xlab = "Standardized Residuals")
  x <- seq(min(er),max(er), by = 0.001)  # add the theoretical z-distribution
  lines(x, dnorm(x), col = "red")
  legend("topleft", legend = c("Sample","Theoretical"), col = c("gray", "red"),
         pch = 15, bty = "n")
  
  # P-Value for Ljung-Box
  
  pValue <- rep(0, lagNumber)
  for(j in 0:lagNumber){
    pValue[j] <- Box.test(e, lag = j, type = "Ljung-Box", fitdf = 0)$p.value
  }
  plot(pValue, ylim = c(0,1), type = "n", ylab = "P-values",
       xlab = "Lags")
  points(pValue)
  abline(h = 0.05, col = "red", lty = "dotted")
  
}
