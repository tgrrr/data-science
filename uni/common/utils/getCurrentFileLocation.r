library('tidyverse')

#' Title
#'
#' @return
#' @export
#'
#' @examples
getCurrentFileLocation <- function(
  # TODO: subDirectory = NULL
  )
{
  out <- tryCatch(
    {
      current_dir <-
        commandArgs() %>%
        tibble::enframe(name = NULL) %>%
        tidyr::separate(
          col=value,
          into=c("key", "value"),
          sep="=",
          fill='right') %>%
        dplyr::filter(key == "--file") %>%
        dplyr::pull(value)

      if (length(current_dir)==0 && rstudioapi::isAvailable())
      {
        cat('path was pulled from rStudio\n')
        current_dir <- rstudioapi::getSourceEditorContext()$path
      } else {
        cat('path was pulled from normalalizePath\n')
        current_dir <- normalizePath('.')
      }

      # return(dirname(current_dir))
      return(current_dir)

      message(paste("Directory found: ", current_dir))
    },
    error=function(cond)
    {
      message(paste("Error: Oops, couldn't load the directory - ", current_dir))
      message("Here's the original error message:")
      message(cond)
      # Choose a return value in case of error
      return(NA)
    },
    warning=function(cond)
    {
      message(paste("Warning: on directory - ", current_dir))
      message("Here's the original warning message:")
      message(cond)
      # Choose a return value in case of warning
      return(NULL)
    },
    finally={
      message(paste("This file's directory: ", current_dir))
    }
  )

  return(out)
}

# getCurrentFileLocation()
