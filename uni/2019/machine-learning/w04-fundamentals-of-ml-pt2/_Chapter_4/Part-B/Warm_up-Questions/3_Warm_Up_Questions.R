# Chapter 3 ----
# 0. Preliminaries ----
fraud <- read.csv('MotorInsuranceFraudClaimABTFull.csv')
head(fraud)
str(fraud)

library(mlr)
library(tidyverse)
summarizeColumns( fraud )

# 1. Data Quality Report ----
sapply( fraud, is.numeric )
continuous_features <- fraud[,  sapply( fraud, is.numeric )]

mean( continuous_features$Num.Soft.Tissue )
mean( continuous_features$Num.Soft.Tissue, na.rm = TRUE )

quantile( continuous_features$Num.Claimants)
quantile( continuous_features$Num.Claimants)[2]
quantile( continuous_features$Num.Claimants)[4]

quality_report_continuous <- summarizeColumns( continuous_features ) 

quality_report_continuous$quarter1     <- sapply( continuous_features, function(x){ quantile(x, na.rm = TRUE)[2] }  )
quality_report_continuous$quarter2     <- sapply( continuous_features, function(x){ quantile(x, na.rm = TRUE)[4] }  )
quality_report_continuous$cardinality  <- sapply( continuous_features, function(x){ length( unique(x, na.rm = TRUE) ) }  )

quality_report_continuous

categorical_features          <- fraud[,  sapply( fraud, is.factor )]
quality_report_categorical    <- summarizeColumns( categorical_features )

quality_report_categorical
unique(categorical_features$Marital.Status)


categorical_features <- categorical_features %>% 
  mutate( Marital.Status = ifelse( trimws(Marital.Status) == '', NA, Marital.Status ),
          Marital.Status = factor( Marital.Status))

quality_report_categorical    <- summarizeColumns( categorical_features )
quality_report_categorical   

levels( categorical_features$Injury.Type)

x <- table(categorical_features$Injury.Type)
max(x)
names(x)[x == max(x)]

quality_report_categorical$modeFreq <- sapply( categorical_features, function(x){ max(table(x)) }  )
quality_report_categorical$mode     <- sapply( categorical_features, function(x){ y <- table(x); names(y)[y == max(y)]    }  )

quality_report_categorical 

# 2. Probability Distribution ----
hist( fraud$Income.of.Policy.Holder, main = 'Income', xlab = 'Income', breaks = 30 )
hist( fraud$Income.of.Policy.Holder, main = 'Income', xlab = 'Income', breaks = 40 )
x <- table( fraud$Injury.Type )
barplot(x)

library( ggplot2 )
ggplot( fraud, aes(x = Income.of.Policy.Holder) ) + geom_histogram(bins = 40) + labs(x = 'Income')
ggplot( fraud, aes(x = Claim.Amount) ) + geom_histogram(bins = 40) + labs(x = 'Claim Amount')
ggplot( fraud, aes(x = Injury.Type ) )+ geom_bar() + labs(x = 'Injury Type')

# 3. Irregular Cardinality and outliers ----
fraud <- fraud %>% mutate( Fraud.Flag = factor( Fraud.Flag ),
                           Num.Claimants = factor( Num.Claimants),
                           Num.Claims  = factor( Num.Claims ),
                           Num.Soft.Tissue = factor( Num.Soft.Tissue ))

fraud <- fraud %>% mutate( Claim.Amount = ifelse( Claim.Amount == -99999, NA, Claim.Amount) )
summary( fraud$Claim.Amount )

fraud[fraud$Total.Claimed == max( fraud$Total.Claimed ), ]

table( fraud$Num.Claims )
fraud[ fraud$Num.Claims == 56, ]

summary(fraud$Total.Claimed)

fraud <- fraud[ !(fraud$Total.Claimed == max( fraud$Total.Claimed )), ]
fraud <- fraud[ !fraud$Num.Claims == 56, ]


# 3.4. Handling Outliers ----
IQR( fraud$Claim.Amount, na.rm = TRUE )
boxplot( fraud$Claim.Amount, plot = FALSE)$stats

# 3.5 Visualisation ----
library(GGally)
ggpairs( fraud, columns = 3:ncol(fraud), aes(color = Fraud.Flag))
ggpairs( fraud, 
         columns = c('Income.of.Policy.Holder', 'Claim.Amount',
                     'Total.Claimed', 'X..Soft.Tissue','Claim.Amount.Received',
                     'Fraud.Flag'), 
         aes(color = Fraud.Flag))

ggplot( fraud, aes(x = Injury.Type, fill = Fraud.Flag)) + geom_bar()
ggplot( fraud, aes(x = Injury.Type, fill = Fraud.Flag)) + 
  geom_bar(aes(y = (..count..)/sum(..count..))) +
  labs(x = 'Injury Type', y = 'Proportion')

barplot( prop.table( table(fraud$Fraud.Flag, fraud$Injury.Type ) ))

ggplot( fraud, aes(x = Injury.Type, fill = Fraud.Flag)) + 
  geom_bar(aes(y = (..count..)/sum(..count..)), position = 'dodge') +
  labs(x = 'Injury Type', y = 'Proportion')

str( fraud )

ggplot( fraud, aes(x = Fraud.Flag, y = Claim.Amount )) + geom_boxplot() 
ggplot( fraud, aes(x = Fraud.Flag, y = log(Claim.Amount) )) + geom_boxplot() 

subdata <- fraud %>% select( Income.of.Policy.Holder, Claim.Amount, Total.Claimed, X..Soft.Tissue )
cor(na.omit( subdata))
library(corrplot)
corrplot( cor(na.omit( subdata)) )
corrplot( cor(na.omit( scale( subdata))) )


