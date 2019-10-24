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


tsPlots <- function(
  df.ts,
  diffCount = 0,
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

  diffAdfTest = adfTest(df.afterDiff.ts, lags = order, title = NULL, description = NULL)
  p <- diffAdfTest@test$p.value

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
    if('pacf' %in% showPlots) {

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
