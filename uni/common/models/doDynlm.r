doDynlm <- function(
  Y.t = Y.t,
  k = 8,
  intervention = 'S.t1.lag1',
  trend = 'trend(Y.t)',
  season = 'season(Y.t)',
  summary = FALSE
  ) {
  # LATER: move trend() and season() into function

  dynlm.params <- reformulate(
    c(paste0('L(Y.t,', 1:k,')'), # create 'L(Y.t,k=1) + L(Y.t,k=2)'... :
      intervention,
      trend,
      season),
    'Y.t')
  # createVariableNames(dynlm.params)
  dynlm.model = dynlm(dynlm.params)
  bg <- bgtest(dynlm.model)$p.value
  aicResult <- AIC(dynlm.model)
  # rSquared <- summary(dynlm.model)$adj.r.square
  # aicName <- c(paste0(aicResult,' L(Y.t,', k,') ', 'R Squared: ', rSquared))
  # return(list(aicResult, dynlm.params, aicName))
  x <- data.frame("Models" = toString(dynlm.params), "AICs" = aicResult)
  df <-x[order(x$AICs),]
  # df
  # cat('aicResult', aicResult, '\nbgtest', bg, '\n')
  # print('lm params')
  # print(dynlm.params)
  return(c('aicResult', aicResult, 'bgtest', bg, dynlm.params ))
}
