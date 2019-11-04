# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Make plots black and white
# Change plot layout

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#' Title
#'
#' @param mfrow
#' @param mai
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
doPar <- function(
            mfrow = c(1,1),
            mai = c(1,0.5,0.5,0.5),
            ...
            ) {

  if (hasArg(blackWhite) || defaultBlackWhite == TRUE) {
    # Note: if blackWhite is specified in params at all, this will return TRUE
    par(
      bg = 'black',
      col = "white",
      col.axis = 	'white',
      col.lab = "white",
      col.main = 'white',
      col.sub = 'white',
      fg = 'white',
      mai = mai,
      mfrow = mfrow
    )
  } else {
    par(
      mai = mai,
      mfrow = mfrow
    )
  }
}
