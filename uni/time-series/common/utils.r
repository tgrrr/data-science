# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# defaults

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

default_ylab = "BitCoin Price Fluctuation: $USD Apr '13-Feb '19"
startDate = '2013-04-27' #yyyy-mm-dd
endDate = '2019-02-24'
default_xlab = 'Year'
defaultBlackWhite = FALSE 
# Change here to make all plots black and white

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Forecasting

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

doForecast <- function() {
  linear_predict = ts(
    forecastLinear[,1],
    start = startForecast,
    frequency = frequency
  )
  MASE(real.ts, linear_predict)
  # plot 
  plot(data.ts)
  lines(real.ts, col = "red")
  lines(linear_predict, col="red", type="l")
  zoomplot.zoom(xlim=c(2019.1,2019.3))
}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# saveTimeSeriesCSV

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

saveTimeSeriesCSV <- function(x) {
  fname <- paste0(deparse(substitute(x)), ".csv")
  readr::write_csv(tsibble::as_tsibble(x, gather = FALSE), fname)
}
# Credit: https://robjhyndman.com/hyndsight/ts2csv/

fig_nums <- captioner()

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Make plots black and white
# Change plot layout

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

doPar <- function(
            mfrow = c(1,1),
            mai = c(1,0.5,0.5,0.5),
            ...
            ) {

  if (hasArg(blackWhite) || defaultBlackWhite == TRUE) {
    # Note: if blackWhite is specified in params at all, this will return TRUE
    par(
      bg = 'black',
      col = "white",
      col.axis = 	'white',
      col.lab = "white",
      col.main = 'white',
      col.sub = 'white',
      fg = 'white',
      mai = mai,
      mfrow = mfrow
    )
  } else {
    par(
      mai = mai,
      mfrow = mfrow
    )
  }
}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# A collection of plots, with the diff function built in 

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


# out = tryCatch({}, error = function(e) print("No results for this test!"))
doDiffAndPlot <- function(
  df.ts,
  diffCount,
  showPlot = T,
  showEacf = F,
  plotTitle='bitcoin plot',
  ...
  ) {
  ifelse(
    diffCount != 0, (df.ts = diff(df.ts, differences = diffCount)),
    'there is no diff\n')
  paste('diff: ', diffCount, '\n') %>% writeLines()
  order = ar(diff(df.ts))$order

  diffAdfTest = adfTest(df.ts, lags = order, title = NULL, description = NULL)
  p <- diffAdfTest@test$p.value

  writeLines('\nadf p-value: ')
  if (p < 0.05) {
    paste(p, '< 0.05 significant\n') %>% writeLines()
    doPar(mfrow=c(1,1))
    eacf(df.ts) # new
  } else {
    paste('> 0.05 insignificant\n', p) %>% writeLines()
  }

  if(showPlot==TRUE) {
    # doPar(mfrow = c(1, 3))
    doPar()
    layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
    # doPar(mfrow = c(2, 2))

    plot(
      df.ts,
      xlab=default_xlab,
      main=plotTitle,
      ylab = default_ylab,
      type = 'l'
    )

    acf(
      df.ts,
      main = '',
      sub = 'ACF'
      # lag.max=2130
    )

    pacf(
      df.ts,
      main = '',
      sub = 'PACF'
      # lag.max=2130
    )
  }
}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# sort.score <- not sure who to attribute

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sort.score <- function(x, score = c("bic", "aic")){
  if (score == "aic"){
    x[with(x, order(AIC)),]
  } else if (score == "bic") {
    x[with(x, order(BIC)),]
  } else {
    warning('score = "x" only accepts valid arguments ("aic","bic")')
  }
}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# BoxCoxSearch <- not sure who to attribute

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


BoxCoxSearch = function(y, lambda=seq(-3,3,0.01),
                        m= c("sf", "sw","ad" ,"cvm", "pt", "lt", "jb"), plotit = T, verbose = T){
  N = length(m)
  BC.y = array(NA,N)
  BC.lam = array(NA,N)
  for (i in 1:N){
    wrt <- switch(m[i],
      'sf' = 'Shapiro-Francia Test',
      'sw' = 'Shapiro-Wilk  Test',
      'ad' = 'Anderson-Darling Test',
      'cvm' = 'Cramer-von Mises Test',
      'pt' = 'Pearson Chi-square Test',
      'lt' = 'Lilliefors Test',
      'jb' = 'Jarque-Bera Test'
    )
    print(paste0("------------- ",wrt," -------------"))
    out = tryCatch({
      boxcoxnc(
        y, method = m[i], lam = lambda, lambda2 = NULL, plot = plotit, alpha = 0.05, verbose = verbose)
      BC.lam[i] = as.numeric(out$lambda.hat)},
      error = function(e) print("No results for this test!"))
  }
  return(list(lambda = BC.lam,p.value = BC.y))
}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Residual Analysis

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


residual.analysis <- function(
  model,
  std = TRUE,start = 2,
  class = c("ARIMA","GARCH","ARMA-GARCH")[1],
  title = ''
  ){
  # If you have an output from arima() function use class = "ARIMA"
  # If you have an output from garch() function use class = "GARCH"
  # If you have an output from ugarchfit() function use class = "ARMA-GARCH"
  library(TSA)
  library(FitAR)
  if (class == "ARIMA"){
    if (std == TRUE){
      res.model = rstandard(model)
    }else{
      res.model = residuals(model)
    }
  }else if (class == "GARCH"){
    res.model = model$residuals[start:model$n.used]
  }else if (class == "ARMA-GARCH"){
    res.model = model@fit$residuals
  }else {
    stop("The argument 'class' must be either 'ARIMA' or 'GARCH' ")
  }
  doPar(mfrow = c(3,2), mai = c(0.5,0.5,0.5,0.5))
  plot(res.model,type='l',ylab='Standardised residuals', main="Time series plot of standardised residuals")
  abline(h=0)
  hist(res.model,main="Histogram of standardised residuals")
  acf(res.model,main="ACF of standardised residuals")
  pacf(res.model,main="PACF of standardised residuals")
  qqnorm(res.model,main="QQ plot of standardised residuals")
  qqline(res.model, col = 2)
  title(title, line = -1, outer = TRUE)
  print(shapiro.test(res.model))
  k=0
  LBQPlot(res.model, lag.max = 30, StartLag = k + 1, k = 0, SquaredQ = FALSE)
}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# myCandidate

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


## Install packages and load libraries
pkgs <- c('TSA', 'fUnitRoots', 'forecast', 'lmtest')
invisible(lapply(pkgs, require, character.only = T))

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
    myCandidateEst[[i]] <- 
      Arima(
        y = timeSeries, 
        order = order, 
        method = methodType,
        include.constant = includeConstant
      )
  }
  
  return(myCandidateEst)
  
}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Find Best Models

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


findBestModel <- function(df.ts) {
  models <- list()
  i = 1
  cat(
    '| AIC', 
    '| Order', 
    # ' SSE=',sse,
    # 'model p-VALUE=', pval$p.value,
    '| Shapiro Residuals p-value |', 
    '\n',
    '| --------- | ---------- | --------------------- |\n'
  )

  for(d in 0:2){
    for(q in 0:2){
      for(p in 0:2){
        if(p+d+q<=8){
          # limited to 6 because of the principle of parsimony.
          # generate models:
          order <- c((p),d,(q))
          model <- 
            Arima(
              y=df.ts, 
              order = order,
              method = "ML",
              include.constant = TRUE
            )
          aic <- as.numeric(model$aic)
          # residuals p value:
          # boxTest <- Box.test(model$residuals, lag=log(length(model$residuals)))
          # boxTest$p.value
          # sum of squared error:
          sse <- sum(model$residuals^2)
          shapiroPValue <- as.numeric(shapiro.test(model$residuals)$p.value)

          cat(
            '|',
            aic,
            '|',
            order,
            '|',          
            shapiroPValue,
            '|',
            # ' SSE=',sse,
            # 'model p-VALUE=', pval$p.value,
            '\n'
          )
          models[i] <- rbind(model$aic)
          i = i + 1 # iterator
          
          # TODO: pval, 
          # outputList <- list(p, d, q, aic, NULL, shapiroPValue)
          # # outputList
          # # output.df[i, ] <- 

          # TODO: order the list
          # for(i in 1:length(models)){
          #   order <- sapply(orderList,function(x) unlist(x))[,i]
        }
      }
    }
  }
  # output.df %>% head()
}

findBestModelV2 <- function(df.ts) {
  datalist = list()

  for(d in 1:2){
    for(q in 0:2){
      for(p in 0:7){
        if(p+d+q<=9){
          # limited to 9 because of the principle of parsimony.

          # generate models:
          order <- c((p),d,(q))

          modelList <- list(c(1,2,0), c(1,2,1), c(2,2,1))
          modelEstimation <- myCandidate(
            value, 
            orderList = modelList, 
            methodType = "ML")
        }
      }
    }
  }
  return(output.df)
}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# getModelCoef

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



# WIP to refactor
# for(i in 1:length(possibleArimaModels)){
#   # pdq = unlist(possibleArimaModels[i], use.names=FALSE)
#   order <- sapply(possibleArimaModels,function(x) unlist(x))[,i]
#   getModelCoef(pdq = order)
# }
getModelCoef <- function(pdq) {
  cat('\nmodel: arima(', pdq, ')\n')
  methods=c('CSS','ML')
  for (i in methods) {
    cat(i, '\n')
    model = arima(data.ts,order=pdq,method=i)
    coef = coeftest(model)
    modelName <- paste("model", i, sep = "")
    modelToScore <- assign(modelName, model)
    totalResultLines <- pdq[1] + pdq[3]
    startResult <- totalResultLines*3# because coeftest() returns a s4 object
    pValues <- 1:totalResultLines %>%
      map(~ {coeftest(model)[(.x + startResult)] %>% round(6) %>% paste()})
    isPSignifcant <- function(p) { 
      ifelse(p < 0.05, 'p < 0.05 significant', 'p > 0.05 insignificant')
    }
    pValues %>% rbind(isPSignifcant(pValues), '\n')
  }
  cat('Arima Model coeff p-values (rounded to 6 decimal places):\n')
  return(pValues)
}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Seasonality

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

check_seasonality_decompose <- function(df.ts) {

  time.series <- df.ts
  decomposed  <- stl(time.series, s.window="periodic")
  seasonal    <- decomposed$time.series[,1]
  trend	      <- decomposed$time.series[,2]
  remainder   <- decomposed$time.series[,3]

  plot(decomposed)
  plot(
    seasonal,
    main="seasonality",
    ylab="value",
    xlim=c(2017, 2019),
    ylim=c(-1000, 2000)
  )

  # plot(
  #   trend+remainder,
  #   main="seasonality",
  #   ylab="value",
  #   # xlim=c(2014, 2019),
  #   # ylim=c(-1000, 12000)
  # )
}


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

check_seasonality_ggplot <- function(
  df.ts = data.ts, # not transformed
  diffCount = 0,
  ...
  ) {
  price <- ts(rev(df.ts), frequency = 7)
  xlim = c(1600,1650)

  # diffCount <- 1
  startDate <- diffCount + 1
  date <- data$Date[startDate:length(data$Date)] # difference removes a record, so we need to remove one from the start of the date

  price.decomposed <- stl(price,"periodic", robust = TRUE) # get seasonal decomposition
  price.seasonal <- price.decomposed$time.series[,"seasonal"]
  price.trend <- price.decomposed$time.series[,"trend"]
  price.residuals <- price.decomposed$time.series[,"remainder"]
  price.expected <- price.seasonal + price.trend
  data.decomposed <- data.frame(
    x=1:length(df.ts), 
    seasonality = price.seasonal, 
    trend=price.trend, 
    residuals=price.residuals, 
    expected=price.expected, 
    time=date)
  # TODO: removed rev() from time

  p1 <- ggplot(
          data = data.decomposed,
          aes(x=x,y=exp(seasonality))
        ) + 
          geom_line() + 
          ylab("Seasonality") + 
          coord_cartesian(xlim = xlim)
  p2 <- ggplot(
    data = data.decomposed, 
    aes(x=x, y=exp(trend))) +
    geom_line(col='darkblue')  + 
    ylab("Trend")
  p3 <- ggplot(data=data.decomposed, aes(x=x, y = residuals)) + geom_line()
  p4 <- ggplot(data=data.decomposed, aes(x=x, y=expected)) + geom_line()
  grid.arrange(
    p1,
    p2,
    p3,
    p4, 
    ncol=1
  )  
}

# is_seasonality(data.ts__log)





# Add a ternary function in R: TRUE ? 'true' : 'false'
  `?` <- function(ifTernary, thenTernary)
      eval(
        sapply(
          strsplit(
            deparse(substitute(thenTernary)),
            ":"
        ),
        function(e) parse(text = e)
        )[[2 - as.logical(ifTernary)]])
# Setup kable to be used with 
# # {r table_format, results = "hide", table = T, eval = F}
#   default_source_hook <- knit_hooks$get('source')
#   knit_hooks$set(
#     source = function(x, options) {
#       if(is.null(options$table))
#         default_source_hook(x, options)
#       else {
#         eval(parse(text = x)) %>%
#           kable("html") %>%
#             kable_styling("hover", full_width = F)
#       }  
#     }
#   )