calcNormality <- function(x, lambda, plotit = TRUE) {

  x.boxcox = (x^lambda-1)/lambda
  shapiroPValue <- shapiro.test(x.boxcox)$p.value

  if(plotit) {
    qqnorm(x.boxcox)
    qqline(x.boxcox, col = 2)
    # LATER: title(fig_nums('boxcox_ci','Confidence Interval of Lambda'), line = -1.5, outer = TRUE)
  }

  return(shapiroPValue)
}
