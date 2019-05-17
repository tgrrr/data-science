TODO:

intonation point

correlation 



change plots titles
- [x] p values in class notes
- [x] eacf: compare wk5 gold with this
- [ ] plots side-by-side
- [ ] should I have diffed the boxcox?
- [ ] Return object of outputs from function

- TODO: For MA(1) 
- TODO: For AR(1) 

lags of 1 and 4 might be significant


- [x] add type to adfTest (nc, c, ct)

- see: https://www.one-tab.com/page/ArtMluDpSnSmRtMUervoVw
(includes lectures for this.)

TODO: check that we've proven there's a trend before here: Because a trend exists, We'll check the `BoxCox.ar`


TODO: maths for  ADF test Δyt=α+βt+γyt−1+δ1Δyt−1+⋯+δp−1Δyt−p+1+εt

> # Slowly decaying pattern in ACF and very high first correlation in PACF
> # implies the existence of trend and nonstationarity.
`par(mfrow=c(1,1))`

"adf.test(gold)
With a p-value of 0.6665, we cannot reject the null hypothesis stating that
the series is non-stationary." - from 05-tasks

TODO: ```{r} qqnorm(BC.gold)
qqline(BC.gold, col = 2)
shapiro.test(BC.gold)
```

- why are we looking at the data so early?
- 
- [ ] Check lectures 6 and 7
- [ ] copy headings in amongst code from line #126
- [ ] Check I didn't screw up data.ts copy paste anywhere
- [ ] todos scattered in assignment
- [ ] global-variables

later:
- [ ] move opening code to my github repo, then import it

CADFtest() in CADFtest.

function for `adfTests`


TODO: showing different adfTest possibilities
<!-- ))))))))))))))) -->

adf drift, intercepts, and...
do you care about plots of non-modelled?
```{r}
# look for intercept vs. no intercept and trending vs not trending:
adfTest(data.ts, lags = 0, type = "nc", title = NULL,description = NULL)
# Look for trend:
adfTest(data.ts, lags = 3, type = "c", title = NULL,description = NULL)
#  detrend and handle an occurring intercept:
adfTest(data.ts, lags = 3, type = "ct", title = NULL,description = NULL)
# this perfectly detrends the dataset, and ignores the intercept
# and compares our model to this to get a p-value

diffAdfTest = adfTest(df, lags = order, title = NULL, description = NULL)  

  (nc, c, ct)
CADFtest(df.ts, # max.lag.y = order, type = c('drift', 'trend', 'none'), criterion = "BIC")


# NOTE: adfTest$p.value does not work as per the documentation. Because it's an class s4 object, it's also not easy to get just the single value
# reference: http://fabian-kostadinov.github.io/2015/01/27/comparing-adf-test-functions-in-r/
```

model no Intercept
model fitting shows Intercept
intercept in model 
cross y axis

TODO: Working on understanding ar tests, late thurs night

<!-- TODO: remove?  -->
```{r}
ar(data.ts)
```


```{r}
ar(data.ts)

ar(diff(data.ts, 1))

ar(diff(data.ts, 2))

ar(diff(data.ts, 3))

ar(diff(data.ts, 4))

ar(diff(log.data.ts, 3))
```


<!-- )))))))))))) -->


### Specify a set of tentative ARIMA models including at least three models by using

### ACF and PACF plots

### EACF plot

<!-- ### BIC table -->

### Estimate the model parameters for each model in the set of tentative models

### Conduct a residual analysis for diagnostic checking for each model

### Select the best model based on the results of residual analysis and AIC and BIC

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

## R codes

## Descriptive Analysis

## Modelling

## Parameter Estimation

## Diagnostic Checking



## Conclusion

**Task:**



- [ ] 



#### Initial Plot Declare
<!-- TODO: update -->
```{r fig.height=4, fig.width=8}
t = time(data.ts.ts) # Create time points for model fitting

default_ylab = '' # TODO:
default_subtitle = '' # TODO:
default_xlab = '' # TODO:

doTimeSeriesPlot <- function(
  x, 
  xlab = default_xlab,
  y,
  ylab = default_ylab,
  lines,
  type = 'o', 
  title = '',
  subtitle = default_subtitle
  ) {
  par(bg = colourPallete[5]) # plot background
  plot( 
    x,
    y,
    col = colourPallete[9],
    pch = 19,
    type = type,
    xlab = xlab,
    ylab = default_ylab)
  title(
    main = title,
    sub = subtitle,
    col.main = colourPallete[9],
    font.main = 3)
  points(x)
  if(!missing(lines)) { lines }
}
```


# LATER
? put into single saply function diff 1, 2, 3...?
```{r}
diffCounts <- list(1,2,3)
sapply(diffCounts, df=data.ts, doDiffAndPlot)
```