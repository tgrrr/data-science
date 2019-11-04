# NICE: update to use layout rather than par
# nf <- layout(matrix(c(1,2,3),ncol=1), widths=c(4,4,4), heights=c(2,1,1), TRUE)
# https://stackoverflow.com/questions/30156443/r-setting-multiple-plot-heights-with-par
# https://bookdown.org/ndphillips/YaRrr/arranging-plots-with-parmfrow-and-layout.html
#' Title
#'
#' @param rows
#' @param cols
#' @param fontSize
#' @param blackWhite
#' @param mfrow
#' @param mai
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
plotLayout <- function(
            rows = 2,
            cols = 1,
            fontSize = 1,
            blackWhite = TRUE,
            mfrow = c(2,1),
            mai = c(1,0.5,0.5,0.5),
            ...
            ) {

  # TODO: par(cex = 0.5)

  if (hasArg(rows) && hasArg(cols)) {
    par(
      mai = mai,
      mfrow = c(rows, cols)
    )
    par(cex = 0.5)

  }
  # if (hasArg(blackWhite) || defaultBlackWhite == TRUE) {
  #   # Note: if blackWhite is specified in params at all, this will return TRUE
  #   if (blackWhite == TRUE) {
  #     par(
  #       bg = 'black',
  #       col = "white",
  #       col.axis = 	'white',
  #       col.lab = "white",
  #       col.main = 'white',
  #       col.sub = 'white',
  #       fg = 'white',
  #       mai = mai,
  #       mfrow = mfrow
  #     )
  #   }
  # } else {
  #   par(
  #     mai = mai,
  #     mfrow = mfrow
  #   )
  # }
}
