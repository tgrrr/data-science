#----Fresh----
rm(list = ls())

setwd("~/code/03assignment-forecasting-m3/")

#---- include ----
library("readxl")
library("tidyverse")
library("lubridate")
library(zoo)

add.year <- function(date, n) return(ymd(date) + years(n))

# TODO: rounding?
add.months <- function(date, n) seq(date,
    by = paste(n, "months"),
    length = 2
  )[2]

#' Loads a row from XLS to a data structure of form:
#' sn = series.name format: @param seriesType + XLS.row.number
#' n = series.length
#' h = series.NF
#' period = s.period
#' type = series.category
#' x = train.ts
#' xx = valid.ts
#' t.start = train.start.c
#' t.end = train.end.c
#' v.start = valid.start.c
#' v.end = valid.end.c
#' @author Shadi Samir
#' @param M3.data.xls WB Sheet containing M3Data on format: N,NF,Category, Starting Year,Starting Month, x1,..xn
#' @param seriesType one of Y - Yearly, M - Monthly, Q - Quarterly
#' @param data.split train data percentage
#' @param verbose verbose
#' @return
parseMData <- function(M3.data.xls,
                       seriesType,
                       data.split = .95,
                       verbose = FALSE,
                       verbose.TS = FALSE) {
  #---series Type: period and frequency ----
  if (seriesType == "Y") {
    s.period <- "Yearly"
    data.freq <- 1
  } else if (seriesType == "M") {
    s.period <- "Monthly"
    data.freq <- 12
  } else if (seriesType == "Q") {
    s.period <- "Quarterly"
    data.freq <- 4
  }

  if (verbose) {
    print(paste("s.period [", s.period, "]",
      "data.freq [", data.freq, "]",
      sep = " "
    ))
  }
  # TODO: -1? for header?
  #---data.m.series ----
  M3.data.m.series <- seq(1, nrow(M3.data.xls), by = 1)
  if (verbose) {
    print(paste("Processing : [", nrow(M3.data.xls), "] series...", sep = " "))
  }

  m3.comp.reduced <- list()

  #---- loop through each series detail ----
  for (i in M3.data.m.series) {

    #----Series MetaData ----
    series.name <- paste(s.period, i, sep = "")
    series.length <- M3.data.xls$N[i]
    series.category <- M3.data.xls$Category[i]
    series.NF <- M3.data.xls$NF[i]
    if (verbose) {
      print(paste("Series [", i, "]",
        "series.length [", series.length, "]",
        "series.category [", series.category, "]",
        sep = " "
      ))
    }

    #---- Split data to train and validation ----
    series.train.size <- floor(series.length * data.split)
    series.valid.size <- series.length - series.train.size
    if (verbose) {
      print(paste("series.NF [", series.NF, "]",
        "series.train.size [", series.train.size, "]",
        "series.valid.size [", series.valid.size, "]",
        sep = " "
      ))
    }

    #---- series start and end dates for train and validation ----
    if (seriesType == "Y") {
      start.date <- paste(as.character(M3.data.xls$`Starting Year`[i]),
        as.character(1),
        as.character(1),
        sep = "/"
      ) %>% as.Date()

      train.end <- add.year(start.date, series.train.size)
      valid.start <- train.end
      valid.end <- add.year(valid.start, series.valid.size - 1)
    } else if (seriesType == "M") {
      start.date <- paste(as.character(M3.data.xls$`Starting Year`[i]),
        as.character(M3.data.xls$`Starting Month`[i]),
        as.character(1),
        sep = "/"
      ) %>% as.Date()

      train.end <- add.months(start.date, series.train.size)
      valid.start <- train.end
      valid.end <- add.months(valid.start, series.valid.size - 1)
    } else if (seriesType == "Q") {
      start.date <- paste(as.character(M3.data.xls$`Starting Year`[i]),
        as.character(M3.data.xls$`Starting Quarter`[i]),
        as.character(1),
        sep = "/"
      ) %>% as.Date()

      train.end <- as.yearqtr(start.date) + floor(series.train.size / 4)
      valid.start <- add.months(as.Date(train.end), 3) # %>% as.yearqtr()
      valid.end <- as.yearqtr(valid.start) + floor(series.valid.size / 4)

      train.end <- as.Date(train.end)
      valid.start <- as.Date(valid.start)
      valid.end <- as.Date(valid.end)
    }
    if (verbose) {
      print(paste("start.date: [", start.date, "]",
        "train.end: [", train.end, "]",
        sep = " "
      ))
      print(paste("valid.start: [", valid.start, "]",
        "valid.end: [", valid.end, "]",
        sep = " "
      ))
    }

    #----Train start/end c----
    train.start.c <- c(
      as.numeric(format(start.date, "%Y")),
      as.numeric(format(start.date, "%m"))
    )
    train.end.c <- c(
      as.numeric(format(train.end, "%Y")),
      as.numeric(format(train.end, "%m"))
    )
    if (verbose) {
      print(paste("1. train.start.c: [", train.start.c, "]",
        "train.end.c: [", train.end.c, "]",
        sep = " "
      ))
    }

    #----Valid start/end c----
    valid.start.c <- c(
      as.numeric(format(valid.start, "%Y")),
      as.numeric(format(valid.start, "%m"))
    )
    valid.end.c <- c(
      as.numeric(format(valid.end, "%Y")),
      as.numeric(format(valid.end, "%m"))
    )
    if (verbose) {
      print(paste("2. valid.start.c: [", valid.start.c, "]",
        "valid.end.c: [", valid.end.c, "]",
        sep = " "
      ))
    }

    #----train.cols valid.cols----
    full.cols <- paste("", 1:series.length, sep = "")
    train.cols <- paste("", 1:(series.train.size), sep = "")
    valid.cols <- paste("",
      (series.train.size + 1):series.length,
      sep = ""
    )
    if (verbose.TS) {
      print("----full.cols----")
      print(full.cols)
      print("----train.cols---")
      print(train.cols)
      print("----valid.cols---")
      print(valid.cols)
    }

    #---- series.full ----
    series.full.data <- M3.data.xls[ i, full.cols ]
    series.full.stack <- stack(as.data.frame(t(series.full.data)))
    series.full.ts <- ts(series.full.stack$values,
      start = train.start.c,
      frequency = data.freq
    )
    if (verbose) {
      print("---Full Series selected....")
    }

    #---- Train data TS ----
    train.data <- M3.data.xls[ i, train.cols ]
    train.stack <- stack(as.data.frame(t(train.data)))
    train.ts <- ts(train.stack$values,
      start = train.start.c,
      frequency = data.freq
    )
    if (verbose) {
      print("%%%Train data selected....")
    }

    #---- Validation data TS ---
    valid.data <- M3.data.xls[ i, valid.cols ]
    valid.stack <- stack(as.data.frame(t(valid.data)))
    valid.ts <- ts(valid.stack$values,
      start = valid.start.c,
      frequency = data.freq
    )
    if (verbose) {
      print("!!!Valid data selected....")
    }
    if (verbose.TS) {
      print("----train.ts----")
      print(train.ts)
      print("----valid.ts----")
      print(valid.ts)
    }

    #---- Mdata Element ----
    m3.data.element <- list(
      sn = series.name,
      n = series.length,
      h = series.NF,
      period = s.period,
      type = series.category,
      series = series.full.ts,
      x = train.ts,
      xx = valid.ts,
      t.start = train.start.c,
      t.end = train.end.c,
      v.start = valid.start.c,
      v.end = valid.end.c
    )
    if (verbose.TS) {
      print("----m3.data.element----")
      print(m3.data.element)
    }

    #---- MCompReduced ----
    m3.comp.reduced[[series.name]] <- m3.data.element
    if (verbose) {
      print("->saved series element, onto next...")
    }
  } # for

  if (verbose) {
    print("***All data laoded***")
  }
  return(m3.comp.reduced)
}

#' loads all Excel sheets into a list
#' @author Shadi Samir
#' @param data.file xLS connection
#' @param M3.sheets name of sheets in c(,...)
#' @param verbose verbose
loadData <- function(data.file,
                     M3.Sheets,
                     series.types,
                     verbose = FALSE,
                     verbose.TS = FALSE) {
  m3.comp.reduced <- list()
  i <- 1

  #----Load Excel----
  for (sht in M3.Sheets) {
    if (verbose) {
      print(paste("processing [", sht, "]....", sep = " "))
    }

    M3.data.sht <- readxl::read_excel(data.file, sheet = sht)
    # TODO: Append rather than override, but for now keep the hack
    m3.comp.reduced <- parseMData(
      M3.data.xls = M3.data.sht,
      seriesType = series.types[i],
      verbose = verbose,
      verbose.TS = verbose.TS
    )
    i <- i + 1
  }

  return(m3.comp.reduced)
}

#-----------FINITO LA MUSICA--------------------
