DEATHLIST5!

### Goals

- [ ] fix eacf

- [x] Analyse the egg depositions of Lake Huron Bloasters 
- [x] Use the analysis methods covered in the **modules 1 – 7** of MATH1318 Time Series Analysis
- [ ] Choose the best model among a set of possible models for this dataset
  - [ ] How did I get that model?
- [-] Give forecasts of egg depositions for the next 5 years
- [ ] plot labels
- [ ] no lags = white noise

- [ ] do I even use the boxCox transform throughout?. See line 105

- [ ] Reporting
  - [ ] Rubrik
  - [ ] Assignment1
  - [ ] mid-sem
  - [ ] ash's work
  - [ ] 
- [ ] Ass2 todos
- [ ] scan this for todos
@@@@@@@@@@@@@@@@@


### Hypothesis for Quadratic

H0:μΔ=0
HA:μΔ≠0


# RUBRIK

- [ ] ## Reporting 15%
 
- [ ] All inferences are clearly addressed by relevant outputs and given under relevant sections. 
- [ ] All bits of the presented output are used for the inferences. 
- [ ] There are no minor language and formatting issues.
 
- [ ] ## R Codes 15%
 
- [ ] Scripts to run analyses are working properly and suitable explanations are given. 
- [ ] Also, the scripts include functions to implement all analyses in a dynamical way.
 
- [ ] ## Descriptive analysis 20%
 
- [ ] Uses all suitable plots and descriptive statistics and every plot and descriptive statistic is interpreted in a way to shed a light on further analyses.
- [ ] All suitable tools are correctly used for proper specification of a set of possible models
 
- [ ] ## Model accuracy 25%
- [ ] Several possible parameter estimation methods are applied
- [ ] All of the related outputs are properly used:
  - [ ] to draw inferences about validity of the considered models
  - [ ] the best estimation method is properly identified

- [ ] ## Diagnostic checking 25%

- [ ] All aspects of diagnostic checking were applied 
- [ ] all assumptions of applied approaches were validated
  - [ ] by observing relationships between the diagnostic tools (plots/tests)
- [ ] Required forecasts are given and plotted in an informative way




@@@@@@@@@@@@@@@@@


Didn't use:
# 'CADFtest','smooth','beepr','RColorBrewer','CADFtest'

~old_todo~

intonation point

correlation 



change plots titles
- [x] p values in class notes
- [x] eacf: compare wk5 gold with this
- [ ] plots side-by-side
- [ ] should I have diffed the boxcox?
- [ ] Return object of outputs from function

- ~old_todo~ For MA(1) 
- ~old_todo~ For AR(1) 

lags of 1 and 4 might be significant


- [x] add type to adfTest (nc, c, ct)

- see: https://www.one-tab.com/page/ArtMluDpSnSmRtMUervoVw
(includes lectures for this.)

~old_todo~ check that we've proven there's a trend before here: Because a trend exists, We'll check the `BoxCox.ar`


~old_todo~ maths for  ADF test Δyt=α+βt+γyt−1+δ1Δyt−1+⋯+δp−1Δyt−p+1+εt

> # Slowly decaying pattern in ACF and very high first correlation in PACF
> # implies the existence of trend and nonstationarity.
`par(mfrow=c(1,1))`

"adf.test(gold)
With a p-value of 0.6665, we cannot reject the null hypothesis stating that
the series is non-stationary." - from 05-tasks

~old_todo~ ```{r} qqnorm(BC.gold)
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

_______________________________


# later:
- [ ] move opening code to my github repo, then import it

CADFtest() in CADFtest.

function for `adfTests`


~old_todo~ showing different adfTest possibilities
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

~old_todo~ Working on understanding ar tests, late thurs night

<!-- ~old_todo~ remove?  -->
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
<!-- ~old_todo~ update -->
```{r fig.height=4, fig.width=8}
t = time(data.ts.ts) # Create time points for model fitting

default_ylab = '' # ~old_todo~
default_subtitle = '' # ~old_todo~
default_xlab = '' # ~old_todo~

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


# ~old_later~
? put into single saply function diff 1, 2, 3...?
```{r}
diffCounts <- list(1,2,3)
sapply(diffCounts, df=data.ts, doDiffAndPlot)
```


Didn't use this reverse transform

```{r}
# ~old_todo~ remove?
# We applied log transformation and second difference. To take them back:
log.data.ts = log(data.ts.raw)
log.data.ts.diff2.back = diffinv(diff.data.ts, differences = 2, xi = data.ts.matrix(log.data.ts[1:2]))
log.data.ts.diff2.back = exp(log.data.ts.diff2.back)
```


trying to automate the entire time-series process:

  # if (p < 0.05 ) {
  #   # arimaValues[nrow(arimaValues) + 1,] <- 'foo'
  #   print('p-value < 0.05 significant')
  # } else {
  #   print('p-value > 0.05 insignificant')
  #   arimaValues[nrow(arimaValues) + 1,] <- diffCount
  # }

