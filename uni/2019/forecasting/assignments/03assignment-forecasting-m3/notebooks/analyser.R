#----Fresh----
rm(list = ls())

source('config.r')
setwd(PATH)

#----RefreshData ----
refresh.data <- function() {
  # load data from XLS
  source("src/common/Consts.R")
  source("src/data/loadM3Reduced.R")
  loadM3Reduced()

  # segment data
  source("src/data/dataSegmentHelper.R")
  segment()

  print("Data is now refreshed")
}
# if data refresh is required use this function
# refresh.data()

#----Load RDA----
load(file = "data/rda/m3_reduced.rda")
load(file = "data/rda/m3.data.segments.rda")

#---- include ----
# library(forecast)
# library(expsmooth)
# library(dplyr)
# library(parallel)
# library(english)
# library(directlabels)
# library(stringr)

# devtools::install_git('https://gitlab.com/botbotdotdotcom/packagr')
library(packagr)
packages <- c(
  'forecast',
  'expsmooth',
  'dplyr',
  'parallel',
  'english',
  'directlabels',
  'stringr'
)
packagr(packages) # alpha package to check, install and load packages

#---- Source ----
source("src/common/Consts.R")
source("src/models/etsHelper.r")
source("src/features/LEIC.R")
source("src/features/pVal.R")

#' @param data
#' @param suppress if T ets will bypass all restrictions by setting
#' restriction to F
#' @param verbose verbose
#' @return \cls{ets.train.opt}
#' @author Shadi Samir
run.series.opt.model <- function(
  data,
  suppress = FALSE,
  verbose = FALSE) {
  ets.train <- list()

  # Get optimal models for all data
  for (pos in 1:length(data)) {
    print(paste("***Processing S[", pos, "]", sep = " "))
    ets.train[pos] <- train.ets(
      data = data[[pos]],
      supress = suppress,
      verbose = verbose
    )
  }

  return(ets.train)
}

#' @param pval.result.rda where results are saved
#' @return string containing best model
best.model.pVal <- function(models,
                            pval.result.rda,
                            verbose = TRUE) {
  #---- get modes with highest count, use that model for all series -----
  load(pval.result.rda)
  print("loaded pval results file...")

  model.count <- list()
  best.model.count <- 0
  best.model <- ""

  for (pos in 1:length(models)) {
    model.name <- models[[pos]]

    model.count[[ model.name ]] <- p.result$best.model[
      which(p.result$best.model == model.name, arr.ind = T)
    ] %>% length()
    if (verbose) {
      print(paste("[ ", model.name, " ]: ", model.count[[ model.name ]], " ]"))
    }

    if (best.model.count < model.count[[ model.name ]]) {
      best.model.count <- model.count[[ model.name ]]
      best.model <- model.name
    }
  }

  print(paste("best model for data is [", best.model, "]",
    "With count [", best.model.count, "]",
    sep = " "
  ))

  return(best.model)
}

#' @param ets.count.file model counter file
#' @return candiate models names E, T (d), S types
candidate.models <- function(ets.count.file,
                             verbose = TRUE) {
  #---- get model counters exmple ----
  load(ets.count.file)

  if (verbose) {
    print("----aic.models----")
    print(aic.models)
    print("----aicc.models----")
    print(aicc.models)
    print("----bic.models----")
    print(bic.models)
    print("----hqic.models----")
    print(hqic.models)
    print("----mase.models----")
    print(mase.models)
  }

  top.models <- list()
  top.models[[ 1 ]] <- aic.models[ which.max(aic.models) ]
  top.models[[ 2 ]] <- aicc.models[ which.max(aicc.models) ]
  top.models[[ 3 ]] <- bic.models[ which.max(bic.models) ]
  top.models[[ 4 ]] <- hqic.models[ which.max(hqic.models) ]
  top.models[[ 5 ]] <- mase.models[ which.max(mase.models) ]

  if (verbose) {
    print("----top.models----")
    print(top.models)
  }

  #---- extract model candidates -----
  models.names <- list()
  for (tpm in 1:length(top.models)) {
    models.names[tpm] <- names(top.models[[tpm]])
  }

  candidate.models <- list()
  candidate.models <- unique(models.names)

  if (verbose) {
    print("----candidate.models----")
    print(candidate.models)
  }

  return(candidate.models)
}

data.frc.mase <- function(data,
                          h,
                          candidate.models,
                          save.to.file,
                          verbose = FALSE) {
  print("Calling pVal...")
  # TODO cluster this
  p.result <- pVal(data = data, H = h, models = candidate.models)

  print("saving to file...")
  save(p.result, file = save.to.file)

  print("Processing pval to get best model...")
  best.qrt.model <- best.model.pVal(
    models = candidate.models,
    pval.result.rda = save.to.file,
    verbose = verbose
  )
  print("returing best model")
  return(best.qrt.model)
}

# - monthly data
# - 5 different kind of criteria to assess models
# - Based on AIC, the MMdM is the best fit for 70 series
#' @param
best.valid.model <- function(candidate.models,
                             data.stacked,
                             verbose = FALSE) {
  mean.Tmase <- list()
  mean.Vmase <- list()
  for (i in 1:length(candidate.models)) {
    model.name <- candidate.models[[i]]

    acc <- data.valid.accuracy(
      data.stacked = data.stacked,
      ets.model = model.name,
      verbose = verbose
    )
    mean.Tmase[[ model.name ]] <- mean(as.numeric(acc$data.T.mase))
    mean.Vmase[[ model.name ]] <- mean(as.numeric(acc$data.V.mase))
  }
  if (verbose) {
    print("---mean.Tmase")
    print(mean.Tmase)
    print("---mean.Vmase")
    print(mean.Vmase)
  }

  # - Count = Count of which model (eg MMdM) was the best fit for each series
  # who won?
  best.model <- names(mean.Vmase[ which.min(mean.Vmase) ])
  best.model.v.mase <- mean.Vmase[[ best.model ]]
  best.model.t.mase <- mean.Tmase[[ best.model ]]
  print(paste(
    "best.model [", best.model, "]",
    "t.mase [", best.model.t.mase, "]",
    "v.mase [", best.model.v.mase, "]"
  ))

  return(list(
    best.model = best.model,
    best.model.t.mase = best.model.t.mase,
    best.model.v.mase = best.model.v.mase
  ))
}

#---- segmented data----
category <- category.list[[1]] # MICRO
segment <- segment.list[[1]] # data.segment
stack <- stack.list[[1]] # data.stack
yearlys.n <- yearly.n.list[[1]] # 20

#---- data.segment ----
# data = yearly.data.segment[[category]][[segment]]
# data = monthly.data.segment[[category]][[segment]]
# data = qrt.data.segment[[category]][[segment]]

#---- stacked ----
# data = yearly.stacked[["data.stack"]] #entire year
data <- monthly.stacked[["data.stack"]] # entire month
# data = qrt.stacked[["data.stack"]] #entire qrt

sprs <- F # for now use T and dont change it
#----try various models and get stats, then save it
monthly.stacked.ets.train.no.spress <-
  run.series.opt.model(data, suppress = sprs, verbose = FALSE)

#----ets.trin----
# ets.train = monthly.stacked.ets.train
# ets.train = yearly.stacked.ets.train
# ets.train = qrt.stacked.ets.train
ets.train <- monthly.stacked.ets.train.no.spress
# ets.train = yearly.stacked.ets.train.no.spress
# ets.train = qrt.stacked.ets.train.no.spress

#----save ets.train function rda.list----
# ets.train.file = "rda/data.ets.qrt.stacked.rda"
ets.train.file <- "rda/data.ets.monthly.stacked.rda"
# ets.train.file = "rda/data.ets.yearly.stacked.rda"
# ets.train.file = "rda/data.ets.qrt.stacked.nospress.rda"
# ets.train.file = "rda/data.ets.monthly.stacked.nospress.rda"
# ets.train.file = "rda/data.ets.yearly.stacked.nospress.rda"

#---Save results to ets.train.file ----
save(ets.train, file = ets.train.file)

#--- data model counters ----
ets.count.file <- "rda/monthly.series.fit.count.nospress.rda"
# ets.count.file = "rda/qrt.series.fit.count.nospress.rda"
# ets.count.file = "rda/yearly.series.fit.count.nospress.rda"
# ets.count.file = "rda/monthly.series.fit.count.rda"
# ets.count.file = "rda/qrt.series.fit.count.rda"
# ets.count.file = "rda/yearly.series.fit.count.rda"
load(ets.train.file)
model.count.summary(ets.train.opt = ets.train, save.to.file = ets.count.file)
candidate.models <- candidate.models(ets.count.file = ets.count.file, verbose = TRUE)

# Monthly results
# MNM, MNN, MMDM using sprs F
# MNM, MNN, AMDM using sprs T -> AMDM was best
# Add ANM, ANA and AAM to the mix

#----find out Training & validation mean MASE ------
print("Training and Validation MASE")
bvm <- best.valid.model(
  candidate.models = candidate.models,
  data.stacked = monthly.stacked
)
# sprs = T We get this below result
# AMdM [0.410212775743085 ] v.mase [ 0.599146304704005 ]

# pval.file = "rda/m.data.pval.rda"
# pval.file = "rda/y.data.pval.rda"
# pval.file = "rda/q.data.pval.rda"
pval.file <- "rda/m.nospress.data.pval.rda"
# pval.file = "rda/y.nospress.data.pval.rda"
# pval.file = "rda/q.nospress.data.pval.rda"
monthly.mase <- data.frc.mase(
  data = data,
  h = 8, # 6, 8, 18,
  candidate.models,
  save.to.file = pval.file
)

#----Unified horizon---- mase is smaller than the bvm
AMdM.m.mase <- data.frc.mase(
  data = data,
  h = 8, # 8, 18,
  c("AMdM"),
  save.to.file = "rda/amdm.m.data.rda"
)
load("rda/amdm.m.data.rda")
mean.Vmases.yearly <- mean(as.numeric(p.result$MASEs))
mean.Tmase.yearly <- mean(as.numeric(p.result$MASE))
# amdm.m.data.rda: V.MASE = 0.4098686 , T.MASE 0.0517125
# TODO
# leic.result <- LEIC(data = data, H = H, models = models)
