checkForbiddenModelCombination <- function() {
  # source: https://github.com/robjhyndman/forecast/blob/master/R/ets.R#L257
  if (restrict) {
    if ((errortype == "A" && (trendtype == "M" || seasontype == "M")) |
      (errortype == "M" && trendtype == "M" && seasontype == "A") ||
      (additive.only && (errortype == "M" || trendtype == "M" || seasontype == "M"))) {
      stop("Forbidden model combination")
    }
  }
}
# source:https://github.com/robjhyndman/forecast/blob/master/R/ets.R#L272

generateEtsModels <- function(df.ts) {
  etsModels <- list()

  errortypes = c('A','M')
  seasontypes <- trendtypes <- c('N','A','M')

  for(errortype in errortypes){
    for(trendtype in trendtypes){
      for(seasontype in seasontypes){
        if (
          (errortype == "A" && (trendtype == "M" || seasontype == "M")) |
          (errortype == "M" && trendtype == "M" && seasontype == "A")
        )
          {
            # print('forbidden model combination')
          } else {
            etsModels <- rbind(etsModels, paste0(errortype,trendtype,seasontype))
          }
  }}}
  return(etsModels)
}
etsModels <- generateEtsModels(data1.ts)

# ```
#
# ```{r message=FALSE, warning=FALSE, include=FALSE}
doEtsFit <- function(
  data.ts = 'data.ts',
  models = c('MNN', 'MMN', 'MMM', 'MAM'),
  showSummary = c(TRUE, FALSE)[1],
  showResiduals = c(TRUE, FALSE)[1],
  # other = c(isDiff, isDamp),
  isDiff = c(TRUE, FALSE)[2],
  isDamp = c(TRUE, FALSE)[2],
  k = 0
  ) {

  for (damp in isDamp) {
    for (modelType in models){
      isModelDiff <- ifelse(isDiff, 'diff.', '')
      isModelDamp <- ifelse(isDamp, 'damp.', '')

      tryCatch(
        {
          # Assign our Exponential Smoothing State Space Model
          originalModelName <- deparse(substitute(data.ts))
          modelName <- paste0('fit.', modelType, '.', isModelDiff, isModelDamp, originalModelName)
          # Exponential Smoothing State Space Model
          etsToAssign <- ets(data.ts + k, model = modelType, damped = isDamp)
          assign(modelName, etsToAssign, envir = .GlobalEnv)
          modelToTest <- get(modelName)
          # This is the equivalent to fit.data.MNN = ets(data.ts,model = "MNN")

          print(modelName)
          # if(showSummary == TRUE) {}
          if(showResiduals == TRUE) { checkresiduals(modelToTest) }
        },
        error = function(e) print(e)
        # ,
        # finally=print("finished")
      )
    }
  }
}
