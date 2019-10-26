library(urca)

# REFACTOR: refactor
# REFACTOR: plot names
#' Title
#'
#' @param x 
#'
#' @return
#' @export
#'
#' @examples
doPlotAnalysis <- function(x)
{
  par(mfrow=c(1,3))

  plot(
    x,
    type = 'l',
    #REFACTOR: ylab = "Relative temperature change", xlab = "Year", main = "Global warming series"
  )
  acf(x)
  pacf(x)

  # augmented Dickey Fuller:
  adf.x = ur.df(
    x,
    type = "none",
    lags = 1,
    selectlags =  "AIC"
  )
  summary(adf.x)

  # Phillips-Perron Unit Root Test:
  pp.x = ur.pp(
    x,
    type = "Z-alpha",
    lags = "short"
  )
  summary(pp.x)

  # if (hasArg(out)) {
    # output.ts <- assign(out, df.afterDiff.ts)
    # return(df.afterDiff.ts)
  # }

}
