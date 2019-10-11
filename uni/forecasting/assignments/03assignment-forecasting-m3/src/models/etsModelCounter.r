#'
#'Prepars a vector counter where value is updated by passing ets model name
#'ETS model name is ZZdZ, with d only for damped = T
#' there are a counter for AIC, AICC, BIC, HQIC, MASE
#'@param save.to.file where to save counters
#'@author Shadi Samir
#'
ets.model.counter <- function (save.to.file = "data/rda/ets.all.model.comb.rda") {
  e = c("N", "A", "M")
  t = c("N", "A", "M")
  s = c("N", "A", "M")
  
  etsModels = expand.grid(e, t, s, stringsAsFactors = FALSE) %>% as.matrix()
  models.size = nrow(etsModels) + 17
  models = array(NA, models.size)
  r = nrow(etsModels)

  #-- Convert to type "ETS" ----
  for (i in 1:nrow(etsModels)) {
    models[i] <- paste(etsModels[i, 1],
                       etsModels[i, 2],
                       etsModels[i, 3],
                       sep="")
    #-- handle damped, and append after etsModels length position
    if (etsModels[i, 2] == "A" || etsModels[i, 2] == "M") {
      model = models[i]
      models[r] = gsub('^(.{2})(.*)$', '\\1d\\2', model)
      r = r + 1
    }
  }

  ets.models.counter = list()
  for (c in 1:nrow(models)) {
    ets.models.counter[ models[c] ] = as.numeric(0)
  }

  ets.aic.models.counter = ets.models.counter
  ets.aicc.models.counter = ets.models.counter
  ets.bic.models.counter = ets.models.counter
  ets.hqic.models.counter = ets.models.counter
  ets.mase.models.counter = ets.models.counter

  if (!is.na(save.to.file)) {
    print("Saving Default counters to file...")
    save( ets.aic.models.counter,
          ets.aicc.models.counter,
          ets.bic.models.counter,
          ets.hqic.models.counter,
          ets.mase.models.counter,
          file = save.to.file ) 
  }
}

#--------------- encore de payee des marvie ---------------------
