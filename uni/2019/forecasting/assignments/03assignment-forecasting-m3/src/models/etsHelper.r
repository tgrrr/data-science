library(forecast)
source("src/common/Ts_ets_Type.R")

source("src/models/modelCountSummary.R")

#----ETS----
setClass(
  Class = "ETS",
  slots = c(
    alpha.opt = "numeric",
    beta.opt = "numeric",
    gamma.opt = "numeric",
    phi.opt = "numeric"
  )
)

#----ets.train.opt----
setClass(
  Class = "ets.train.opt",
  slots = c(
    trace = "ANY",
    #---- ets.train.opt: ICs ----
    aicc = "ANY",
    aic = "ANY",
    bic = "ANY",
    mase = "ANY",
    hqic = "ANY",
    #---- ets.train.opt: ICs.models ----
    fit.ets.opt.model = "ANY",
    #--- ets.train.opt: mean, meadian MASE ----
    mean.MASE = "ANY",
    sum.MASE = "ANY",
    median.MASE = "ANY"
  )
)

doGsub() <- function(modelType){
  gsub('^(.{2})(.*)$', '\\1d\\2', modelType)
}

#' @param data a numeric vector or time series of class \code{ts}
#' @param verbose display debug to screen or not, default is silent
#' @author Shadi Samir
#' @return returns a trace of all model's aicc, aic, bic and MASE sorted by
#' MASE, as well as optimal aicc, aic, bic and MASE individually \code{ets.opt}
train.ets <- function(
  data,
  verbose = FALSE,
  supress = TRUE
) {
  # error [M,A,Z]
  # trend [N,A,M,Z]
  # seasonal [N.A.M.Z]
  # additive only and MMM

  data.length <- length(data)
  if (supress) {
    errorType <- c("A", "M")
    trendType <- c("N", "A", "M")
    # turns out even with supressing they check seasonality
    if (isTsSeasonal(data)) {
      seasonType <- c("N", "A", "M")
    } else {
      seasonType <- c("N")
    }

    dampeds <- c(TRUE, FALSE) # try both if we have trend
  } else {
    # contains error, trend, seasonal types of data of class \code{TSType}
    train.data.TsType <- getTsType(data)
    if (verbose) {
      print(paste("train.data.TsType.error[", train.data.TsType$error, "]",
        "train.data.TsType.trend [", train.data.TsType$trend, "]",
        "train.data.TsType.seasonal [", train.data.TsType$seasonal,
        "]",
        sep = " "
      ))
    }

    dampeds <- c(FALSE) # Assume No trend
    trendType <- c("N")
    # TODO: N or not
    if (train.data.TsType$trend != "N") { # Trend in Data
      print("Data has trend, trendType is [A, M], exploring damped")
      trendType <- c("N", "A", "M") # train.data.TsType@trend
      dampeds <- c(TRUE, FALSE) # try both if we have trend
    } else {
      print("Data has no trend....")
    }

    # TODO: N or not
    seasonType <- c("N") # Assume no seasonality
    if (train.data.TsType$seasonal != "N") {
      print("Data is not seasonal, seasonType is [A, M]")
      seasonType <- c("N", "A", "M") # train.data.TsType@seasonal
    } else {
      print("Data is not seasonal....")
    }

    errorType <- c("N") # Assume no error
    if (train.data.TsType$error != "N") {
      print("Data error is not N, errorType is [A, M]")
      errorType <- c("A", "M") # train.data.TsType@residual
    } else {
      print("Data has no error type....")
    }
  }

  if (verbose) {
    print("----dampeds----")
    print(dampeds)
    print("-----errorType-----")
    print(errorType)
    print("-----Trend------")
    print(trendType)
    print("-----seasonType----")
    print(seasonType)
  }

  etsModels <- expand.grid(
    errorType, 
    trendType, 
    seasonType,
    stringsAsFactors = FALSE
  ) %>% as.matrix()
  if (verbose) {
    print("-----etsModels-------")
    print(etsModels)
  }

  models <- array(NA, nrow(etsModels))
  #---- Convert to type "ETS" ----
  for (r in 1:nrow(models)) {
    models[r] <- paste(
      etsModels[r, 1],
      etsModels[r, 2],
      etsModels[r, 3],
      sep = ""
    )
  }
  if (verbose) {
    print("-----models-----")
    print(models)
  }

  #---- remove forbiden models -----
  forbidenModels <- c(
    "AMN", "AMA", "AMM", # E: A, T: M,     S: N.A.M
    "ANM", "AAM", # E: A, T: N.A.M, S: M
    "MMA"
  ) # E: M, T: M,     S: M
  if (verbose) {
    print("---forbidenModels---")
    print(forbidenModels)
  }

  # if supress is enabled remove forbiden models
  if (!supress) {
    models <- models[ which(!(models %in% forbidenModels))]

    if (verbose) {
      print("---Removed fobiddenModels from models----")
      print("-----models-----")
      print(models)
    }
  }

  # models.length x dampeds.length matrix models
  ets.models.matrix <- expand.grid(models = models, dampeds = dampeds)
  if (verbose) {
    print("----ets.models.matrix---")
    print(ets.models.matrix)
  }

  # if trend is N combination dont use damped = T
  forbidenDampeds <- c(
    "ANN", "MNN",
    "ANA", "MNA",
    "ANM", "MNM"
  )
  if (verbose) {
    print("---forbidenDampeds---")
    print(forbidenDampeds)
  }

  #----remove illegal damped models combinations ----
  illegal.damped.condition <- (
    ets.models.matrix$models %in% forbidenDampeds
    & ets.models.matrix$dampeds == TRUE)
  legal.ets.models <- ets.models.matrix[ which(!illegal.damped.condition), ]

  #---ets.model.length----
  ets.model.length <- nrow(legal.ets.models)
  if (verbose) {
    print(paste("ets.model.length[ ", ets.model.length, " ]"))
  }

  #---- fit ets per model ICs, MASE HQIC init ----
  fit.ets.aic <- array(NA, ets.model.length)
  fit.ets.bic <- array(NA, ets.model.length)
  fit.ets.aicc <- array(NA, ets.model.length)
  fit.ets.mase <- array(NA, ets.model.length)
  fit.ets.HQIC <- array(NA, ets.model.length)
  # holds model string for AICC, AIC, BIC, MASE, HQIC, in this order
  fit.ets.opt.model <- array(NA, 5)
  # holds value of inscope models MASE, otherwise (0) for out of scope
  fit.inscope.model.mase <- array(NA, ets.model.length)

  levels <- array(NA, dim = c(ets.model.length, ncol(legal.ets.models)))

  # TODO:
  ics <- c("aicc", "aic", "bic")

  #---- optimal variables init ----
  ets.aic.opt <- Inf
  ets.bic.opt <- Inf
  ets.aicc.opt <- Inf
  ets.mase.opt <- Inf
  ets.HQIC.opt <- Inf

  sum.MASE <- 0

  # inverse logic of supress
  fit.restrict <- as.logical(ifelse(supress, "F", "T"))
  if (verbose) {
    print(paste("fit.restrict[ ", fit.restrict, " ]"))
  }

  # TODO: handle negative data
  #  data.positive <- (min(y) > 0)
  # if (!data.positive && errortype == "M") { # exclude model or add offset

  #---- for each model run ets capture ICs, HQIC, MASE, and sum.MASE -----
  for (i in seq_len(ets.model.length)) {
    modelType <- toString(legal.ets.models$models[i])
    # FIXME: true/false vs T/F
    dampedType <- ifelse(trimws(legal.ets.models$dampeds[i]), "T", "F")
    if (verbose) {
      print(paste(
        "modelType[ ", modelType, " ]",
        "dampedType[ ", dampedType, " ]"
      ))
    }

    levels[i, 1] <- modelType
    levels[i, 2] <- dampedType

    if (verbose) {
      print(paste(
        "Calling fit.ets with [ ", modelType, " ]",
        "Damped [ ", dampedType, " ]"
      ))
    }
    # damped = F no Beta;
    # T: Alpha, beta, phi, both sigma 0.0447
    fit.ets <- ets(
      y = data,
      model = modelType,
      damped = as.logical(dampedType),
      restrict = fit.restrict,
      ic = ics
    )
    if (verbose) {
      print("Getting ICs....")
    }

    #--- AICC ----
    if (!is.null(fit.ets$aicc)) {
      fit.ets.aicc[i] <- fit.ets$aicc

      if (ets.aicc.opt > fit.ets.aicc[i]) {
        ets.aicc.opt <- fit.ets.aicc[i]
        fit.ets.opt.model[1] <-
          ifelse(
            dampedType,
            doGsub(),
            modelType
          )
      }
    } else {
      fit.ets.aicc[i] <- Inf
    }

    #--- AIC ----
    if (!is.null(fit.ets$aic)) {
      fit.ets.aic[i] <- fit.ets$aic

      if (ets.aic.opt > fit.ets.aic[i]) {
        ets.aic.opt <- fit.ets.aic[i]
        fit.ets.opt.model[2] <-
          ifelse(dampedType,
            doGsub(),
            modelType
          )
      }
    } else {
      fit.ets.aic[i] <- Inf
    }

    #--- BIC ----
    if (!is.null(fit.ets$bic)) {
      fit.ets.bic[i] <- fit.ets$bic

      if (ets.bic.opt > fit.ets.bic[i]) {
        ets.bic.opt <- fit.ets.bic[i]
        fit.ets.opt.model[3] <-
          ifelse(dampedType,
            doGsub(),
            modelType
          )
      }
    } else {
      fit.ets.bic[i] <- Inf
    }

    #---- MASE ----
    if (!is.null(accuracy(fit.ets)[6])) {
      fit.ets.mase[i] <- accuracy(fit.ets)[6]

      if (ets.mase.opt > fit.ets.mase[i]) { # update opt mase
        ets.mase.opt <- fit.ets.mase[i]
        fit.ets.opt.model[4] <-
          ifelse(dampedType,
            doGsub(),
            modelType
          )
      }

      #---- sum.MASE ----
      sum.MASE <- sum.MASE + fit.ets.mase[i]
      fit.inscope.model.mase[i] <- fit.ets.mase[i]
    } else {
      fit.ets.mase[i] <- Inf
      fit.inscope.model.mase[i] <- 0.0 # we didn't use model at slot
    }

    #--- HQIC ----
    q <- length(fit.ets$par)
    fit.ets.HQIC[i] <- -2 * fit.ets$loglik + 2 * q * log(log(data.length))
    if (ets.HQIC.opt > fit.ets.HQIC[i]) {
      ets.HQIC.opt <- fit.ets.HQIC[i]
      fit.ets.opt.model[5] <-
        ifelse(dampedType,
          doGsub(),
          modelType
        )
    }
  } # for

  #---- ets.results ----
  ets.trace <- data.frame(
    levels,
    fit.ets.aicc,
    fit.ets.aic,
    fit.ets.bic,
    fit.ets.mase,
    fit.ets.HQIC
  )

  ets.trace.sorted <- ets.trace[order(ets.trace[, 7],
    decreasing = FALSE
  ), ]

  colnames(ets.trace.sorted) <- c(
    "Model", "Damped",
    "AICc",
    "AIC",
    "BIC",
    "HQIC",
    "T.MASE"
  )
  if (verbose) {
    print("returning...")
  }

  #---- ets.train.opt.return ----
  return(new(
    Class = "ets.train.opt",
    trace = ets.trace.sorted,
    mase = ets.mase.opt,
    aicc = ets.aicc.opt,
    aic = ets.aic.opt,
    bic = ets.bic.opt,
    hqic = ets.HQIC.opt,
    fit.ets.opt.model = fit.ets.opt.model,
    mean.MASE = sum.MASE / data.length,
    sum.MASE = sum.MASE,
    median.MASE = median(fit.inscope.model.mase)
  ))
}
