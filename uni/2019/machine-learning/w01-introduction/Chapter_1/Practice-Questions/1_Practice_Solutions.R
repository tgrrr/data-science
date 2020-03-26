# Practice Solutions ----
# Question 1 ----
library( tidyverse )
scores2 <- read.csv('Table1-2.csv', skip = 2, stringsAsFactors = FALSE)
head(scores2)

scores2$Outcome    <- trimws(sub('\t', '', scores2$Outcome))
scores2$Occupation <- trimws(sub('\t', '', scores2$Occupation))
scores2$Property   <- trimws(sub('\t', '', scores2$Property))
scores2$Type       <- trimws(sub('\t', '', scores2$Type))

scores2 <- scores2 %>% 
  mutate( Outcome    = trimws(sub('\t', '', Outcome)) ,
          Occupation = trimws(sub('\t', '', Occupation)),
          Property   = trimws(sub('\t', '', Property)),
          Type       = trimws(sub('\t', '', Type))
  )


subAndTrim <- function( x ){
  
  x <- trimws(sub('\t', '',  x)) 
  x <- factor( x )
  return(x)
}

scores2[, sapply(scores2, class) == 'character'] <- lapply( scores2[, sapply(scores2, class) == 'character'], FUN = subAndTrim   )    
summary(scores2)
str(scores2)
write.csv(scores2, file = 'scores2.csv', row.names = FALSE)

# Question 2 ----
rule1 <- function( data, k = 3){
  
  if(k < 0){
    stop( 'k must be larger than zero.')
  }
  
  data$pred <- ifelse( data$Ratio > k, 'default', 'repay')
  data$pred <- as.factor(data$pred)
  
  return( data[, c('Outcome', 'pred')] )
}

mod1        <- rule1( scores2, k = 3 )
mod2        <- rule1( scores2, k = 3.5)
table(mod1)
table(mod2)

# Question 3 ----
rule2 <- function( data, k1, k2, age, occupation ){
  
  data$pred <- case_when(
    (data$Ratio < k1) ~ "repay",
    (data$Ratio > k2) ~ "default",
    (data$Age < age & data$Occupation == occupation) ~ "default",
    TRUE ~ "repay"
  )
  
  data$pred <- as.factor(data$pred)
  
  return( data[, c('Outcome', 'pred')] )
}

# Question 4 ----
rule2( scores2, k1 = 1.5, k2 = 4, age = 40, occupation = 'industrial')
