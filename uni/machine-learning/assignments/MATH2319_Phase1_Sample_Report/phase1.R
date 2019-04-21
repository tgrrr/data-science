rm(list = ls())
graphics.off()
# 1. Packages  ----
library(knitr)
library(mlr)
library(tidyverse)
library(GGally)
library(cowplot)

# 2. Data Processing ----
# 2.1. Preliminaries ----
train <- read.csv('Datasets/adult.data.txt', stringsAsFactors = FALSE, header = FALSE)
test  <- read.csv('Datasets/adult.test.txt', stringsAsFactors = FALSE, skip = 1, header = FALSE)
adult <- rbind(train, test)


names( adult ) <- c('age', 'workclass', 'fnlwght', 'education', 'education_num',
                    'marital_status', 'occupation', 'relationship', 'race', 'sex',
                    'capital_gain', 'capital_loss', 'hours_per_week', 'native_country',
                    'income')

# 2.2 Data Cleaning ----
summarizeColumns(adult)
str( adult )

adult[, sapply( adult, is.character )] <- sapply( adult[, sapply( adult, is.character )], trimws)

table(adult$income)
adult$income <- sub('K.', "K", adult$income)

adult %>% filter( capital_gain > 0 & capital_loss > 0) %>% summarise(count = n())

adult$capital <- adult$capital_gain - adult$capital_loss
adult$capital_gain <- NULL
adult$capital_loss <- NULL

adult %>% select( capital ) %>% filter ( capital < 99999 ) %>% summary()
adult %>% select( capital ) %>% filter ( capital == 99999 ) %>% summarise(count = n())
adult %>% filter ( capital == 99999 ) %>% select( income, capital) %>% table()

sapply( adult[ sapply(adult, is.character)], table)

adult %>% filter( workclass == '?') %>% select( occupation ) %>% table()
adult %>% filter( occupation == '?') %>% select(income) %>% table()
adult %>% filter( occupation == 'Armed-Forces') %>% select(income ) %>% table()

adult <- adult %>% 
  mutate( workclass1 = ifelse( workclass %in% c('?', 'Never-worked', 'Without-pay'), "Other",
                              ifelse( grepl('gov', workclass), 'gov', 
                                      ifelse( grepl('Self-emp', workclass), 'Self-emp', workclass )) ),
          
          education1 = ifelse( grepl('th', education) | education == 'Preschool', 'Before-HS',
                              ifelse( education %in% c('Doctorate', 'Masters', 'Prof-school'), 'Postgrad', 
                                      ifelse( grepl( 'Assoc', education ), 'Assoc', education ) ) ),
          
          native_country1 = ifelse( native_country != 'United-States', 'Not US', 'United-States'),
          marital_status1 = ifelse( grepl( 'Married', marital_status ), 'Married', marital_status),
          occupation1 = ifelse( occupation == '?', 'Other', occupation)
          )

table( adult$education1 )
table( adult$workclass1 )
table( adult$marital_status1 )
table( adult$native_country1 )
table( adult$occupation1 )

adult[, sapply( adult, is.character )] <- lapply( adult[, sapply( adult, is.character )], factor) 
adult$fnlwght <- NULL
summarizeColumns(adult)

# 3. Visualisation ----
# 3.1 Univariate Visualisation ---
# 3.1.1 Numerical Features ----
ggplot(adult, aes(x = age)) + geom_histogram(bins = 35)
ggplot(adult, aes(x = age, fill = income)) + geom_histogram(bins = 35) + facet_grid(~income)

ggplot(adult, aes(x = hours_per_week)) + geom_histogram(bins = 20) 
ggplot(adult, aes(x = hours_per_week, fill = income)) + geom_histogram(bins = 20) + facet_grid(~income)

ggplot(adult, aes(x = education_num)) + geom_bar()
ggplot(adult, aes(x = education_num, fill = income)) + geom_bar() + facet_grid(~income)

ggplot(adult, aes(x = capital)) + geom_histogram(bins = 20) 
ggplot(adult, aes(x = capital, fill = income)) + geom_bar() + facet_grid(~income)
ggplot(adult %>% mutate(capital = ifelse( capital > 0 , 'gain', 'loss') ), 
       aes(x = capital, fill = income)) + geom_bar() + facet_grid(~income)

# 3.1.2 Categorical Features ----
ggplot(adult, aes(x = workclass1)) + geom_bar()
ggplot(adult, aes(x = workclass1, fill = income)) + geom_bar() + facet_grid(income~.)

ggplot(adult, aes(x = education1)) + geom_bar()
ggplot(adult, aes(x = education1, fill = income)) + geom_bar() + facet_grid(income~.)

ggplot(adult, aes(x = marital_status1)) + geom_bar()
ggplot(adult, aes(x = marital_status1, fill = income)) + geom_bar() + facet_grid(income~.)

ggplot(adult, aes(x = occupation1)) + geom_bar()
ggplot(adult, aes(x = occupation1, fill = income)) + geom_bar() + facet_grid(income~.)

ggplot(adult, aes(x = relationship)) + geom_bar()
ggplot(adult, aes(x = relationship, fill = income)) + geom_bar() + facet_grid(income~.)

ggplot(adult, aes(x = race)) + geom_bar()
ggplot(adult, aes(x = race, fill = income)) + geom_bar() + facet_grid(income~.)

ggplot(adult, aes(x = native_country1 )) + geom_bar()
ggplot(adult, aes(x = native_country1 , fill = income)) + geom_bar() + facet_grid(income~.)

# 3.2 Multvariate Visualisation ----
# 3.2.1. Scatterplot Matrix ----
ggpairs( adult,  aes(color = income))

# 3.2.2 Others ----
ggplot(adult, aes(x = education_num, fill = education)) + geom_bar()
ggplot(adult, aes(x = education_num, fill = education1)) + geom_bar()

adult$education_num <- NULL

ggplot(adult, aes(x = education1, fill = income)) + 
  geom_bar() + facet_grid( marital_status1 ~ workclass1 )

ggplot(adult, aes(x = workclass1, fill = income)) + 
  geom_bar( ) + facet_grid( sex~ marital_status1)

ggplot(adult, aes(x = age, fill = income)) + geom_histogram() +
  facet_grid(sex~education1)

adult <- adult %>% 
  mutate(ageBand = ordered( cut(age, c(0, 25, 55, Inf)), labels = c('Young', 'Middled-Age', 'Old') ))

ggplot(adult, aes(x = ageBand, fill = income)) + 
  geom_bar() +
  facet_grid(sex~education1)   

ggplot(adult, aes(x = ageBand, fill = income)) + 
  geom_bar() +
  facet_grid(sex~marital_status1)     
