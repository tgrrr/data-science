#--- Task 3 ---

3. Load the monthly commercial landings dataset of US-NMFS from the file “ozone.csvPreview the document” into the workspace of R. Do the following tasks over the "Metric_Tons" series;

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

# 3. Load the monthly commercial landings dataset of US-NMFS from the file “ozone.csvPreview the document” into the workspace of R. Do the following tasks over the "Metric_Tons" series;

1. Convert data into a time series object
ozone.ts = 
  matrix(
    ozone$Metric_Tons, 
    nrow = 25, 
    ncol = 12)
ozone.ts = as.vector(t(ozone.ts))
ozone.ts = ts(
  ozone.ts,
  start = c(1991, 1),
  end = c(2015, 12),
  frequency = 12
)
class(ozone.ts)

2. Display and interpret the time series plot for these data.
plot(
  ozone.ts,
  ylab = 'Landings in metric tons',
  xlab = 'Year',
  type = 'o',
  main = "Time series plot of monthly landings in metric tons."
)

# This has points as well
plot(
  ozone.ts,
  ylab = 'Landings in metric tons',
  xlab = 'Year',
  main = "Time series plot of monthly landings in metric tons.")
points(y = ozone.ts,
       x = time(ozone.ts),
       pch = as.vector(season(ozone.ts)))

# Neighbouring / previous year
plot(
  y = ozone.ts,
  x = zlag(ozone.ts),
  ylab = 'Landings in metric tons',
  xlab = 'Previous Year Landings in metric tons' ,
  main = "Scatter plot of neighboring landings in metric tons"
)

y = ozone.ts # Read the Landings in metric tons data into y
x = zlag(ozone.ts) # Generate first lag of the Spawners series
index = 2:length(x) # Create an index to get rid of the first NA value and the last 5 missing values in x
cor(y[index], x[index])

- Linear time trend
# Use least squares to fit a linear time trend to this time series. Interpret the regression output. Save the standardized residuals from the fit for further analysis.

model.ozone.ln = lm(ozone.ts ~ time(ozone.ts)) # label the linear trend model
summary(model.ozone.ln)
plot(ozone.ts, type = 'o', ylab = 'y')
abline(model.ozone.ln)

# Linear residuals
res.model.ozone.ln = rstudent(model.ozone.ln)
plot(
  y = res.model.ozone.ln,
  x = as.vector(time(ozone.ts)),
  xlab = 'Time',
  ylab = 'Standardized Residuals',
  type = 'o'
)
qqnorm(res.model.ozone.ln)
qqline(
  res.model.ozone.ln,
  col = 2,
  lwd = 1,
  lty = 2
)
shapiro.test(res.model.ozone.ln)
acf(res.model.ozone.ln)

- Quadratic
# Use the least squares approach to fit a quadratic time trend to the series. Interpret the regression output. Save the standardized residuals from the fit for further analysis.
t = time(ozone.ts)
t2 = t ^ 2
model.ozone.qa = lm(ozone.ts ~ t + t2) # label the quadratic trend model
summary(model.ozone.qa)

plot(
  ts(fitted(model.ozone.qa)),
  ylim = c(min(c(
    fitted(model.ozone.qa),
    as.vector(ozone.ts)
  )), max(c(
    fitted(model.ozone.qa), as.vector(ozone.ts)
  ))),
  ylab = 'y' ,
  main = "Fitted quadratic curve to random walk data",
  type = "l",
  lty = 2,
  col = "red"
)
lines(as.vector(ozone.ts), type = "o")

# Quadratic residuals
res.model.ozone.qa = rstudent(model.ozone.qa)
plot(
  y = res.model.ozone.qa,
  x = as.vector(time(ozone.ts)),
  xlab = 'Time',
  ylab = 'Standardized Residuals',
  type = 'o'
)
qqnorm(res.model.ozone.qa)
qqline(
  res.model.ozone.qa,
  col = 2,
  lwd = 1,
  lty = 2
)
shapiro.test(res.model.ozone.qa)
acf(res.model.ozone.qa)

# Harmonic
# Use the least squares approach to fit a harmonic trend. 
# Interpret the regression output. Save the standardized residuals from the fit for further analysis.
har. = harmonic(ozone.ts, 1)
model.ozone.har = lm(ozone.ts ~ har.)
summary(model.ozone.har)
plot(
  ts(fitted(model.ozone.har)),
  ylim = c(min(c(
    fitted(model.ozone.har),
    as.vector(ozone.ts)
  )), max(c(
    fitted(model.ozone.har),
    as.vector(ozone.ts)
  ))),
  ylab = 'y' ,
  main = "Fitted quadratic curve to random walk data",
  type = "l",
  lty = 2,
  col = "red"
)
lines(as.vector(ozone.ts), type = "o")

# Harmonic residuals
res.model.ozone.har = rstudent(model.ozone.har)
plot(
  y = res.model.ozone.har,
  x = as.vector(time(ozone.ts)),
  xlab = 'Time',
  ylab = 'Standardized Residuals',
  type = 'o'
)
qqnorm(res.model.ozone.har)
qqline(
  res.model.ozone.har,
  col = 2,
  lwd = 1,
  lty = 2
)
shapiro.test(res.model.ozone.har)
acf(res.model.ozone.har)
