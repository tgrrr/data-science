# AIC and BIC sorting function by Cameron Doyle
sort.score <- function(x, score = c("bic", "aic")){
  if (score == "aic"){
    out = x[with(x, order(AIC)),]
  } else if (score == "bic") {
    out = x[with(x, order(BIC)),]
  } else {
    out = warning('score = "x" only accepts valid arguments ("aic","bic")')
  }
  return(out)
}
# AIC and BIC sorting function by Cameron Doyle
