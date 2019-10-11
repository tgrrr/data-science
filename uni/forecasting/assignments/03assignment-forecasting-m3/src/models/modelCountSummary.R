#' loads default counter for all ets models (including forbidden combinations)
#' there are a counter for AIC, AICC, BIC, HQIC, MASE
#' Saves the counters to a specific file.
#'
#' @param ets.train \cls{ets.train.opt}
#' @param save.to.file name of file to save all counters
#' @author Shadi Samir
#'
model.count.summary <- function(ets.train.opt,
                                save.to.file) {
  # all model combination counters
  load(file = "rda/ets.all.model.comb.rda") # fresh load
  print("default counter model laoded...")

  opt.len <- length(ets.train.opt)
  print(paste("processing [", opt.len, "]", "results...", sep = " "))

  for (s in 1:opt.len) { # each series
    opt.model <- ets.train.opt[[s]]@fit.ets.opt.model

    ets.aicc.models.counter[opt.model[1]] <-
      as.numeric(ets.aicc.models.counter[opt.model[1]]) + 1
    ets.aic.models.counter[opt.model[2]] <-
      as.numeric(ets.aic.models.counter[opt.model[2]]) + 1
    ets.bic.models.counter[opt.model[3]] <-
      as.numeric(ets.bic.models.counter[opt.model[3]]) + 1
    ets.hqic.models.counter[opt.model[4]] <-
      as.numeric(ets.hqic.models.counter[opt.model[4]]) + 1
    ets.mase.models.counter[opt.model[5]] <-
      as.numeric(ets.mase.models.counter[opt.model[5]]) + 1
  }

  aicc.models <- ets.aicc.models.counter[ which(ets.aicc.models.counter != 0) ]
  aic.models <- ets.aic.models.counter[ which(ets.aic.models.counter != 0) ]
  bic.models <- ets.bic.models.counter[ which(ets.bic.models.counter != 0) ]
  hqic.models <- ets.hqic.models.counter[ which(ets.hqic.models.counter != 0) ]
  mase.models <- ets.mase.models.counter[ which(ets.mase.models.counter != 0) ]

  aicc.models.c <- Reduce("+", x = aicc.models)
  aic.models.c <- Reduce("+", x = aic.models)
  bic.models.c <- Reduce("+", x = bic.models)
  hqic.models.c <- Reduce("+", x = hqic.models)
  mase.models.c <- Reduce("+", x = mase.models)

  #---- diagnostics ----
  if (opt.len != aicc.models.c) {
    print(paste("AICC model count [ ", aicc.models.c, " ] didn't match"))
  }
  if (opt.len != aic.models.c) {
    print(paste("AIC model count [ ", aic.models.c, " ] didn't match"))
  }
  if (opt.len != bic.models.c) {
    print(paste("BIC model count [ ", bic.models.c, " ] didn't match"))
  }
  if (opt.len != hqic.models.c) {
    print(paste("HQIC model count [ ", hqic.models.c, " ] didn't match"))
  }
  if (opt.len != mase.models.c) {
    print(paste("MASE model count [ ", mase.models.c, " ] didn't match"))
  }

  #---- save ----
  if (!is.na(save.to.file)) {
    print(paste("Saving update counters to file [ ", save.to.file, " ]"))
    save(ets.aic.models.counter,
      ets.aicc.models.counter,
      ets.bic.models.counter,
      ets.hqic.models.counter,
      ets.mase.models.counter,
      aic.models,
      aicc.models,
      bic.models,
      hqic.models,
      mase.models,
      file = save.to.file
    )
  }
}

#' Return list of Trainning and valiation MASE
#'
#' @param data.stacked data that has valid and train
#' @param ets.model    which model to try
#' @param verbose verbose
#' @return list containing all series t.mase and v.mase
#' @author Shadi Samir
#'
data.valid.accuracy <- function(data.stacked,
                                ets.model,
                                verbose = TRUE) {
  data.valid <- data.stacked[["valid.stack"]]
  data.train <- data.stacked[[ "train.stack" ]]

  if (length(data.train) != length(data.valid)) {
    stop("Valied series isn't same length as training")
  }

  Tmase.list <- list()
  Vmase.list <- list()
  data.length <- length(data.train)
  print(paste(
    "Finding MASE for [ ", data.length, " ] serie(s)",
    "ets.mode [ ", ets.model, "]"
  ))

  for (cnt in 1:data.length) {
    series.acc <-
      series.valid.accuracy(
        series.train = data.train[[ cnt ]],
        series.valid = data.valid[[ cnt ]],
        model = ets.model,
        verbose = verbose
      )
    Tmase.list[cnt] <- series.acc$t.mase
    Vmase.list[cnt] <- series.acc$v.mase
  }

  print("returning mase.list...")
  return(list(data.T.mase = Tmase.list, data.V.mase = Vmase.list))
}

#' Return list of Trainning and valiation MASE for a series
#'
#' @param series.train series training \cls{ts}
#' @param series.valid series validation \cls{ts}
#' @param ets.model    which model to try
#' @param verbose verbose
#' @return list containing series t.mase and v.mase
#' @author Shadi Samir
#'
series.valid.accuracy <- function(series.train,
                                  series.valid,
                                  model,
                                  verbose = FALSE) {
  model.name <- toString(model)
  is.damped <- str_detect(model.name, "d")

  if (is.damped) {
    damped <- T
    model.name <- str_remove(model.name, "d")
  } else {
    damped <- F
  }

  if (verbose) {
    print(paste("model.name [", model.name, "]",
      "damped [", damped, "]",
      sep = " "
    ))
  }
  # forecast validation
  fc <- forecast.ets(
    ets(series.train, model = model.name, damped = damped),
    h = length(series.valid)
  )
  if (verbose) {
    print("data forecasted")
  }

  acc <- accuracy(fc, series.valid)
  if (verbose) {
    print("----acc----")
    print(acc)
  }

  t.mase <- acc["Training set", "MASE"]
  v.mase <- acc["Test set", "MASE"]
  if (verbose) {
    print(paste("t.mase[", t.mase, "]",
      "v.mase[", v.mase, "]",
      sep = " "
    ))
  }

  return(list(t.mase = t.mase, v.mase = v.mase))
}

#----------- Dont cry for me R-int-ina-----------
