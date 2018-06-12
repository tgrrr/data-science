install.packages("readr")
library(readr)

setwd("./.")

getwd()

iriscsv <- ("iris.csv")

head(iriscsv)

# Import csv version of Population dataset (population.csv) using Base R functions.


# 4 Repeat exercise 3, this time use readr functions.

install.packages(readxl)
library(readxl)

population_migration-density_and_region <- read_excel("population-migration.xls", sheetName="Population Density and Regional")
