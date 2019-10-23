# devtools::install_git('https://gitlab.com/botbotdotdotcom/packagr')
library(packagr)

# TODO:
# plot multiple features on same plot

packagr(c('tseries', 'captioner'))

library(TSA)
library(fUnitRoots)
library(lmtest)

# setup captioner
fig_nums <- captioner()


tsPlots <- function(
  df.ts,
  diffCount = 0,
  showPlots = c('plot', 'acf', 'pacf', 'eacf', 'adf')[c(1,2,3,5)],  # eacf off by default
  lag = 1,
  out = NULL,
  plotTitle = 'Plot of timeseries',
  ...
  ) {

  # hide adf warnings
  options(warn=-1)

  # Captioner::fig_nums requires a unique plot name to incriment the figure num
  uniquePlotName <- paste(c(plotTitle, runif(1)), collapse = " ")
  plotTitleWithDiffCount <- paste0(plotTitle, ' (diff = ', diffCount, ')', collapse = " ")

  plotTitleWithFigureCount <- fig_nums(uniquePlotName, plotTitleWithDiffCount)

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

  diffAdfTest = adfTest(df.afterDiff.ts, lags = order, title = NULL, description = NULL)
  p <- diffAdfTest@test$p.value

  # writeLines('adf p-value:')
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
    doPar()
    layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
    # doPar(mfrow = c(2, 2))

    if('plot' %in% showPlots) {
      plot(
        df.afterDiff.ts,
        xlab=default_xlab,
        main=plotTitleWithFigureCount,
        ylab = default_ylab,
        type = 'l'
      )
    }
    if('acf' %in% showPlots) {
      acf(
        df.afterDiff.ts,
        main = '',
        sub = 'ACF'
        # lag.max=2130
      )
    }
    if('acf' %in% showPlots) {

      pacf(
        df.afterDiff.ts,
        main = '',
        sub = 'PACF'
        # lag.max=2130
      )
    }
  }
  # return the diffed timeSeries object:
  # LATER: update so doesn't require output named
  if (hasArg(out)) {
    # output.ts <- assign(out, df.afterDiff.ts)
    return(df.afterDiff.ts)
  }

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

  if (hasArg(out)) {
    # output.ts <- assign(out, df.afterDiff.ts)
    return(df.afterDiff.ts)
  }

}
