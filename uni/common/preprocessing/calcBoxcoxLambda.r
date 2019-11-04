calcBoxcoxLambda <- function(x, plotit = TRUE) {
  doPar(mfrow = c(1,2))
  x.boxcox.ts <- BoxCox.ar(x,method = "yule-walker")
  return(lambda <- x.boxcox.ts$ci)
}
