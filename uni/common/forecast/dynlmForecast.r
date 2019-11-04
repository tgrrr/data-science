doDynlmForecast <- function(
  dynlm.model = dynlm.model.k1.13.selected.noTrend,
  q = 24
  ) {

  n = nrow(dynlm.model$model)
  dynlm.frc = array(NA, (n + q))
  dynlm.frc[1:n] = Y.t[4:length(Y.t)]
  # our model doesn't have trend
  # trend = array(NA,q)
  # trend.start = dynlm.model$model[n,"trend(Y.t)"]
  # trend = seq(trend.start , trend.start + q/12, 1/12)

  for (i in 1:q) {
    months = array(0,11)
    months[(i-1)%%12] = 1
    # print(months)
    data.new = c(
      1,
      dynlm.frc[n-1+i],
      dynlm.frc[n-2+i],
      dynlm.frc[n-4+i],
      dynlm.frc[n-5+i],
      dynlm.frc[n-9+i],
      dynlm.frc[n-11+i],
      dynlm.frc[n-12+i],
      dynlm.frc[n-13+i],
      1,
      months
    )
    dynlm.frc[n+i] = as.vector(dynlm.model$coefficients) %*% data.new
  }

  return(dynlm.frc)
}
