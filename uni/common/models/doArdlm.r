

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Find Best ardlm Models

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

findBestArdlm <- function(
    x = data.weather.precipitation.ts,
    y = data.weather.solar.ts,
    orderLimit=10
    ) {
    models <- list()
    i = 1
    cat('| accuracy | p | q | bg.p.value | vif > 10 \n')

    for(p_ in 1:orderLimit) {
        for(q_ in 1:orderLimit) {
            # model <- dlm(
            #     x = as.vector(x),
            #     y = as.vector(y),
            #     q = q_)

            model = ardlDlm(
              x = as.vector(x),
              y = as.vector(y),
              p = p_,
              q = q_
              )$model

            accuracy <- tryCatch(
                {
                    accuracy(model)[6]
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
                    VIF.model.ardlm = vif(model) # variance inflation factors

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

            if(vif == 'all vif < 10' && bg.p.value > 0.05) {
                cat(green('| ', accuracy, '| ',  p_, '| ', q_, '| ', bg.p.value,'|', vifSummary, '| ',  '\n'))
            } else {
                cat('| ', accuracy, '| ',  p_, '| ', q_, '| ', bg.p.value,'|', vifSummary, '| ',  '\n')
            }
        }
    }
}
