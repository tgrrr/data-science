<CodeSurfer
  title="Linear Model"
  code={assignment03}
  steps={[
    { notes: "Use ⬆️ and ⬇️ keys" },
    { range: [ 180, 181 ], notes: "Range" },
    { range: [ 183, 186 ], notes: "Findings" },
    { lines: [181, 187, 188, 189], notes: "... or multiple lines ➡️" },
    { range: [ 192, 197 ], notes: "Findings" },
    { lines: [199], notes: "Highlight a single line ⬇️" },
    { range: [ 204, 213 ], notes: "Residual results" }
  ]}
/>



- [ ] captions 
`fig_nums(
  'initial ts data', 
  'initial time-series data with no transformation') %>% cat()`

Your task is to:

- [ ] analyse the data by using the analysis methods covered in MATH1318 
Time Series Analysis course in this semester
- [ ] accurately predict the value of bitcoin for the next 10 days, 
- [ ] and prepare a comprehensive analysis report including 
  - [ ] descriptive analysis 
  - [ ] proper visualisation 
  - [ ] model specification 
  - [ ] model fitting and selection 
  - [ ] and diagnostic checking
- [ ] You will include a mean absolute scaled error (MASE), 
for each of model fits and forecasts. 
- [ ] You’ll use the real values of daily bitcoin for 10 days of the forecast 
period (_25th of February_ - _6th of March 2019_) to compute `MASE` for 
forecasts using the R function here.
- [ ] present your results in a written report format and as an oral 
presentation.
- [ ] QQ plot

- [ ] TODO: MASE for linear model (copied from inline)




120
220
320

https://stats.stackexchange.com/questions/84076/negative-values-for-aic-in-general-mixed-model

#### Maybe
util
  options(warn=-1)
  options(warn=0)
  invisible(x)

  ```{r}
  # @ash forecast code I pinched from the overview module:

  # ARIMA
  future = forecast(m6.jobs_2, h = 24)
  par(mfrow=c(1,1))
  plot(future)

  # Garch
  forc = ugarchforecast(m.11, data = return, n.ahead = 10, n.roll =10)
  plot(forc, which ="all")

  # from module 9:
  fGarch::predict(m.11_2,n.ahead=100,trace=FALSE,plot=TRUE)

  ```



## Residuals: `BIC` Table

```{r warning=FALSE}
fig_nums('Residual BIC Table', 'Residual BIC table') %>% cat()
par(mfrow=c(1,1))
armasubsets(y=data.ts,nar=3,nma=3,y.name='test',ar.method='ols') %>% plot()
```

From the `BIC` residual plot, we can also extract the models:
`{arima(1,4,2)}, {arima(1,4,1)}, {arima(0,4,2)}, {arima(0,4,1)}` 
Note: arima(0,4,1) is duplicated in eacf plot

The final set of possible models `{arima(p,d,q)}` is:
`{arima(1,4,1), arima(0,4,1), arima(1,4,0), arima(1,4,2)}, {arima(0,4,2)}, {arima(2,4,0)}`



residuals before ugarchfit
residuals after garch
compare residuals from both

Notes to move:

- appears to be volatility clustering in plot

The sample EACF also confirms existence of little serial correlation by suggesting a white noise series.The average CREF return equals 0.0493 with a standard error of 0.02885. Thus the mean of the return process is not statistically significantly different from zero. this is in accordance with the the efficient-market hypothesis.


+++++++++++++++++++++++++++++

---
### Check Seaonsality WIP

Visual inspection of the plot's second half shows some possible seasonality
```{r seasonality-visual-check}

plot(data.ts)
zoomplot.zoom(
  # fact=2,
  xlim=c(2018, 2019)
  # y=0
)

```
TODO: Looks like there might be some seasonality

```{r seasonality-basic}


```

```{r}
check_seasonality_decompose <- function(df.ts) {

  time.series <- df.ts
  decomposed  <- stl(time.series, s.window="periodic")
  seasonal    <- decomposed$time.series[,1]
  trend	      <- decomposed$time.series[,2]
  remainder   <- decomposed$time.series[,3]

  # plot(decomposed)
  # Works, just switched off for plotting:
  plot(
    seasonal,
    main="seasonality",
    ylab="value",
    xlim=c(2017, 2019),
    ylim=c(-1000, 2000)
  )

  # FIXME:
  # plot(
  #   trend+remainder,
  #   main="seasonality",
  #   ylab="value",
  #   # xlim=c(2014, 2019),
  #   # ylim=c(-1000, 12000)
  # )
}

check_seasonality_decompose(data.ts__log)

# FIXME: doDiffAndPlot(trend.ts, 0)
```
- We can observe yearly seasonality in January from the plot

```{r}
# TODO: checkme
plot(
  # seasonal,
  trend+remainder,
  main="seasonality",
  ylab="value",
  # xlim=c(2014, 2019),
  # ylim=c(-1000, 12000)
)
```
```{r}
par(mfrow = c(2,2))
plot(data.ts,xlab='Time',ylab='diff=0',main= "Time Series Plot of bitcoin")
# first diff
plot(diff(data.ts),xlab='Time',ylab='First diff',main= "Time Series Plot of First diff")
plot(diff(data.ts,lag=12),xlab='Time',ylab='First diff',main= "Time Series Plot of First diff lag=12")
plot(
  diff(diff(data.ts),lag=365),
  xlab='Time',
  ylab='First and Seasonal Difference',
  main= "Time Series Plot of First and Seasonal Differences lag=365"
)

```

```{r}
par(mfrow = c(2,2))

plot(data.ts__log,xlab='Time',ylab='diff=0',main= "Time Series Plot of bitcoin")
# first diff
plot(diff(data.ts__log),xlab='Time',ylab='First diff',main= "Time Series Plot of First diff lag=0")
plot(diff(data.ts__log,lag=1),xlab='Time',ylab='First diff',main= "lag=1")
plot(diff(data.ts__log,lag=12),xlab='Time',ylab='First diff',main= "lag=12")
plot(
  diff(diff(data.ts__log),lag=365,),
  xlab='Time',
  ylab='First and Seasonal Difference',
  main= "lag=365"
)

# <- @PhilHere



data.ts__log_diff1__lag1 <- diff(data.ts__log,lag=1)
data.ts__log_diff1__lag12 <- diff(data.ts__log,lag=12)
data.ts__log_diff1__lag365 <- diff(data.ts__log,lag=365)



data.ts__log_diff2__lag1 <- diff(diff(data.ts__log,lag=1))
data.ts__log_diff2__lag12 <- diff(diff(data.ts__log,lag=12))
data.ts__log_diff2__lag365 <- diff(diff(data.ts__log,lag=365))

doDiffAndPlot(data.ts__log, F, T,  0)

doDiffAndPlot(data.ts__log_diff1, F, T,  0)
doDiffAndPlot(data.ts__log_diff1__lag1, F, T,  0)
doDiffAndPlot(data.ts__log_diff1__lag12, F, T,  0)
doDiffAndPlot(data.ts__log_diff1__lag365, F, T,  0)

doDiffAndPlot(data.ts__log_diff2, F, T,  0)
doDiffAndPlot(data.ts__log_diff2__lag1, F, T,  0)
doDiffAndPlot(data.ts__log_diff2__lag12, F, T,  0)
doDiffAndPlot(data.ts__log_diff2__lag365, F, T,  0)

```

```{r}
months <- seq(as.Date("27/04/2013", format = "%d/%m/%Y"), by = "months", length = 4)
length(seasonal)
plot(
  seasonal,
  months,          
  # trend+remainder,
  main="seasonality",
  ylab="ayyy, bitches",
  xlim=c(2017, 2018),
  ylim=c(-2000, 2000)
)
Month=c('J','F','M','A','M','J','J','A','S','O','N','D')
points(window(seasonal,start=c(2017,1)),pch=Month)

```

```{r seasonality-complex-ggplot}
is_seasonality <- function(
  df.ts = data.ts, # not transformed
  diffCount = 0,
  ...
  ) {
  price <- ts(rev(df.ts), frequency = 7)
  xlim = c(1600,1650)

  # diffCount <- 1
  startDate <- diffCount + 1
  date <- data$Date[startDate:length(data$Date)] # difference removes a record, so we need to remove one from the start of the date

  price.decomposed <- stl(price,"periodic", robust = TRUE) # get seasonal decomposition
  price.seasonal <- price.decomposed$time.series[,"seasonal"]
  price.trend <- price.decomposed$time.series[,"trend"]
  price.residuals <- price.decomposed$time.series[,"remainder"]
  price.expected <- price.seasonal + price.trend
  data.decomposed = data.frame(x=1:length(df.ts), seasonality = price.seasonal, trend=price.trend, residuals=price.residuals, expected=price.expected, time=date)
  # TODO: removed rev() from time

  p1 <- ggplot(
          data = data.decomposed,
          aes(x=x,y=exp(seasonality))
        ) + 
          geom_line() + 
          ylab("Seasonality") + 
          coord_cartesian(xlim = xlim)
  p2 <- ggplot(
    data = data.decomposed, 
    aes(x=x, y=exp(trend))) +
    geom_line(col='darkblue')  + 
    ylab("Trend")
  p3 <- ggplot(data=data.decomposed, aes(x=x, y = residuals)) + geom_line()
  p4 <- ggplot(data=data.decomposed, aes(x=x, y=expected)) + geom_line()
  grid.arrange(
    p1,
    p2,
    p3,
    p4, 
    ncol=1
  )  
}

is_seasonality(data.ts__log)
# is_seasonality(data.ts__log_diff1, 1)
# is_seasonality(data.ts__log_diff2, 2)
```
Differencing doesn't remove seasonality

---

```{r}

# output.df <- data.frame

df.ts <-data.ts__log
# findBestModel <- function(df.ts) {
  datalist = list()

  # output.df <- data.frame('p', 'd', 'q', 'AIC', 'model pvalue', 'shapiroPValue')
  # names(output.df) <-c('p', 'd', 'q', 'AIC', 'model pvalue', 'shapiroPValue')
  # names(output.df)<-c('p', 'd', 'q', 'AIC', 'model pvalue', 'shapiroPValue')

  # output.df
  # output.df <- data.frame(
  #   p = NULL, 
  #   d = NULL, 
  #   q = NULL, 
  #   AIC = NULL, 
  #   pval = NULL, 
  #   shapiroPValue = NULL
  #   )
  # modelList <- list(c(2,1,4), c(2,1,3), c(0,1,3), c(0,1,4),c(0,1,6), c(1,1,6),c(1,1,6), c(1,1,5),c(2,1,6), c(2,1,5))

  output.df <-  as.data.frame(matrix(0, ncol = 6, nrow = 68))
  names(output.df) <- data.frame('p', 'd', 'q', 'AIC', 'pval', 'shapiroPValue')
  i = 0
  # d=1 # TODO: 1 or 2?
  for(d in 1:2){
    for(q in 0:2){
      for(p in 0:7){

        if(p+d+q<=9){
        # generate models:
          model <- 
            Arima(
              y=df.ts, 
              order = c((p),d,(q)),
              method = "CSS-ML",
              include.constant = TRUE
            )
          aic <- model$aic
          # residuals p value:
          # boxTest <- Box.test(model$residuals, lag=log(length(model$residuals)))
          # boxTest$p.value
          # sum of squared error:
          sse <- sum(model$residuals^2)
          shapiroPValue <- shapiro.test(model$residuals)$p.value
          # cat(p,d,q,
          #   'AIC=', aic,
          #   # ' SSE=',sse,
          #   'model p-VALUE=', pval$p.value,
          #   'p-value Shapiro Residuals=', shapiroPValue,
          #   '\n')
          # modelList <- list(1,2,3,4,5,6)
          # output.df[4, ] = modelList
          
          # TODO: pval, 
          modelList <- list(p, d, q, aic, NULL, shapiroPValue)
          # modelList
          # output.df[i, ] <- modelList
          output.df <- rbind(p, d, q, AIC, pval, shapiroPValue)
          i = i + 1
        }
      }
    }
  }
  output.df %>% head()
# }



findBestModel(data.ts__log)
```


+++++++++++++++++++++++++++++




Moving Average

Outliers - ignoring some

```{r}
d=2
for(q in 0:2){
  for(p in 0:7){
    
    if(p+d+q<=7){
    model<-arima(x=data.ts, order = c((p),d,(q)))
    pval<-Box.test(model$residuals, lag=log(length(model$residuals)))
    sse<-sum(model$residuals^2)
    cat(p,d,q,'AIC=', model$aic, ' SSE=',sse,' p-VALUE=', pval$p.value,'\n')
        }
      }
    }
```
source: https://rpubs.com/tacacs/359624


move figure numbers to doPar?