install.packages("readr")
install.packages("rvest")
install.packages("xlsx")

setwd("~/Documents/code/data-science-apps/data-preprocessing/import-scraping-export-week2")

dir.create("foo2")

getwd()

setwd("./.")

getwd()

iris <- read_csv("iris.csv")
View(iris)

str(iris)

View(iris1)

head(iris)

# 3. Import csv version of Population dataset (population.csv) using Base R functions.

base_population <- read.csv("population.csv")
head(base_population)

# 4.  Repeat exercise 3, this time use readr functions.

install.packages("readr")
library(readr)
readr_population <- read_csv("population.csv")
head(readr_population)

# 5. Import spss version of Population data (population.sav) using foreign package.

install.packages("foreign")
library(foreign)

