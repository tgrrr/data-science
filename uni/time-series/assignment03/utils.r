default_ylab = "BitCoin Price Fluctuation: $USD Apr '13-Feb '19"
startDate = '2013-04-27' #yyyy-mm-dd
endDate = '2019-02-24'
default_xlab = 'Year'
fig_nums <- captioner()

doPar <- function(
  mfrow = c(1,1),
  mai = c(1,0.5,0.5,0.5)
  ) {
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
}

# out = tryCatch({}, error = function(e) print("No results for this test!"))
doDiffAndPlot <- function(
  df.ts, 
  diffCount, 
  showPlot = T, 
  showEacf = F, 
  plotTitle='bitcoin plot'
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
    doPar(mfrow = c(1, 3))
    plot(
      df.ts, 
      xlab=default_xlab, 
      main=plotTitle,
      ylab = default_ylab
      # ylab=fig_nums(figureName
        # , 
        # paste('diff #', diffCount, ' of ', default_ylab, sep = '')
      # )
    )

    acf(
      df.ts,
      main = '',
      sub = 'ACF'
    )

    pacf(
      df.ts,
      main = '',
      sub = 'PACF'
    )
  }
}

# doPar(mfrow = c(1, 2))
# acf(
#   abs.data.ts_log_diff1,
#   ci.type = "ma",
#   main='',
#   sub = 
#     fig_nums("absolute-ACF", "absolute ACF"))
# pacf(
#   abs.data.ts_log_diff1,
#   main='',
#   sub = fig_nums(
#     "absolute-PACF",
#     "absolute PACF"))
# eacf(abs.data.ts_log_diff1)


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
    pValues %>% rbind(isPSignifcant(pValues), '\n') %>% paste() %>% cat()
  }
}

# sort score function
sort.score <- function(x, score = c("bic", "aic")){
  if (score == "aic"){
    x[with(x, order(AIC)),]
  } else if (score == "bic") {
    x[with(x, order(BIC)),]
  } else {
    warning('score = "x" only accepts valid arguments ("aic","bic")')
  }
}

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

