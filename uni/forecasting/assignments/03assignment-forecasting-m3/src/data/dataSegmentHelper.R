#----Fresh----
rm(list = ls())

#---- Source -----
source("src/common/Consts.R")

#---- load -----
load(file = "data/rda/m3_reduced.rda")

#' Stacks all ts.x into one list
#' @author Shadi Samir
#' @param data one of m3.comp.reduced. {yearly, monthly, quarterly}
#' @param verbose verbose
getStackedData <- function(
  data,
  verbose = TRUE
) {
  train.stack <- list()
  data.stack <- list()
  valid.stack <- list()

  for (i in 1:length(data)) {
    train.stack[[i]] <- data[[i]]$x
    valid.stack[[i]] <- data[[i]]$xx
    data.stack[[i]] <- data[[i]]$series
  }

  if (length(data) == length(data.stack)) {
    print("Successfully stacked...")
  } else {
    print("Ouch, the odds didn't stack...")
  }

  return(list(
    data.stack = data.stack,
    train.stack = train.stack,
    valid.stack = valid.stack
  ))
}


#' Segments data based on type key
#' @author Shadi Samir
#' @param data one of m3.comp.reduced. {yearly, monthly, quarterly}
#' @param type.key target value vector
#' @param verbose verbose
getDataByType <- function(data,
                          type.key,
                          verbose = TRUE) {
  if (verbose) {
    print(paste("Attempting to segment data based on [", type.key, "]",
      sep = " "
    ))
  }

  pos <- 1
  data.segment <- list()
  train.segment <- list()
  valid.segment <- list()

  for (i in 1:length(data)) {
    if (data[[i]]$type %in% type.key) {
      data.segment[[pos]] <- data[[i]]$series
      train.segment[[pos]] <- data[[i]]$x
      valid.segment[[pos]] <- data[[i]]$xx

      pos <- pos + 1
    }
  }

  if (verbose) {
    print(paste("Found [", length(data.segment), "] elements",
      sep = " "
    ))
  }

  return(list(
    data.segment = data.segment,
    train.segment = train.segment,
    valid.segment = valid.segment
  ))
}

#' Segments data based on series length
#' @author Shadi Samir
#' @param data one of m3.comp.reduced. {yearly, monthly, quarterly}
#' @param target.n target value vector
#' @param verbose verbose
getDataByN <- function(data,
                       target.n,
                       verbose = TRUE) {
  if (verbose) {
    print(paste("Attempting to segment data based on [", target.n, "]",
      sep = " "
    ))
  }

  pos <- 1
  data.segment <- list()
  train.segment <- list()
  valid.segment <- list()

  for (i in 1:length(data)) {
    if (data[[i]]$n %in% target.n) {
      if (verbose) {
        print(paste("[", data[[i]]$n, "] in [", target.n, "]", sep = " "))
      }

      data.segment[[pos]] <- data[[i]]$series
      train.segment[[pos]] <- data[[i]]$x
      valid.segment[[pos]] <- data[[i]]$xx

      pos <- pos + 1
    }
  }
  if (verbose) {
    print(paste("Found [", length(data.segment), "] elements",
      sep = " "
    ))
  }

  return(list(
    data.segment = data.segment,
    train.segment = train.segment,
    valid.segment = valid.segment
  ))
}

#' Segments data based on catogeory list and series length
#' @author Shadi Samir
#' @param m3.reduced.data one of m3.comp.reduced. {yearly, monthly, quarterly}
#' @param category.list list of categories to segmenet data on
#' @param n.list list of series length to segment data on
#' @param verbose verbose
segmentData <- function(m3.reduced.data,
                        category.list,
                        n.list,
                        verbose = FALSE) {
  data.segment <- list()
  if (verbose) {
    print("Segmenting yearly based on category")
  }
  for (category in category.list) {
    data.segment[[category]] <- getDataByType(
      data = m3.reduced.data,
      type.key = category,
      verbose = verbose
    )
  }

  if (verbose) {
    print("Segmenting yearly based on n")
  }
  for (n in n.list) {
    data.segment[[n]] <- getDataByN(
      data = m3.reduced.data,
      target.n = n,
      verbose = verbose
    )
  }

  return(data.segment)
}

#----Main-----
##############
segment <- function(verbose = FALSE) {
  print("linking Consts.R....")
  source("Consts.R")

  #---- load -----
  print("loading m3 data...")
  load(file = "rda/m3_reduced.rda")

  #----yearly.data.segment----
  print(" Segmenting yearly data... ")
  yearly.data.segment <- segmentData(
    m3.reduced.data = m3.comp.reduced.yearly,
    category.list = category.list,
    n.list = yearly.n.list,
    verbose = verbose
  )
  #---monthly.data.segment----
  print(" Segmenting monthly data... ")
  monthly.data.segment <- segmentData(
    m3.reduced.data = m3.comp.reduced.monthly,
    category.list = category.list,
    n.list = monthly.n.list,
    verbose = verbose
  )
  #----qrt.data.segment----
  print(" Segmenting quarterly data... ")
  qrt.data.segment <- segmentData(
    m3.reduced.data = m3.comp.reduced.quarterly,
    category.list = category.list,
    n.list = qrt.n.list,
    verbose = verbose
  )
  #----Stacking ----
  print(" Stacking yearly data... ")
  yearly.stacked <- getStackedData(data = m3.comp.reduced.yearly, verbose = verbose)
  print(" Stacking monthy data... ")
  monthly.stacked <- getStackedData(data = m3.comp.reduced.monthly, verbose = verbose)
  print(" Stacking quarterly data... ")
  qrt.stacked <- getStackedData(data = m3.comp.reduced.quarterly, verbose = verbose)

  #---- save to RDA ----
  rda.file <- "data/rda/m3.data.segments.rda"
  save(yearly.stacked,
    monthly.stacked,
    qrt.stacked,
    yearly.data.segment,
    monthly.data.segment,
    qrt.data.segment,
    file = rda.file
  )
}

# segment()

#-------FINITO LA MUSICA------------------
