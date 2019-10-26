# doDiff() <- function(
#
# )

# out = tryCatch({}, error = function(e) print("No results for this test!"))
#' Title
#'
#' @param df.ts 
#' @param diffCount 
#' @param plots 
#' @param lag 
#' @param out 
#' @param title 
#' @param ... 
#'
#' @return
#' @export
#'
#' @examples
doTsPlots <- function(
  df.ts,
  diffCount = 0,
  plots = c(plot, acf, pacf, eacf, adf)[1:5],  # new
  lag = 1,
  out = NULL,
  title = 'diff plot',
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

  diffAdfTest = adfTest(df.afterDiff.ts, lags = order, title = NULL, description = NULL)
  p <- diffAdfTest@test$p.value

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

  if(showPlot==TRUE) {
    # doPar(mfrow = c(1, 3))
    doPar()
    layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
    # doPar(mfrow = c(2, 2))

    plot(
      df.afterDiff.ts,
      xlab=default_xlab,
      main=title,
      ylab = default_ylab,
      type = 'l'
    )

    acf(
      df.afterDiff.ts,
      main = '',
      sub = 'ACF'
      # lag.max=2130
    )

    pacf(
      df.afterDiff.ts,
      main = '',
      sub = 'PACF'
      # lag.max=2130
    )
  }

  # return the diffed timeSeries object:
  # LATER: update so doesn't require output named
  if (hasArg(out)) {
    # output.ts <- assign(out, df.afterDiff.ts)
    return(df.afterDiff.ts)
  }

}

# depreciating function params
doDiffAndPlot <- function(
  df.ts,
  diffCount = 0,
  showPlot = TRUE,
  showEacf = FALSE,
  lag = 1,
  out = NULL,
  title = 'diff plot',
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

  diffAdfTest = adfTest(df.afterDiff.ts, lags = order, title = NULL, description = NULL)
  p <- diffAdfTest@test$p.value

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

  if(showPlot==TRUE) {
    # doPar(mfrow = c(1, 3))
    doPar()
    layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
    # doPar(mfrow = c(2, 2))

    plot(
      df.afterDiff.ts,
      xlab=default_xlab,
      main=title,
      ylab = default_ylab,
      type = 'l'
    )

    acf(
      df.afterDiff.ts,
      main = '',
      sub = 'ACF'
      # lag.max=2130
    )

    pacf(
      df.afterDiff.ts,
      main = '',
      sub = 'PACF'
      # lag.max=2130
    )
  }

  # return the diffed timeSeries object:
  # LATER: update so doesn't require output named
  if (hasArg(out)) {
    # output.ts <- assign(out, df.afterDiff.ts)
    return(df.afterDiff.ts)
  }

}
