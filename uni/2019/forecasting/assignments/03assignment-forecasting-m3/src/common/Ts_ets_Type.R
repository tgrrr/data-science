
#TODO
isTsTrend <- function(ts) {
  return(T)
}

#TODO
isTsError <- function(ts) {
  return(T)
}

isTsSeasonal <- function(x)
{
  m = frequency(x)
  n = length(x)
  
  seasonal = T # assume it is
  if (m <= 1 || n <= m) {
    seasonal = FALSE
  }
  
  return( seasonal )
}

#' Determines if ts has error, trend, Seasonality.
#' "N" donates none,
#' 
#'@return ETS type for series \cls{ts}
getTsType <- function (ts,
                       verbose = FALSE) {
  seasonalType = ifelse(isTsSeasonal(ts), "A", "N")
  trendType = ifelse(isTsTrend(ts), "A", "N")
  errorType = ifelse(isTsError(ts), "A", "N")

  return.list = list(error = errorType,
                     trend = trendType,
                     seasonal = seasonalType)
  if (verbose) {
    print(return.list)
  }

  return(return.list)
}

#----------------------- con los terroristas -------------------------
