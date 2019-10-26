<<<<<<< HEAD
packagr(packages) # alpha package to check, install and load packages
packagr('tseries')
library(TSA)
library(fUnitRoots)
library(lmtest)
=======
# devtools::install_git('https://gitlab.com/botbotdotdotcom/packagr')
library(packagr)

# TODO:
# plot multiple features on same plot
# check tsAnalysis for other analysis

source('./titleWithFigureNumbers.r')

packagr(c(
  'tseries',
  'captioner',
  'TSA',
  'fUnitRoots',
  'lmtest'))

# setup captioner
fig_nums <- captioner()

>>>>>>> feature/common

tsPlots <- function(
  df.ts,
  diffCount = 0,
<<<<<<< HEAD
  plots = c('plot', 'acf', 'pacf', 'eacf', 'adf')[1:5],  # new
  lag = 1,
  out = NULL,
  plotTitle = 'diff plot',
  ...
  ) {
    
  df.afterDiff.ts <- df.ts
  
  ifelse(
    diffCount != 0, 
    (df.afterDiff.ts = diff(
      df.ts, 
      differences = diffCount,
      lag)),
    df.afterDiff.ts)
  
  order = ar(df.afterDiff.ts)$order

  paste('diff: ', diffCount, '\n') %>% writeLines()
=======
  # TODO: refactor showPlots -> plots
  # TODO: add analysis
  showPlots = c('plot', 'acf', 'pacf', 'eacf', 'adf')[c(1,2,3,5)],  # eacf off by default
  lag = 1, # defaults to yearly
  out = NULL,
  title = 'Plot of timeseries',
  ...
  ) {

  # hide adf warnings
  options(warn=-1)

  titleWithFigureCount <- titleWithFigureNumbers(title)

  # df.afterDiff.ts <- df.ts

  ifelse(
    diffCount != 0,
    (df.afterDiff.ts <-
      diff(
        df.ts,
        differences = diffCount,
        lag)),
    df.afterDiff.ts <- df.ts)

  order = ar(df.afterDiff.ts)$order

  paste('diff:', diffCount) %>% writeLines()
>>>>>>> feature/common

  diffAdfTest = adfTest(df.afterDiff.ts, lags = order, title = NULL, description = NULL)
  p <- diffAdfTest@test$p.value

<<<<<<< HEAD
  writeLines('\nadf p-value: ')
  if (p < 0.05) {
    paste(p, '< 0.05 significant\n') %>% writeLines()
    doPar(mfrow=c(1,1))
    if (showEacf) {
      eacf(df.afterDiff.ts)      
    }
  } else {
    paste('> 0.05 insignificant\n', p) %>% writeLines()
  }

  if(length(plots) != 0) {

  # if(showPlot==TRUE) {
    # doPar(mfrow = c(1, 3))
    doPar()
    layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
    # doPar(mfrow = c(2, 2))

    if('plot' %in% plots) {
      plot(
        df.afterDiff.ts,
        xlab=default_xlab,
        main=plotTitle,
=======
  # TODO: refactor to doPlotAnalysis()
  # augmented Dickey Fuller:
  # adf.x = ur.df(
  #   x,
  #   type = "none",
  #   lags = 1,
  #   selectlags =  "AIC"
  # )
  # summary(adf.x)
  #
  # # Phillips-Perron Unit Root Test:
  # pp.x = ur.pp(
  #   x,
  #   type = "Z-alpha",
  #   lags = "short"
  # )
  # summary(pp.x)

  if (p < 0.05) {
    paste('adf p-value:', p, '< 0.05 significant\n') %>% writeLines()
    doPar(mfrow=c(1,1))
    if ('eacf' %in% showPlots) { # if params specify eacf
      eacf(df.afterDiff.ts)
    }
  } else {
    paste('adf p-value:', p, '> 0.05 insignificant\n') %>% writeLines()
  }

  if(length(showPlots) != 0) {

  # if(showPlot==TRUE) {
    # doPar(mfrow = c(1, 3))
    # doPar()
    layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
    # doPar(mfrow = c(2, 2))

    if('plot' %in% showPlots) {
      plot(
        df.afterDiff.ts,
        xlab=default_xlab,
        main=titleWithFigureCount,
>>>>>>> feature/common
        ylab = default_ylab,
        type = 'l'
      )
    }
<<<<<<< HEAD
    if('acf' %in% plots) {
=======
    if('acf' %in% showPlots) {
>>>>>>> feature/common
      acf(
        df.afterDiff.ts,
        main = '',
        sub = 'ACF'
        # lag.max=2130
      )
    }
<<<<<<< HEAD
    if('acf' %in% plots) {
    
=======
    if('pacf' %in% showPlots) {

>>>>>>> feature/common
      pacf(
        df.afterDiff.ts,
        main = '',
        sub = 'PACF'
        # lag.max=2130
      )
    }
  }
  # return the diffed timeSeries object:
<<<<<<< HEAD
  # LATER: update so doesn't require output named 
=======
  # LATER: update so doesn't require output named
>>>>>>> feature/common
  if (hasArg(out)) {
    # output.ts <- assign(out, df.afterDiff.ts)
    return(df.afterDiff.ts)
  }
<<<<<<< HEAD
  
}

# library(TSA)
library(urca)

# REFACTOR: refactor
# REFACTOR: plot names
doPlot <- function(x) {
  doPar(mfrow = c(1,3))
  plot(
    x, 
    type = 'l',
    #REFACTOR: ylab = "Relative temperature change", xlab = "Year", main = "Global warming series"
  )
  acf(x)
  pacf(x)

  adf.x = ur.df(
    x,
    type = "none",
    lags = 1,
    selectlags =  "AIC"
  )
  summary(adf.x)

  pp.x = ur.pp(
    x,
    type = "Z-alpha",
    lags = "short"
  )
  summary(pp.x)
=======

>>>>>>> feature/common
}
