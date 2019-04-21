library(mlr)
library(mlbench)
library(tidyverse)
library(cowplot)
set.seed(123)
n <- 100
data <- data.frame(heartRate = 65 + rnorm(n, 10, 10),
                   CaloriesBurnt = 100 + rnorm(n, 20, 5))


data$MCAR <- ifelse( rbinom(n, 1, 0.05) == 0, data$CaloriesBurnt, NA )
data$MAR  <- ifelse( data$heartRate > 65, data$CaloriesBurnt, NA)
data$MNAR <- ifelse( data$CaloriesBurnt > 120, data$CaloriesBurnt, NA)
write.csv(data, 'heartRateAndCaloriesBurnt.csv', row.names = FALSE)
head(data, n = 15) %>% knitr::kable()

sum( complete.cases(data[, c('heartRate', 'MCAR')]) )
sum( complete.cases(data[, c('heartRate', 'MAR')]) )
sum( complete.cases(data[, c('heartRate', 'MNAR')]) )

p1 <- data %>% 
  mutate( ind = ifelse(is.na(MCAR), 'Missing', 'Not Missing') ) %>%
  ggplot( aes(x = heartRate, y = CaloriesBurnt, color = ind)) + 
  geom_point( ) + scale_color_discrete('') +
  labs( x = '') + 
  ylim(105, 140) + xlim(50, 100) 
   

mod <- lm( MCAR ~ heartRate, data = data )

df <- data %>% 
  mutate( ind = ifelse(is.na(MCAR), 'Missing', 'Not Missing') ) %>%
  mutate( `Condtional Mean`    = mean(MCAR, na.rm = TRUE),
          HotDeck = 118.7665) %>%
  filter( is.na(MCAR) )

df$`Linear Reg`      <- predict( mod, newdata = df )
df$`Linear Reg + Noise` <- df$`Linear Reg` + rnorm(nrow(df), 2.5, sd = 5)

p2 <- df %>% 
  select(heartRate, CaloriesBurnt, `Condtional Mean`, HotDeck, `Linear Reg`, `Linear Reg + Noise`) %>% 
  melt( id = 'heartRate') %>% 
  ggplot( aes(x = heartRate, y =value, color = variable)) +
  geom_point( ) + ylim(105, 140) + xlim(50, 100) + 
  geom_smooth(method = 'lm', se = FALSE, alpha = 0.5, size = 0.5, fullrange  = TRUE) +
  scale_color_discrete('') + labs( y = 'CaloriesBurnt')

plot_grid(p1, p2, ncol = 1, align  = 'v')

data2 <- data %>% 
  select( heartRate, MCAR) %>% 
  rename( CaloriesBurnt = MCAR) %>% 
  mutate( numberOfMealsPerDay = rpois(n, 3),
          gender = factor(rep(c('Male', 'Female'), n/2)),
          exerciseIntensity = factor(rep(c('Moderate', 'Light', 'None', 'Strenous'), n/4)),
          weightType = factor(rep(c('Overweight', 'Normal'), n/2)))

data2 <- data2 %>%
  mutate(  numberOfMealsPerDay = ifelse(rbinom(n, 1, 0.15) == 0,  numberOfMealsPerDay, NA),
           gender = factor(ifelse(rbinom(n, 1, 0.20) == 0,  gender, NA)),
           exerciseIntensity = factor(ifelse(rbinom(n, 1, 0.25) == 0,  exerciseIntensity, NA)))

data2
write.csv(data2, 'weightTypes.csv', row.names = FALSE)

impute1 <- impute(data2, target = 'weightType', 
                  classes = list(numeric = imputeMean(),
                                 factor  = imputeMode(),
                                 integer = imputeMedian()) )
impute1$desc
head(impute1$data)
head(data2)

impute2 <- impute(data2, target = 'weightType', 
                  cols = list(CaloriesBurnt       = imputeNormal(),
                              numberOfMealsPerDay = imputeMedian(),
                              gender              = imputeMode()  ,
                              exerciseIntensity   = imputeLearner("classif.rpart"))
                  )
impute2$desc
head(impute2$data)
head(data2)

listLearners("regr",    properties = "missings")[c("class", "package")]
listLearners("classif", properties = "missings")[c("class", "package")]
