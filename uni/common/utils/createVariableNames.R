
# assign(paste0("perf.a", "1"), 5)

# assign(bar, value = paste0(colName, ".ts"), envir = .GlobalEnv)

#' Title
#'
#' @param df
#' @param colName
#' @param append
#' @param ...rest
#'
#' @return
#' @export
#'
#' @examples
createVariableNames <- function(
  df,
  colName,
  append='.ts',
  ...rest
) {
  assign(paste0(colName, append), df, envir = .GlobalEnv);
};

# How it works:
# createVariableNames('foo', 'bar', append=NULL);

# Note, for opposite, see:
# https://stackoverflow.com/questions/18508790/deparsesubstitutex-in-lapply?lq=1
