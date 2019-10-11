#' Saves M3 reduced XLS to RDA

#----Fresh----
rm(list = ls())

# source('config.r')
# setwd(PATH)
source("src/data/loader.R")

#---- source ----


loadM3Reduced <- function(verbose = FALSE) {
  #---Init Paths----
  # FIXME: path
  data.root.Path <- "~/code/03assignment-forecasting-m3/data/raw"
  data.file <- paste(data.root.Path, "M3C_reduced_2019.xlsx", sep = "/")
  M3.Sheets <- c("M3Year", "M3Month", "M3Quart")
  series.types <- c("Y", "M", "Q")

  #----Init lists----
  m3.comp.reduced.quarterly <- list()
  m3.comp.reduced.yearly <- list()
  m3.comp.reduced.monthly <- list()

  #----Load Excel----
  print("3.Loading Qrt...")
  m3.comp.reduced.quarterly <- loadData(data.file, M3.Sheets[3], series.types[3],
    verbose = verbose, verbose.TS = FALSE
  )
  print("1.Loading Yearly...")
  m3.comp.reduced.yearly <- loadData(data.file, M3.Sheets[1], series.types[1],
    verbose = verbose, verbose.TS = FALSE
  )
  print("2.Loading Monthly...")
  m3.comp.reduced.monthly <- loadData(data.file, M3.Sheets[2], series.types[2],
    verbose = verbose, verbose.TS = FALSE
  )

  #----save to RDA----
  rda.file <- "rda/m3_reduced.rda"
  print(paste("Saving to RBA file [", rda.file, "]...", sep = " "))
  save(m3.comp.reduced.yearly,
    m3.comp.reduced.monthly,
    m3.comp.reduced.quarterly,
    file = rda.file
  )
}

# loadM3Reduced()

#-----------FINITO LA MUSICA--------------------
