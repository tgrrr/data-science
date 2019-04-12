# R Cheatsheet

## Get Started
```r
install.packages("forcats")

library(readr)
library(forcats)

setwd('./data/')
```
## Get the dataset

```r
Cars <- read_csv("Cars - Cars.csv")
```

## Printing

```r
proportion_car_cylinders <- barplot(freq, main = "Cars", ylab="Percent", ylim=c(0,50))
dev.copy(png, filename='exports/proportion_car_cylinders.png')
dev.off()
```
