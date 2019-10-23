library(dynlm)
library(ggplot2)
library(AER)
library(Hmisc)
library(forecast)
library(x12)
library(dLagM)
library(TSA)
library(readr)

source('~/Documents/MATH1307_Forecasting/notes/Module 9/GoFVals.R')
source('~/Documents/MATH1307_Forecasting/notes/Module 9/pVal.R')
source('~/Documents/MATH1307_Forecasting/notes/Module 9/LEIC.R')
source('~/Documents/MATH1307_Forecasting/notes/Module 9/MASEvalues.R')

# TASK 1
Austria_Unemployment <- read_csv("~/Desktop/MATH1307/Week10/Task9/Austria_Unemployment.csv", col_names = T)
Austria_Unemployment = ts(Austria_Unemployment$Value, start = c(1995,1), frequency = 12)

Australia_Unemployment <- read_csv("~/Desktop/MATH1307/Week10/Task9/Australia_Unemployment.csv", col_names = T)
Australia_Unemployment = ts(Australia_Unemployment$Value, start = c(1995,1), frequency = 12)

Canada_Unemployment <- read_csv("~/Desktop/MATH1307/Week10/Task9/Canada_Unemployment.csv", col_names = T)
Canada_Unemployment = ts(Canada_Unemployment$Value, start = c(1995,1), frequency = 12)

US_Unemployment <- read_csv("~/Desktop/MATH1307/Week10/Task9/US_Unemployment.csv", col_names = T)
US_Unemployment = ts(US_Unemployment$Value, start = c(1995,1), frequency = 12)

UK_Unemployment <- read_csv("~/Desktop/MATH1307/Week10/Task9/UK_Unemployment.csv", col_names = T)
UK_Unemployment = ts(UK_Unemployment$Value, start = c(1995,1), frequency = 12)

Japan_Unemployment <- read_csv("~/Desktop/MATH1307/Week10/Task9/Japan_Unemployment.csv", col_names = T)
Japan_Unemployment = ts(Japan_Unemployment$Value, start = c(1995,1), frequency = 12)


par(mfrow=c(1,1))
plot(Austria_Unemployment, ylab = "Unemployment rate",  main = "Monthly unemployment rates in Austria")
acf(Austria_Unemployment, main = "Sample ACF of monthly unemployment rates in Austria")

par(mfrow=c(1,1))
plot(Australia_Unemployment, ylab = "Unemployment rate",  main = "Monthly unemployment rates in Australia")
acf(Australia_Unemployment, main = "Sample ACF of monthly unemployment rates in Australia")

par(mfrow=c(1,1))
plot(Canada_Unemployment, ylab = "Unemployment rate",  main = "Monthly unemployment rates in Canada")
acf(Canada_Unemployment, main = "Sample ACF of monthly unemployment rates in Canada")

par(mfrow=c(1,1))
plot(US_Unemployment, ylab = "Unemployment rate",  main = "Monthly unemployment rates in US")
acf(US_Unemployment, main = "Sample ACF of monthly unemployment rates in US")

par(mfrow=c(1,1))
plot(UK_Unemployment, ylab = "Unemployment rate",  main = "Monthly unemployment rates in UK")
acf(UK_Unemployment, main = "Sample ACF of monthly unemployment rates in UK")

par(mfrow=c(1,1))
plot(Japan_Unemployment, ylab = "Unemployment rate",  main = "Monthly unemployment rates in Japan")
acf(Japan_Unemployment, main = "Sample ACF of monthly unemployment rates in Japan")

data = list()
data[[1]] = Austria_Unemployment
data[[2]] = Australia_Unemployment
data[[3]] = Canada_Unemployment
data[[4]] = UK_Unemployment
data[[5]] = US_Unemployment
data[[6]] = Japan_Unemployment


H = 5

models = c("AAN", "MAN", "AAA", "MAA", "MAM")

GoFVals(data = data, H = H, models = models)

LEIC(data = data, H = H, models = models)

pVal(data = data, H = H, models = models)
