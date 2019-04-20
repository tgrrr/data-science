rm(list = ls())
library(magrittr)
library("TSA")
working_directory <- "~/code/data-science/cheatsheet/source/includes/time-series/01-plots-fundamentals/tasks"

# 1. Load the Melbourne Airport annual rainfall data (MelbourneAnnualRainfall.csvPreview the document) into R. Then, produce the time series plot for the annual rainfall series in Melbourne Airport. Do you think there is a trend in the series?

# Hint: Use the function “ts()” to convert the “data.frame” into a times series object in R.

#--- Task 1 ---
setwd(working_directory)
MelbourneAnnualRainfall <-
  read.csv("raw-data/MelbourneAnnualRainfall.csv", header = FALSE)
rownames(MelbourneAnnualRainfall) <- seq(from = 1995, to = 2016)
class(MelbourneAnnualRainfall)
plot(MelbourneAnnualRainfall, type = "o", ylab = "Amount of annual rainfall")
MelbourneAnnualRainfall <-
  ts(as.vector(MelbourneAnnualRainfall),
    start = 1995,
    end = 2016
  ) # Convert to the TS object!
plot(MelbourneAnnualRainfall, type = "o", ylab = "Amount of annual rainfall")

#--- Task 2 ---
# 2. Simulate a completely random process of length 48 with independent, normal values. At this stage set the mean and variance of the normal distribution to arbitrary values.
# - Display the time series plot without converting the generated data to a time series object and by converting the generated data to a time series object. Does it look “random?”
# - Repeat this exercise several times with a new simulated dataset at each time. Does your view on the randomness of series change from one simulation to the other?
# - Repeat this exercise with standard deviations of 0.1 and 10. What is the effect of variance of series on the resulting time series plot?

#--- Task 2 ---
mu <- 0
sigma <- 10 # 0.1 #sqrt{Var}
n <- 48
y <- rnorm(n, mu, sigma)
# ? rnorm
plot(y)
plot(ts(y))

plot.ts(y, lty = 2, type = "o", ylab = "Normal distributed process") # without converting the generated data to a time series object
plot(ts(y), type = "o", ylab = "Normal distributed process") # converting the generated data to a time series object

#--- Task 3 ---

# 3. Simulate a completely random process of length 48 with independent, chi-square distributed values, each with 2 degrees of freedom.
# - Display the time series plot. Does it look “random?”
# - Repeat this exercise several times with a new simulated dataset at each time. Does your view on the randomness of series change from one simulation to the other?
# - Compare your results with those obtained in the second task.

#--- Task 3 ---

nu <- 2
n <- 48
y <- rchisq(n, nu)
plot(ts(y), type = "o", ylab = "Chi-squre distributed process") # converting the generated data to a time series object

#--- Task 4 ---
MelbourneMonthlyRainfall <- read.csv(
  "raw-data/MelbourneMonthlyRainfall.csv",
  header = FALSE
)
# MelbourneMonthlyRainfall
rownames(MelbourneMonthlyRainfall) <- seq(from = 1995, to = 2016)
colnames(MelbourneMonthlyRainfall) <-
  c(
    "jan",
    "feb",
    "mar",
    "apr",
    "may",
    "jun",
    "jul",
    "aug",
    "sep",
    "oct",
    "nov",
    "dec"
  )
class(MelbourneMonthlyRainfall)

MelbourneMonthlyRainfall <-
  ts(
    as.vector(as.matrix(MelbourneMonthlyRainfall)),
    start = c(1995, 1),
    end = c(2016, 12),
    frequency = 12
  )
MelbourneMonthlyRainfall
# Now the data read into R in an incorrect order!!! Check with the original CSV file!

# Read the raw data again
MelbourneMonthlyRainfall <- read.csv("~/Desktop/MATH1318/Week1/Task1//MelbourneMonthlyRainfall.csv",
  header = FALSE
)
MelbourneMonthlyRainfall <-
  ts(
    as.vector(as.matrix(t(
      MelbourneMonthlyRainfall
    ))),
    start = c(1995, 1),
    end = c(2016, 12),
    frequency = 12
  )
MelbourneMonthlyRainfall
# We should take the transpose of the matrix with t() to put in the correct order!!!

class(MelbourneMonthlyRainfall)

# --- The following line is to open a new graphics window in Windows ---
win.graph(
  width = 4.875,
  height = 2.5,
  pointsize = 8
)
# --- The following line is to open a new graphics window in Mac OS ---
x11()

plot(MelbourneMonthlyRainfall, type = "o", ylab = "Amount of monthly rainfall")
points(
  y = MelbourneMonthlyRainfall,
  x = time(MelbourneMonthlyRainfall),
  pch = as.vector(season(MelbourneMonthlyRainfall))
)

a <- season(MelbourneMonthlyRainfall)
a
