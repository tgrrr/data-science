doResiduals <- function(x, residuals = c('residuals', 'bg', 'vif')[1:3], ...) {
  # This is very much a WIP function
  # use at your own risk!
  checkresiduals(x$model$residuals)
  # BreuscGodfrey
  print(bgtest(x$model)$p.value)

  # Variance Inflation Factors
  VIF.model = vif(x$model) #
  VIF.model > 10

  # > LATER: the Breusch-Godfrey test is displayed to test the existence of serial correlation up to the displayed order. According to this test and ACF plot we can conclude that the serial correlation left in residuals is highly significant

}
