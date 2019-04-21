rm(list = ls())
cat("\014") # Clear the console
library(TSA)

#--- Task 1 ---

# 1. The dataset ‘wages’ of TSA package contains monthly values of the average hourly wages (in dollars) for workers in the U.S. apparel and textile products industry for July 1981 through June 1987.
#
# Display and interpret the time series plot for these data.
# Use least squares to fit a linear time trend to this time series. Interpret the regression output. Save the standardized residuals from the fit for further analysis.
# Construct and interpret the time series plot of the standardized residuals from part (b) in a new graphics window.
# Use the least squares approach to fit a quadratic time trend to the wages time series. Interpret the regression output. Save the standardized residuals from the fit for further analysis.
# Construct and interpret the time series plot of the standardized residuals from part (d) in a new graphics window.
# Compare the plots from (c) and (e) in terms of the randomness of standardised residuals.

data("wages")
class(wages) # The class of this series is already ts!!!
plot(wages, type = 'o', ylab = 'Average hourly wages ')
# points(y=wages,x=time(wages),pch=as.vector(season(wages)))
model1 = lm(wages ~ time(wages)) # label the linear trend model as model1
summary(model1)

plot(wages, type = 'o', ylab = 'y')
abline(model1)

res.model1 = rstudent(model1)
#win.graph(width=4.875, height=2.5,pointsize=8)
plot(
  y = res.model1,
  x = as.vector(time(wages)),
  xlab = 'Time',
  ylab = 'Standardized Residuals',
  type = 'p'
)

t = time(wages)
t2 = t ^ 2
model2 = lm(wages ~ t + t2) # label the quadratic trend model as model1
summary(model2)

plot(ts(fitted(model2)), ylab = 'y' ,
     main = "Fitted quadratic curve to random walk data")
lines(as.vector(wages), type = "o")

res.model2 = rstudent(model2)
#win.graph(width=4.875, height=2.5,pointsize=8)
plot(
  y = res.model2,
  x = as.vector(time(wages)),
  xlab = 'Time',
  ylab = 'Standardized Residuals',
  type = 'p'
)
abline(h = 0)

#--- Task 2 ---

# 2. The dataset “beersales” of TSA package contains monthly U.S. beer sales (in millions of barrels) for the period January 1975 through December 1990.
#
# Display and interpret the plot the time series plot for these data.
# Now construct a time series plot that uses separate plotting symbols for the various months. Does your interpretation change from that in part (a)?
# Use the least squares approach to fit a seasonal-means trend to this time series. Interpret the regression output. Save the standardized residuals from the fit for further analysis.
# Construct and interpret the time series plot of the standardized residuals from part (c). Be sure to use proper plotting symbols to check on seasonality in the standardized residuals.
# Use least squares to fit a seasonal-means plus quadratic time trend to the beer sales time series. Interpret the regression output. Save the standardized residuals from the fit for further analysis.
# Construct and interpret the time series plot of the standardized residuals from part (e). Again, use proper plotting symbols to check for any remaining seasonality in the residuals.

data("beersales")
plot(beersales, type = 'o', ylab = 'Monthly U.S. beer sales')

plot(beersales, type = 'l', ylab = 'Sales')
points(y = beersales,
       x = time(beersales),
       pch = as.vector(season(beersales)))

t = time(beersales)
t2 = t ^ 2
month. = season(beersales) # period added to improve table display and this line sets up indicators
model3 = lm(beersales ~ month. + t + t2 - 1) # -1 removes the intercept term
summary(model3)

res.model3 = rstudent(model3)
#win.graph(width=4.875, height=2.5,pointsize=8)
plot(
  y = res.model3,
  x = as.vector(time(beersales)),
  xlab = 'Time',
  ylab = 'Standardized Residuals',
  type = 'p'
)
points(y = res.model3,
       x = time(beersales),
       pch = as.vector(season(beersales)))

kde(res.model3)

t = time(beersales)
t2 = t ^ 2
model4 = lm(beersales ~ t + t2) # label the quadratic trend model as model1
summary(model4)

res.model4 = rstudent(model4)
#win.graph(width=4.875, height=2.5,pointsize=8)
plot(
  y = res.model4,
  x = as.vector(time(beersales)),
  xlab = 'Time',
  ylab = 'Standardized Residuals',
  type = 'o'
)
points(y = res.model4,
       x = time(beersales),
       pch = as.vector(season(beersales)))


# =========================================================================== #

#--- Task 3 ---

3. Load the monthly commercial landings dataset of US-NMFS from the file “NMFS_Landings.csvPreview the document” into the workspace of R. Do the following tasks over the "Metric_Tons" series;

Display and interpret the time series plot for these data.
Construct a time series plot that uses separate plotting symbols for the various months. 
  Do you see the seasonal effect better?
Use least squares to fit a linear time trend to this time series. 
  Interpret the regression output. 
  Save the standardized residuals from the fit for further analysis.
Use the least squares approach to fit a quadratic time trend to the landings time series. 
  Interpret the regression output. 
  Save the standardized residuals from the fit for further analysis.
Use the least squares approach to fit a harmonic trend to the landings time series. 
  Interpret the regression output. 
  Save the standardized residuals from the fit for further analysis.
Conduct residual analyses for all models.

# 3. Load the monthly commercial landings dataset of US-NMFS from the file “NMFS_Landings.csvPreview the document” into the workspace of R. Do the following tasks over the "Metric_Tons" series;
# setwd("./.")
setwd("/Users/phil/code/data-science/cheatsheet/source/includes/time-series/raw-data")

MelbourneAnnualRainfall <-
  read.csv("MelbourneAnnualRainfall.csv",
           header = FALSE)

NMFS_Landings <-
  read.csv("NMFS_Landings.csv")
class(NMFS_Landings)
head(NMFS_Landings)

# Convert data into a time series object
NMFS_Landings.ts = matrix(NMFS_Landings$Metric_Tons, nrow = 25, ncol = 12)
NMFS_Landings.ts = as.vector(t(NMFS_Landings.ts))
NMFS_Landings.ts = ts(
  NMFS_Landings.ts,
  start = c(1991, 1),
  end = c(2015, 12),
  frequency = 12
)
class(NMFS_Landings.ts)

# Display and interpret the time series plot for these data.
plot(
  NMFS_Landings.ts,
  ylab = 'Landings in metric tons',
  xlab = 'Year',
  type = 'o',
  main = "Time series plot of monthly landings in metric tons."
)

plot(
  NMFS_Landings.ts,
  ylab = 'Landings in metric tons',
  xlab = 'Year',
  main = "Time series plot of monthly landings in metric tons.")
points(y = NMFS_Landings.ts,
       x = time(NMFS_Landings.ts),
       pch = as.vector(season(NMFS_Landings.ts)))

# Neighbouring
plot(
  y = NMFS_Landings.ts,
  x = zlag(NMFS_Landings.ts),
  ylab = 'Landings in metric tons',
  xlab = 'Previous Year Landings in metric tons' ,
  main = "Scatter plot of neighboring landings in metric tons"
)

y = NMFS_Landings.ts              # Read the Landings in metric tons data into y
x = zlag(NMFS_Landings.ts)        # Generate first lag of the Spawners series
index = 2:length(x)          # Create an index to get rid of the first NA value and the last 5 missing values in x
cor(y[index], x[index])

# Linear time trend
# Use least squares to fit a linear time trend to this time series. Interpret the regression output. Save the standardized residuals from the fit for further analysis.

model.NMFS_Landings.ln = lm(NMFS_Landings.ts ~ time(NMFS_Landings.ts)) # label the linear trend model as model.ChinookKR.ln
summary(model.NMFS_Landings.ln)
plot(NMFS_Landings.ts, type = 'o', ylab = 'y')
abline(model.NMFS_Landings.ln)

# Quadratic
# Use the least squares approach to fit a quadratic time trend to the landings time series. Interpret the regression output. Save the standardized residuals from the fit for further analysis.
t = time(NMFS_Landings.ts)
t2 = t ^ 2
model.NMFS_Landings.qa = lm(NMFS_Landings.ts ~ t + t2) # label the quadratic trend model as model.ChinookKR.qa
summary(model.NMFS_Landings.qa)

plot(
  ts(fitted(model.NMFS_Landings.qa)),
  ylim = c(min(c(
    fitted(model.NMFS_Landings.qa),
    as.vector(NMFS_Landings.ts)
  )), max(c(
    fitted(model.NMFS_Landings.qa), as.vector(NMFS_Landings.ts)
  ))),
  ylab = 'y' ,
  main = "Fitted quadratic curve to random walk data",
  type = "l",
  lty = 2,
  col = "red"
)
lines(as.vector(NMFS_Landings.ts), type = "o")

# Harmonic
# Use the least squares approach to fit a harmonic trend to the landings time series. Interpret the regression output. Save the standardized residuals from the fit for further analysis.
har. = harmonic(NMFS_Landings.ts, 1)
model.NMFS_Landings.har = lm(NMFS_Landings.ts ~ har.)
summary(model.NMFS_Landings.har)
plot(
  ts(fitted(model.NMFS_Landings.har)),
  ylim = c(min(c(
    fitted(model.NMFS_Landings.har),
    as.vector(NMFS_Landings.ts)
  )), max(c(
    fitted(model.NMFS_Landings.har),
    as.vector(NMFS_Landings.ts)
  ))),
  ylab = 'y' ,
  main = "Fitted quadratic curve to random walk data",
  type = "l",
  lty = 2,
  col = "red"
)
lines(as.vector(NMFS_Landings.ts), type = "o")

# Linear again? residuals
res.model.NMFS_Landings.ln = rstudent(model.NMFS_Landings.ln)
plot(
  y = res.model.NMFS_Landings.ln,
  x = as.vector(time(NMFS_Landings.ts)),
  xlab = 'Time',
  ylab = 'Standardized Residuals',
  type = 'o'
)
qqnorm(res.model.NMFS_Landings.ln)
qqline(
  res.model.NMFS_Landings.ln,
  col = 2,
  lwd = 1,
  lty = 2
)
shapiro.test(res.model.NMFS_Landings.ln)
acf(res.model.NMFS_Landings.ln)

# Quadratic (again)
res.model.NMFS_Landings.qa = rstudent(model.NMFS_Landings.qa)
plot(
  y = res.model.NMFS_Landings.qa,
  x = as.vector(time(NMFS_Landings.ts)),
  xlab = 'Time',
  ylab = 'Standardized Residuals',
  type = 'o'
)
qqnorm(res.model.NMFS_Landings.qa)
qqline(
  res.model.NMFS_Landings.qa,
  col = 2,
  lwd = 1,
  lty = 2
)
shapiro.test(res.model.NMFS_Landings.qa)
acf(res.model.NMFS_Landings.qa)

# Harmonic again
res.model.NMFS_Landings.har = rstudent(model.NMFS_Landings.har)
plot(
  y = res.model.NMFS_Landings.har,
  x = as.vector(time(NMFS_Landings.ts)),
  xlab = 'Time',
  ylab = 'Standardized Residuals',
  type = 'o'
)
qqnorm(res.model.NMFS_Landings.har)
qqline(
  res.model.NMFS_Landings.har,
  col = 2,
  lwd = 1,
  lty = 2
)
shapiro.test(res.model.NMFS_Landings.har)
acf(res.model.NMFS_Landings.har)
