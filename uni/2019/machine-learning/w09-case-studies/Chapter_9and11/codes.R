library(mlr)
library(ggplot2)
library(robustHD)
library(readr)
library(tidyverse)
data <- read_csv('ACMETelephoneABT.csv')
dim(data)
data %>% 
  mutate(
    
    regionType = case_when(
        
        regionType == 'r' ~ 'rural',
        regionType == 's' ~ 'suburban',
        regionType == 't' ~ 'town',
        regionType == 'unknown' ~ NA
      
      )
    
  )
