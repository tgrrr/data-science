
# assign(paste0("perf.a", "1"), 5)

# assign(bar, value = paste0(colName, ".ts"), envir = .GlobalEnv)

<<<<<<< HEAD
=======
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
>>>>>>> feature/common
createVariableNames <- function(
  df, 
  colName, 
  append='.ts',
  ...rest
) {
  assign(paste0(colName, append), df, envir = .GlobalEnv);
};

# How it works:
createVariableNames('foo', 'bar', append=NULL);