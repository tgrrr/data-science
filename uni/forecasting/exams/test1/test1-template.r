# ---
# title: 'Forecasting Test 1 - Phil Steinke'
# output: html_notebook
# ---

### Setup

# -----------------------------
##### Config Options
data_filename <- 'ASX_data.csv'
working_directory <- '/Users/phil/code/data-science/datasets/forecasting'
setwd(working_directory)

# devtools::install_git('https://gitlab.com/botbotdotdotcom/packagr')
library(packagr)
packages <- c(
  'dLagM', 'forecast', 'expsmooth', 'TSA', 'Hmisc', 'car', 'AER', 'readr', 'tseries', 'lubridate', 'stringr', 'testthis', 'captioner', 'urca', 'xts', 'dynlm')
packagr(packages) # alpha package to check, install and load packages

source('/Users/phil/code/data-science/uni/common/utils-forecasting.R')
# -------------------------------

##### Config:
# -----------------------------

# data %>% head(1) # Initial date: Jan-04 (from original date column)
tsStart = c(1993,1) # TODO
# data %>% tail(1) # Final date: May-17 (from original date column)
tsEnd = c(2017, 5)  # TODO
default_ylab = '' # TODO
default_xlab = default_xlab
# TODO featuresData <- list('ASXprice.ts', 'Goldprice.ts', 'CrudeOilBrentUSDbbl.ts', 'CopperUSDtonne.ts')

featuresData <- list('SeaLevel')
# -------------------------------


### wk1 

# solution1 Ex3

# Load file:
# -----------------------------
data <- read_csv(
  '~/code/data-science/datasets/forecasting/seaLevel.csv',
  col_names = TRUE
)

data %>% head(12)
data %>% dim()


# -------------------------------



# Convert to ts:

data.ts <- convertToTimeseries(
  data$SeaLevel, 
  colName = 2,
  # colName = SeaLevel, # TODO:
  frequency = 12,
  tsStart
)

data.ts

TODO: @beforetest add months input
data.ts

# plot
# -------------------------------

plotLayout(rows=2, cols=1)
colourGraphs <- c('blue', 'red', 'green', 'orange')
data.scaled <- scale(data.ts)

plot(data.ts, plot.type='s',col = colourGraphs, main = 'TODO')
legend('topleft', lty=1, col=colourGraphs, legend = featuresData)

# Scale and centre each series
plot(data.scaled, plot.type='s', col = colourGraphs, main = 'TODO scaled')
legend('topleft', lty=1, col= colourGraphs, legend = featuresData)

  # TODO: points
  # TODO: draw inferences about the mechanism behind the series.
  # TODO: Seasonality
  # TODO: trend and 
  # TODO: changing variance
  # TODO: Intonation point

# @beforetest
# TODO: fig_nums('log_transform', 'Log transform')
apply(data.ts, 2, doPlot)

# acf
# pacf
# <!-- Phillips-Perron Unit Root Test -->
# - [ ] ur.df %>% summary
# - [ ] ur.pp %>% summary

## Check correlation of each of the features
```{r}
cor(data.ts)
```
# - High positive correlation between `TODO` and `TODO` of `0.87`
# - Partial positive correlation between:
#   - `TODO` and `TODO` of `TODO`
#   - `TODO` and `TODO` of `TODO`
# - Therefore: features are TODO: not independent
# - `TODO` correlates with most other variables, so we can form a model that's primarily based on TODO

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
# + solution2

### Transforms

# TODO: If BoxCox:
# Transform with BoxCox.ar()
data.boxcox.ts <- convertToBoxCox(data.ts)

# if log()
log.data.ts = log(data.ts + abs(min(data.ts))+1)

@beforetest
plot(
  data.ts, 
  type = 'l', 
  xlim = c(1995,1998)
)
points(y=data.ts,x=time(data.ts), pch=as.vector(season(data.ts)))

# DIFFERENCING
# - with seasonality / without

# Check if there is existing seasonality:

plotLayout(rows=1, cols=2)

# additive seasonality:
data.additive.ts <- decompose(data.ts, type='additive')
plot(
  data.additive.ts,
  # xlim = c(1995,1998)
  
)

# multiplicative seasonality:
data.multiplicative.ts <- decompose(
  data.ts, 
  type='multiplicative',
)
plot(data.multiplicative.ts$seasonal)

# What's the seasonal period?
findfrequency(data$SeaLevel)
# Check diff with seasonal and without:
### differencing
# diff()
#   plot()
#     points(
#       pch=as.vector(season()))
doDiffAndPlot(data.ts, 0, F, F)

TODO: @beforetest add: monthly()

data.diff1.ts <- doDiffAndPlot(data.ts, 1, T, F, out=TRUE)
ASXprice.diff1.seasonal.ts«» <- doDiffAndPlot(data.ts, 1, T, lag=12, out = TRUE)
# TODO: @beforetest fix titles

### DECOMPOSITION (3 TYPES)

x12()
  plot()

stl()
  plot()

### FORECASTING WITH SEASONAL DECOMPOSITION

seasadj()
  plot(
    naive())

forecast( , h=24)
  plot()

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
# Week3 solution3

### DISTRIBUTED LAG MODELS

warming = ts(globalWarming$Warming,start = 1959)
co2 = ts(globalWarming$CO2,start = 1959)
data.ts = ts(globalWarming[,2:3],start = 1959)

### We can plot them individually
plot(warming)
plot(co2)

plot(data.ts)
  legend()

### We can scale and center both series to see in the same plot clearly
data.scaled = scale(data.ts)
plot(data.scaled)
  legend()

### The correlation between warming and CO2 series is very high
cor(data.ts)


### Fit a finite DLM with a lag length of 4 and do the diagnostic checking.
model1 = dlm( x = as.vector(co2) , y = as.vector(warming), q = 4 )
  summary(model1)
  checkresiduals(model1$model)

### Find the finite lag length based on AIC and BIC for this data
### We can change  q and compare AIC/BIC values
for ( i in 1:10){
  model1.1 = dlm( x = as.vector(co2) , y = as.vector(warming), q = i )
  cat('q = ', i, 'AIC = ', AIC(model1.1$model), 'BIC = ', BIC(model1.1$model),'\n')
}

### TODO: bgtest() vif() geometric lag
### TODO: sort.score()


### AIC
finiteDLMauto(
  x = as.vector(co2),
  y = as.vector(warming),
)

### BIC
finiteDLMauto(
  x = as.vector(co2),
  y = as.vector(warming),
) # In the outpt 'q - k' shows the lag length.

### repeat with q = 1 <- why?
model1.2 = dlm(
  ...
  q = 1)
  summary(model1.2)
  checkresiduals(model1.2$model)

### POLYNOMIAL DISTRIBUTED LAGS

### Fit a polynomial DLM of order 2. 
model2 = polyDlm(
  ...
  q = 2,
  k = 2, 
  show.beta = TRUE)
  summary(model2)
  checkresiduals(model2$model)

### Find forecasts for the CO2 levels 406.31, 407, and 415. Here 406.31 ppm is the latest measurement in May 2017. 
### Plot the forecasts along with the original warming series.
model1.2Frc = dLagM::forecast(
  model1.2, 
  x = c(406.31, 407, 415), 
  h = 3)
model2Frc = dLagM::forecast(
  model2, 
  x = c(406.31, 407, 415), 
  h = 3)

### Dlm
plot(
  ts(
    c(
      as.vector(warming), 
      model1.2Frc$forecasts
    ),
    start = 1959),
  type='o',
  col='Blue',
  ylim=c(-0.3, 1.7),
  ylab = default_ylab, 
  xlab = 'default_xlab'
  main='Global warming series with three years ahead forecasts')

### Polynomial warming and model2Frc forecast
lines(
  ts(
    c(as.vector(warming), model2Frc$forecasts), 
    start = 1959
  ),
  col='red',
  type='o'
)
### just warming
lines(
  ts(
    as.vector(warming), 
    start = 1959
  ),
  col='black',
  type='o')

legend(
  'topleft',
  lty=1,
  pch = 1,
  text.width = 11, 
  col=c('blue', 'red', 'black'), 
  c('Dlm', 'Polynomial', 'Warming')
)

### KOYCK TRANSFORMATION

### Koyck
model3 = koyckDlm(
  x = as.vector(co2),
  y = as.vector(warming)
  )
  summary(model3)
  checkresiduals(model3$model)

### AR DISTRIBUTED LAG

### Fit autoregressive distributed lag models
model4 = ardlDlm(
  x = as.vector(co2),
  y = as.vector(warming), 
  p = 1,
  q = 1 
)
  summary(model4)
  checkresiduals(model4$model)

model4 = ardlDlm(
  formula = Warming ~ CO2, 
  data = globalWarming, 
  p = 1,
  q = 1
)
  summary(model4)
  checkresiduals(model4$model)

for (i in 1:5){
  for(j in 1:5){
    model4.1 = ardlDlm(
      x = as.vector(co2),
      y = as.vector(warming), 
      p = i, 
      q = j)
    cat(
      'p = ', i, 
      'q = ', j, 
      'AIC = ', AIC(model4.1$model), 
      'BIC = ', BIC(model4.1$model),
      '\n')
  }
}
### p =  1 q =  1 gives the smallest AIC and BIC

### FORECASTING

### Find forecasts for the CO2 levels 406.31, 407, and 415. Here 406.31 ppm is the latest measurement in May 2017. 

### Plot the forecasts along with the original warming series.
model3Frc = dLagM::forecast(
  model3,
  x = c(406.31, 407, 415),
  h = 3
)
model4Frc = dLagM::forecast(
  model4,
  x = c(406.31, 407, 415),
  h = 3
)

### Dlm
plot(
  ts(
    c(
      as.vector(warming), 
      model1.2Frc$forecasts
    ),
    start = 1959
  ),
  type='o',
  col='Blue',
  ylim= c(-0.3, 1.7), 
  ylab = default_ylab,
  xlab = default_xlab,
  main='Global warming series with 3 years ahead forecasts'
  )   

### Polynomial   
lines(
  ts(
    c(
      as.vector(warming),
      model2Frc$forecasts),
      start = 1959
    ),
    col='red',
    type='o'
)

### Koyck
lines(
  ts(
    c(
      as.vector(warming),
      model3Frc$forecasts
    ),
    start = 1959
  ),
  col='green',
  type='o'
)

### ARDL
lines(
  ts(
    c(
      as.vector(warming), 
      model4Frc$forecasts
    ), 
    start = 1959
  ),
  col='purple',
  type='o'
)

### Warming
lines(
  ts(
    as.vector(warming),
    start = 1959),
    col='black',
    type='o')

legend(
  'topleft',
  lty = 1,
  pch = 1,
  text.width = 11,
  col = c('blue', 'red', 'green', 'purple', 'black'), c('Dlm', 'Polynomial', 'Koyck', 'ARDL', 'Warming')
)


<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

# Solution4
# TODO: @beforetest



# Solution5
# TODO: @beforetest

min(data.ts)

fit2.holt <- holt(data.ts, initial="simple", h=5) # Let the software estimate both alpha and beta
summary(fit2.holt)
checkresiduals(fit2.holt)

constant = 50
fit3.sea = hw(
  min(data.ts + constant),
  seasonal = 'multiplicative',
  h=5*frequency(data.ts))
  
summary(fit3.sea) 
checkresiduals(fit3.sea)


fit1.sea = hw(data.ts,
  seasonal="additive", 
  h=5*frequency(data.ts)
)
summary(fit1.sea) 
checkresiduals(fit1.sea)

fit2.sea = hw(data.ts,seasonal="additive", damped = TRUE, h=5*frequency(data.ts))
summary(fit2.sea) # Best fit, best time series plot for residuals
checkresiduals(fit2.sea)

source('/Users/phil/code/data-science/uni/common/utils-forecasting.R')

fit2.sea = hw(data.ts,seasonal="additive", damped = TRUE, h=5*frequency(data.ts))
summary(fit2.sea) # Best fit, best time series plot for residuals
checkresiduals(fit2.sea)


doFitHw(
  data.ts,
  seasonalType= "multiplicative"
  # ,
  # constant = 50
)

