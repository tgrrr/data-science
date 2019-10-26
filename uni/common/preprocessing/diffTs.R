# doDiff() <- function(
<<<<<<< HEAD
# 
# )

# out = tryCatch({}, error = function(e) print("No results for this test!"))
=======
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
>>>>>>> feature/common
doTsPlots <- function(
  df.ts,
  diffCount = 0,
  plots = c(plot, acf, pacf, eacf, adf)[1:5],  # new
  lag = 1,
  out = NULL,
<<<<<<< HEAD
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
  
=======
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

>>>>>>> feature/common
  order = ar(df.afterDiff.ts)$order

  paste('diff: ', diffCount, '\n') %>% writeLines()

  diffAdfTest = adfTest(df.afterDiff.ts, lags = order, title = NULL, description = NULL)
  p <- diffAdfTest@test$p.value

  writeLines('\nadf p-value: ')
  if (p < 0.05) {
    paste(p, '< 0.05 significant\n') %>% writeLines()
    doPar(mfrow=c(1,1))
    if (showEacf) {
<<<<<<< HEAD
      eacf(df.afterDiff.ts)      
=======
      eacf(df.afterDiff.ts)
>>>>>>> feature/common
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
<<<<<<< HEAD
      main=plotTitle,
=======
      main=title,
>>>>>>> feature/common
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
<<<<<<< HEAD
  
  # return the diffed timeSeries object:
  # LATER: update so doesn't require output named 
=======

  # return the diffed timeSeries object:
  # LATER: update so doesn't require output named
>>>>>>> feature/common
  if (hasArg(out)) {
    # output.ts <- assign(out, df.afterDiff.ts)
    return(df.afterDiff.ts)
  }
<<<<<<< HEAD
  
=======

>>>>>>> feature/common
}

# depreciating function params
doDiffAndPlot <- function(
  df.ts,
  diffCount = 0,
  showPlot = TRUE,
  showEacf = FALSE,
  lag = 1,
  out = NULL,
<<<<<<< HEAD
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
  
=======
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

>>>>>>> feature/common
  order = ar(df.afterDiff.ts)$order

  paste('diff: ', diffCount, '\n') %>% writeLines()

  diffAdfTest = adfTest(df.afterDiff.ts, lags = order, title = NULL, description = NULL)
  p <- diffAdfTest@test$p.value

  writeLines('\nadf p-value: ')
  if (p < 0.05) {
    paste(p, '< 0.05 significant\n') %>% writeLines()
    doPar(mfrow=c(1,1))
    if (showEacf) {
<<<<<<< HEAD
      eacf(df.afterDiff.ts)      
=======
      eacf(df.afterDiff.ts)
>>>>>>> feature/common
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
<<<<<<< HEAD
      main=plotTitle,
=======
      main=title,
>>>>>>> feature/common
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
<<<<<<< HEAD
  
  # return the diffed timeSeries object:
  # LATER: update so doesn't require output named 
=======

  # return the diffed timeSeries object:
  # LATER: update so doesn't require output named
>>>>>>> feature/common
  if (hasArg(out)) {
    # output.ts <- assign(out, df.afterDiff.ts)
    return(df.afterDiff.ts)
  }
<<<<<<< HEAD
  
=======

>>>>>>> feature/common
}
