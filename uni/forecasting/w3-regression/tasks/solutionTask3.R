
library(dLagM)
library(forecast)
globalWarming = read.csv("~/Documents/MATH1307_Forecasting/Tasks/Task 3/global_warming_CO2.csv")

class(globalWarming)
head(globalWarming)

warming = ts(globalWarming$Warming,start = 1959)
co2 = ts(globalWarming$CO2,start = 1959)
data.ts = ts(globalWarming[,2:3],start = 1959)

# We can plot them individually
plot(warming, ylab = "Relative temperature change", xlab = "Year", main = "Global warming series")
plot(co2, ylab = "Parts per million (ppm) ", xlab = "Year", main = "Mid-tropospheric carbon dioxide series")

# We can plot them in the same frame but the scales will be problemtatic and we won't be able to see warming series cearly.
plot(data.ts, plot.type="s",col = c("blue", "red"), main = "Global warming and CO2 series")
legend("topleft",lty=1, text.width = 11, col=c("blue","red"), c("Y series", "X series"))

# We can scale and center both series to see in the same plot clearly
data.scaled = scale(data.ts)
plot(data.scaled, plot.type="s",col = c("blue", "red"), main = "Global warming and CO2 series")
legend("topleft",lty=1, text.width = 11, col=c("blue","red"), c("Y series", "X series"))

# The correlation between warming and CO2 series is very high
cor(data.ts)

# Fit a finite DLM with a lag length of 4 and do the diagnostic checking.
# No need to supply ts object. The function looks for vectors.
model1 = dlm( x = as.vector(co2) , y = as.vector(warming), q = 4 )
summary(model1)
checkresiduals(model1$model)

# Find the finite lag length based on AIC and BIC for this data
# We can change  q and compare AIC/BIC values
for ( i in 1:10){
  model1.1 = dlm( x = as.vector(co2) , y = as.vector(warming), q = i )
  cat("q = ", i, "AIC = ", AIC(model1.1$model), "BIC = ", BIC(model1.1$model),"\n")
}
# We go for the smallest AIC/BIC.

# Also we can use finiteDLMauto function as follows

# AIC
finiteDLMauto(
  x = as.vector(co2),
  y = as.vector(warming),
  q.min = 1,
  q.max = 10,
  model.type = "dlm",
  error.type ="AIC",
  trace = TRUE)

# BIC
finiteDLMauto(
  x = as.vector(co2),
  y = as.vector(warming),
  q.min = 1,
  q.max = 10,
  model.type = "dlm",
  error.type ="BIC",
  trace = TRUE)
# In the outpt "q - k" shows the lag length.

model1.2 = dlm(
  x = as.vector(co2),
  y = as.vector(warming),
  q = 1)
summary(model1.2)
checkresiduals(model1.2$model)

# Fit a polynomial DLM of order 2. Display the estimates of original parameters and their significance tests.
model2 = polyDlm(
  x = as.vector(co2),
  y = as.vector(warming),
  q = 2,
  k = 2, 
  show.beta = TRUE)
summary(model2)
checkresiduals(model2$model)

# Find forecasts for the CO2 levels 406.31, 407, and 415. Here 406.31 ppm is the latest measurement in May 2017. 
# Plot the forecasts along with the original warming series.
model1.2Frc = dLagM::forecast(
  model1.2, 
  x = c(406.31, 407, 415), 
  h = 3)
model2Frc = dLagM::forecast(
  model2, 
  x = c(406.31, 407, 415), 
  h = 3)

plot(
  ts(
    c(
      as.vector(warming), 
      model1.2Frc$forecasts
    ),
    start = 1959),
  type="o",
  col="Blue",
  ylim=c(-0.3, 1.7),
  ylab = "Warming", 
  xlab = "Year", 
  main="Global warming series with three years ahead forecasts")

lines(
  ts(
    c(as.vector(warming), model2Frc$forecasts), 
    start = 1959
  ),
  col="red",
  type="o"
)
lines(
  ts(
    as.vector(warming), 
    start = 1959
  ),
  col="black",
  type="o")

legend(
  "topleft",
  lty=1,
  pch = 1,
  text.width = 11, 
  col=c("blue", "red", "black"), 
  c("Dlm", "Polynomial", "Warming")
)

# Fit the Koyck model. Find and plot the forecasts for the case given above.

model3 = koyckDlm(
  x = as.vector(co2),
  y = as.vector(warming))
summary(model3)
checkresiduals(model3$model)

# Fit autoregressive distributed lag models and choose one of the models.

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
      "p = ", i, 
      "q = ", j, 
      "AIC = ", AIC(model4.1$model), 
      "BIC = ", BIC(model4.1$model),
      "\n")
  }
}
# p =  1 q =  1 gives the smallet AIc and BIC

# Find forecasts for the CO2 levels 406.31, 407, and 415. Here 406.31 ppm is the latest measurement in May 2017. 
# Plot the forecasts along with the original warming series.
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

plot(
  ts(
    c(
      as.vector(warming), 
      model1.2Frc$forecasts
    ),
    start = 1959
  ),
  type="o",
  col="Blue",
  ylim= c(-0.3, 1.7), 
  ylab = "Warming",
  xlab = "Year",
  main="Global warming series with 3 years ahead forecasts"
  )      
lines(
  ts(
    c(
      as.vector(warming),
      model2Frc$forecasts),
      start = 1959
    ),
    col="red",
    type="o"
)
lines(
  ts(
    c(
      as.vector(warming),
      model3Frc$forecasts
    ),
    start = 1959
  ),
  col="green",
  type="o"
)
lines(
  ts(
    c(
      as.vector(warming), 
      model4Frc$forecasts
    ), 
    start = 1959
  ),
  col="purple",
  type="o"
)
lines(
  ts(
    as.vector(warming),
    start = 1959),
    col="black",
    type="o")
legend(
  "topleft",
  lty = 1,
  pch = 1,
  text.width = 11,
  col = c("blue", "red", "green", "purple", "black"), c("Dlm", "Polynomial", "Koyck", "ARDL", "Warming")
)