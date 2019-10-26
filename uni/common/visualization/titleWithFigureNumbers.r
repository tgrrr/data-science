titleWithFigureNumbers <- function (
  title,
  isUnique = TRUE
) {

  # Captioner::fig_nums requires a unique plot name to incriment the figure num
  uniquePlotTitle <- if(isUnique) {
      paste(c(title, runif(1)), collapse = "")
    } else {
      title
    }

  out <- fig_nums(
    uniquePlotTitle,
    paste('', title, sep = '')
  )

  return(out)
}
