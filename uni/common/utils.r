library('here')

# Load all functions in all files in utils directory:

# getwd()
# here::here('uni/common', 'utils.r')

sourceDir <- function(
  path,
  pattern = "\\.[rR]$",
  env = NULL,
  chdir = TRUE)
{
  files <- sort(dir(path, pattern, full.names = TRUE))
  lapply(files, source, chdir = chdir)
}

# FIXME:
# source(here::here('subdirectory', 'functions.R'))

sourceDir('./data/')
# sourceDir('./features/') # nothing in here for now
# sourceDir('./models/') # nothing in here for now
sourceDir('./preprocessing/')
sourceDir('./visualization/')

# TODO: check if it loads these:
# /Users/phil/code/data-science/uni/common/MATH1307_utilityFunctions.R
# source('utils-timeseries.R')
# source('./MATH1307_utilityFunctions.R')
# source('./data/convertToTimeSeries.R')
#
# source('./preprocessing/diffTs.R')
# source('./visualization/diffAndPlot.R')
# source('./visualization/tsPlots.R')
  # includes: residual.analysis, sort.score

# credit where credit's due: https://stackoverflow.com/a/12234004/3281978
