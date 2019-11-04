

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Find Best dlModels

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


#' Title
#'
#' @param df
#' @param orderTotal
#'
#' @return
#' @export
#'
#' @examples

findBestDlm <- function(
    x = data.weather.precipitation.ts,
    y = data.weather.solar.ts,
    orderRange=c(1:10)
    ) {
    models <- list()
    i = 1
    cat('| q | accuracy | bg.p.value | vif > 10 | \n')

    for(q_ in orderRange[1]:tail(orderRange, n=1)) {
        model <- dlm(
            x = as.vector(x),
            y = as.vector(y),
            q = q_)

        accuracy <- tryCatch(
            {
                accuracy(model$model)[6]
            },
            error=function(cond) {
                message("Accuracy error message:")
                message(cond)
                return(NA)
            },
            warning=function(cond) {
                message("Accuracy warning message:")
                message(cond)
                return(NULL)
            }
        )
        bg.p.value <- tryCatch(
            {
                bgtest(model$model)$p.value
            },
            error=function(cond) {
                message("BG error message:")
                message(cond)
                return(NA)
            },
            warning=function(cond) {
                message("BG warning message:")
                message(cond)
                return(NULL)
            }
        )

        vif <- tryCatch(
            {
                VIF.model.ardlm = vif(model$model) # variance inflation factors

                # TODO: refactor
                if (length(VIF.model.ardlm)==0) {
                    vifSummary <- 'no vif found'
                } else if (VIF.model.ardlm && all(VIF.model.ardlm > 10)) {
                    vifSummary <- 'all vif > 10, violates general assumptions'
                } else if (VIF.model.ardlm && all(VIF.model.ardlm < 10)) {
                    vifSummary <- 'all vif < 10'
                } else if (VIF.model.ardlm && VIF.model.ardlm < 10) {
                    vifSummary <- 'some vif > 10'
                } else {
                    vifSummary <- paste0('none of the above', toString(VIF.model.ardlm > 10))
                }

                vifSummary
            },
            error=function(cond) {
                message("BG error message:")
                message(cond)
                return(NA)
            },
            warning=function(cond) {
                message("BG warning message:")
                message(cond)
                return(NULL)
            }
        )

        cat(q_, accuracy,bg.p.value,vif,'\n')
    }
}
