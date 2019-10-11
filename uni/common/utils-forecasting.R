
# Packages:

# devtools::install_git('https://gitlab.com/botbotdotdotcom/packagr')
library(packagr)
packages <- c(
  'TSA',
  'fUnitRoots'
  # 'dLagM', 'forecast', 'expsmooth', 'Hmisc', 'car', 'AER',
  # 'readr', 'tseries', 'lubridate', 'stringr', 'testthis', 'captioner', 'urca'
)
packagr(packages) # alpha package to check, install and load packages

setwd('/Users/phil/code/data-science-next/uni/common')

# /Users/phil/code/data-science-next/uni/common/MATH1307_utilityFunctions.R
source('~/code/data-science-next/uni/common/utils.R')
source('~/code/data-science-next/uni/common/MATH1307_utilityFunctions.R')
source('~/code/data-science-next/uni/common/data/convertToTimeSeries.R')

source('~/code/data-science-next/uni/common/preprocessing/diffTs.R')
source('~/code/data-science-next/uni/common/visualization/diffAndPlot.R')
source('~/code/data-science-next/uni/common/visualization/tsPlots.R')
# includes: residual.analysis, sort.score

summarySummary <- function(model.fit) {
  tryCatch({
    summary(model.fit)$adj.r.square %>% round(2) %>% cat('adjusted r-squared:', ., '\n')
    
    fstat <- summary(model.fit)$fstatistic 
    pf(fstat[1], fstat[2], fstat[3], lower.tail=FALSE) %>% cat('p-value:',., '\n') 
  },
  error=function(cond) {
    summary(model.fit)
  },
  warning=function(w) {
    message('warning')
  })
}

# ~old_todo~
# LATER:
unitRoots <- function() {
    k1 <- ar(data.ts)$order
  print(k1)
  adf.test(data.ts, k = k1)

  k2 <- trunc(12*((length(data.ts)/100)^(1/4)))
  print(k2)
  adf.test(data.ts, k = k2)

  test <- adf.test(data.ts)
  test$parameter

  PP.test(data.ts, lshort = TRUE)
  PP.test(data.ts, lshort = FALSE)
}

### Confidence interval of Lambda

confidenceInterval <- function(
  data.ts,
  method=c("yule-walker","")[1],
  title=''
) {
  # check the confidence interval of lambda
  # doPar(mfrow = c(1,1))
  boxcoxCi <- BoxCox.ar(data.ts, method = "yule-walker")$ci
  return(boxcoxCi)
  # title(
  #   fig_nums(title, title,), 
  #   line = -1.5, 
  #   outer = TRUE
  # )
  # lambda == 0
}

doTestNormality <- function(
  df, 
  main, # plot title
  plotit = TRUE
) {

  if (plotit) {
    title <- fig_nums(
    main,
    paste('Normality of ', main, sep = '')) 
    title %>% cat()
    qqnorm(
      df,
      main = title,
    )
    qqline(df, col = 2)
  }
  shapiro.test(df)
}

compareNormality <- function(
  x, # list
  main='Normality test for timeseries data' 
  # LATER: graph=TRUE
) {
  doPar(mfrow=c(1,2))
    for (i in length(x)) {
      # TODO: accept list of titles # LATER: list
      # doTestNormality(i, main)
      cat('foo')
      cat(i)
    }
}


# REFACTOR: for refactor
# bug: in TSA package: plot it unable to be set to false
convertToBoxCox <- function(
  df_col.ts,
  lambda= lambda_
) {

  lambda = lambda_ || seq(-2, 2, by=0.5)

  out <- tryCatch({
    if(min(df_col.ts) <= 0) {
      x_ <- (df_col.ts 
        + abs(min(df_col.ts))
        +1
      )
    } else {
      x_ <- df_col.ts
    }

    boxcoxCi <- BoxCox.ar(
      x_,
      lambda,
      method = "yule-walker"
    )$ci    

    lambda_ <- (
      max(boxcoxCi)-min(boxcoxCi)
    )/2 
    # lambda=~midpoint between CI
    
    df.boxcox.ts = (df_col.ts^lambda_-1) / lambda_
    cat('\nConfidence Interval: \n', boxcoxCi)
    cat('\nLambda: ', lambda_)

    # message("This is the 'try' part")
    return(df.boxcox.ts)
  },
  error=function(cond) {
      message("BoxCox did not work")
      print(df_col.ts)
      message("Error message: ")
      message(cond)
      return(NA)
  },
  warning=function(w) {
    cat('WARNING CAUGHT\n'); invokeRestart(findRestart('muffleWarning'))
  }
  )
  return(out)

}

# ---------------------------------------------

# LATER: function
# LATER: repeat about 5 times
  # createVariableNames

# We add a constant to be able to fit multiplicatie model with negative or zero values
doFitHw <- function (
  data.ts,
  seasonalType= c("additive","multiplicative")[1],
  constant = 0,
  ...
 ) {
   
   fit1.sea = hw(data.ts,seasonal="additive", h=5*frequency(data.ts))
   summary(fit1.sea) 
   checkresiduals(fit1.sea)
   # 
   fit2.sea = hw(data.ts,seasonal="additive", damped = TRUE, h=5*frequency(data.ts))
   summary(fit2.sea) # Best fit, best time series plot for residuals
   checkresiduals(fit2.sea)
   # 
   # # We add a constant to be able to fit multiplicatie model with negative or zero values
   # fit3.sea = hw(min(data.ts+50),seasonal="multiplicative", h=5*frequency(data.ts))
   # summary(fit3.sea) 
   # checkresiduals(fit3.sea)
   # 
   fit4.sea = hw((data.ts+50),seasonal="multiplicative",damped = TRUE, h=5*frequency(data.ts))
   summary(fit4.sea) 
   checkresiduals(fit4.sea)
   # 
   fit5.sea = hw((data.ts+50),seasonal="multiplicative",damped = FALSE, exponential = TRUE, h=5*frequency(data.ts))
   summary(fit5.sea) 
   checkresiduals(fit5.sea)

    # return('foo')
}


# ----
findSeasonalFreq <- function(x)
{
    n <- length(x)
    spec <- spec.ar(c(x),plot=FALSE)
    if(max(spec$spec)>10) # Arbitrary threshold chosen by trial and error.
    {
        period <- round(1/spec$freq[which.max(spec$spec)])
        if(period==Inf) # Find next local maximum
        {
            j <- which(diff(spec$spec)>0)
            if(length(j)>0)
            {
                nextmax <- j[1] + which.max(spec$spec[j[1]:500])
                period <- round(1/spec$freq[nextmax])
            }
            else
                period <- 1
        }
    }
    else
        period <- 1
    return(period)
}
# ---
# find.freq(data.ts)

# Is seasonal?

isSeasonal <- function(data.ts) {
  fit <- tbats(data.ts)
  seasonal <- !is.null(fit$seasonal)
  seasonal  
}



# p <- periodogram(data.ts)
# 
# dd = data.frame(freq=p$freq, spec=p$spec)
# order = dd[order(-dd$spec),]
# top10 = head(order, 100)
# 
# # display the 2 highest "power" frequencies
# # top10
# 
# calcSeasonalPeriod <- function(
#   x
#   ) {
#     p = periodogram(x)
# 
#   }


# LATER: later
# m_data = t(matrix(data = data.ts, nrow = 12))
# seasonal_data = colMeans(m_data, na.rm = T)
# plot(as.ts(rep(seasonal_data,16)))



doTailTs <- function(data,n) {
  data <- as.ts(data)
  return (window(data,start=tsp(data)[2]-(n-1)/frequency(data)))
}

doForecast <- function (
  model, 
  data = copper.ts,
  tail_data = c(5824, 5683, 5599), # final values for copper
  h = 3
){
  tryCatch({
      tail_data <- data %>% doTailTs(h)
      lastValues <- tail_data[1:h]
      forecast.out <- dLagM::forecast(
        model = model, 
        x = lastValues, 
        h = h
      )$forecasts
       # %>% rbind()

    # LATER: 
    # for (i in length(featuresData)) {
    #   tail_data <- data.ts[,i] %>% doTailTs(h)
    #   lastValues <- tail_data[1:h]
    #   forecast.out <- dLagM::forecast(
    #     model = model, 
    #     x = lastValues, 
    #     h = h
    #   )$forecasts %>% rbind()
    # 
    # }
    # return(forecast.out)
  },
  error=function(cond) {
    # print(data %>% head(1))
    # print(model)
    # print(lastValues)
    message('error')
  },
  warning=function(w) {
    # print(model)
    # print(data)
    print(tail_data)
    print(h)

    message('warning')
  })
}
