# Imputation of SpeedDating Data ----

# Remark:
# There is no universal formula of treating the missing values.
# The following script either removes the missing values or
# impute them with the median values or zero dependent on the target feature,
# which is "match". The `mlr` package is not utilised here, although
# one can define a customised imputation methods in mlr. We
# skip such approach as it is beyond the scope of this course.

# 1. Preliminary ----
## 1.1. Packages ----
library(farff)     # fast arff reading and writng packages
library(mlr)       # unified machine learning in r
library(tidyverse) # hadley's packages for data wrangling and visualisation
library(reshape2)  # manipulate data structure

## 1.2. Read and summarise data ----
dating <- readARFF("speeddating.arff")
colnames(dating)
str(dating)
summary(dating)

## 1.3 summary of match, the target feature
table(dating$match)
N <- nrow(dating) 
1380/N # 16.47 % match, highly unbalanced class

# 2. Getting Missing Values ----
## 2.1. Build function which generates a report of missing values  ----
# So that we can reuse it as we remove some missing values later

giveMeMVReport <- function( df ){
  
  y <- data.frame( 
    colnames        = colnames( df ),
    numberOfNA      = sapply( df, function(x){ sum(is.na(x)) } ),
    numbefOfOtherNA = sapply( df, function(x){ ifelse(is.character(x), 
                                                    sum( tolower( trimws(x)) %in% c('', 'na')), 'None' ) } ),
    type            = sapply( df, function(x){ class(x) } )
  )
  
  # Filter out columns without NA's
  y <- y %>% filter(numberOfNA > 0)
  return(y)
  
}

missingValueReport <- giveMeMVReport(dating)

# An more elegant way to produce missing value report (optional)
mlr::summarizeColumns(dating) %>% filter(na > 0)

## 2.2. Missing Value exploration ----
# How many factor and numeric columns have NA's
missingValueReport %>% 
  group_by( type ) %>% 
  summarise( count = n())


# Top 5 variables having the most NA's
missingValueReport %>% arrange( -numberOfNA) %>% head( n = 5)

# Wow, expected_num_interested_in_me has 6578 missing values of 8378 observations. 
summary(dating$expected_num_interested_in_me)

# Let's check how many matches when expected_num_interested is zero
dating %>% 
  select(expected_num_interested_in_me, match) %>% 
  filter(expected_num_interested_in_me == 0) %>% 
  group_by(match) %>% summarise(count = n())

# It is around 5 %
# How about missing expected_num_interested?
dating %>% 
  select(expected_num_interested_in_me, match) %>% 
  filter( is.na(expected_num_interested_in_me)) %>% 
  group_by(match) %>% summarise(count = n())

# 15.9 %, close to the overall distribution

# Imputing it is impractical and would probably induce bias. 
# It is better off to remove or redefine this column. 
# According to data dictionary, this column is defined as 
# "Out of the 20 people you will meet, how many do you expect will be interested in dating you?"
# So, we can possibly redefine:
# 1. missing values as "Unknown" (as most of people do not know)
# 2. 0 value as "None" for those are not confident of themselves
# 3. 1 to 10 as "Some" for those are confident to garner many interests

dating <- dating %>% 
  mutate( expected_num_interested_in_me = ifelse( is.na(expected_num_interested_in_me), 'unknown',
                                                        ifelse(expected_num_interested_in_me == 0, 'None', 'Some' ) ),
          expected_num_interested_in_me = factor(expected_num_interested_in_me)
        )


# The expected_num_matches, shared_interests_o and the rest 
# are okay in term of NA percentages. But we do not know if
# they are missing at random or completely random.

# Is there a pattern in number of missing values?
missingValueReport %>% 
  group_by( numberOfNA ) %>% 
  summarise( count = n() ) %>%
  arrange( - count)

# There are 22 columns which show the exact number of missing values
# Could these missing values come from the same rows?
# which columns?
missingValueReport %>% filter( numberOfNA == 79)

# It appears that these columns are either "importance" or "hobby/interest" features
# Let's get the column name where there are 79 NA's

seventyNineMissingCol <- missingValueReport %>% filter( numberOfNA == 79)
seventyNineMissingCol <- seventyNineMissingCol$colnames

# Subset the data by getting seventy-nine missing-value columns
# and get rows where importance_same_race is missing
# If these missing values are from the same rows, then
# we should get a total of 22 x 79 = 1738 missing values in df
df <- dating[,  as.character(seventyNineMissingCol) ]
sum(is.na(df %>% filter( is.na(importance_same_race  )) ))

# Alternatively, we can use summary
summary(df)
summarizeColumns(df)

# Now, we confirm they are from the same rows. So, why are they missing?
summary(df)

# Following the data dictionary, we know that:
# 1. attractive_important, sincere_important, intellicence_important are continuous ranging from 0 to 100
# 2. other variables are ratings features which are ordinal and fall within {0, 1, 2, ...., 10}
# 3. Zero value for ratings columns do not represent missing values

# In short, we do not know why they are missing. So, we can safely these 79 rows by risking
# losing 0.9429 % information

dating <- dating %>% filter( !is.na(importance_same_race  ))


# let's produce the missing value report again
giveMeMVReport(dating)

# Now we have 35 columns of missing values. Let's impute them

## 2.3  age, age_o, and d_age----
# Note that d_age stands for the age difference between age and age_o
# Let's explore d_age
summary(dating$d_age)

# This feature has no missin value. Let's check the rows
# where age is missing but age_o is not
dating %>% 
  select(age, age_o, d_age) %>%
  filter(is.na(age) & !is.na(age_o))

# The d_age is computed by assuming age is zero
# Therefore, d_age is misleading. The "non-missingness" is hence
# incorrect. How about the rows where age is not missing but age_o is?
dating %>% 
  select(age, age_o, d_age) %>%
  filter(!is.na(age) & is.na(age_o))

# How about both age and age_o are missing? Only one row
dating %>% 
  select(age, age_o, d_age) %>%
  filter(is.na(age) & is.na(age_o))

# In short, we cannot recover age and age_o from d_age which is computed
# by treating NA's as zeroes. We still can afford to remove these 135 problematic
# rows (1.6% of dataset). Ouch, but it is better to have biased information
dating <- dating %>% filter( !(is.na(age) | is.na(age_o) ) )

## 2.4  Dealing with columns with very few missing values ----
# Can we remove more NA's?
(N - nrow(dating))/N

# So far we have dropped 2.55% of the data, we still have some "room"
# as the rule of thumb is 5 %.
# Remark: N = number of rows before any NA removal 

0.024*N

# We can still afford another 2.45% (rounded down to 2.4%) of data
# to be removed. This is equivalent to around 200 rows.

# Let's check missing value report again
giveMeMVReport(dating) %>% 
  filter(numberOfNA < 200) %>%arrange(numberOfNA)

# even after removing NA's from these columns, we would have 14 columns
# which have missing values. We do not sacrifice too much by removing
# the columns above except attractive_partner and attractive_o which have 
# more than 100 NA's.

# Let's remove these columns sequentially
dating <- dating %>% 
  filter( !is.na(pref_o_shared_interests)) %>%
  filter( !is.na(funny_important)) %>%
  filter( !is.na(sincere) ) %>% 
  filter( !is.na(shared_interests_important))


nrow(dating); N

# we still gave 8060 rows down from 8378; 3.8 % rows removed.
# This is close to 5 % threshold, we can no longer afford to remove more rows
giveMeMVReport(dating)  %>% arrange(numberOfNA)

# We still have 16 columns to fix


## 2.5  Dealing with discrete columns with significant portion of missing values ----
# By "discrete", it means these columns fall in a discrete range of 0 to 10.

# Let's start with attractive_o (Rating by partner (about me) at night of event on attractiveness)
summary(dating$attractive_o)

# there is an erroneous row where max value of attractive_o is 10.5
# but the ratings can only fall in a discrete range between 0 to 10
dating %>% filter( attractive_o  > 10 ) %>% summarise(count = n())

# Only one row. Let's fix it
dating <- dating %>% mutate(attractive_o = ifelse(attractive_o == 10.5, 10, attractive_o))

# Is there any difference in match beween zero and missing attractive_o?
dating %>% filter(attractive_o == 0) %>%
  group_by(match) %>% summarise(count = n())

dating %>% filter(is.na(attractive_o)) %>%
  group_by(match) %>% summarise(count = n())

# If attractive_o is zero, there is no match
# If attractive_o is missing, there are only three matches out 175.
# For missing attractive_o which result in no match, we can
# impute them with zero. For missing attractive_o which result in
# matches, we can impute them with it with median of 6 (recall that
# rating is a discrete value; hence mean cannot be used).

dating <- dating %>% 
  mutate( attractive_o = ifelse( is.na(attractive_o) & match == 1, median(attractive_o, na.rm = TRUE),
                                 ifelse( is.na(attractive_o) & match == 0, 0, attractive_o))) 

# Can we apply the same idea on the following rating-by-partner features?
# 1. sinsere_o (it should be sincere_o)   
# 2. intelligence_o
# 3. funny_o 
# 4. ambitous_o
# 5. shared_interests_o
# 6. attractive_partner
# 7. sincere_partner
# 8. intelligence_partner 
# 9. funny_partner 
# 10.ambition_partner 
# 11.shared_interests_partner
# 12.like
# 13.guess_prob_liked

# sinsere_o 
summary(dating$sinsere_o)
dating %>% filter(sinsere_o == 0) %>%
  group_by(match) %>% summarise(count = n())

dating %>% filter(is.na(sinsere_o)) %>%
  group_by(match) %>% summarise(count = n())

# intelligence_o
summary(dating$intelligence_o)
dating %>% filter(intelligence_o == 0) %>%
  group_by(match) %>% summarise(count = n())

dating %>% filter(is.na(intelligence_o)) %>%
  group_by(match) %>% summarise(count = n())

# funny_o 
summary(dating$funny_o)
dating %>% filter(funny_o == 0) %>%
  group_by(match) %>% summarise(count = n())

dating %>% filter(is.na(funny_o )) %>%
  group_by(match) %>% summarise(count = n())

# ambitous_o
summary(dating$ambitous_o)
dating %>% filter(ambitous_o == 0) %>%
  group_by(match) %>% summarise(count = n())

dating %>% filter(is.na(ambitous_o)) %>%
  group_by(match) %>% summarise(count = n())

# shared_interests_o
summary(dating$shared_interests_o)
dating %>% filter(shared_interests_o == 0) %>%
  group_by(match) %>% summarise(count = n())

dating %>% filter(is.na(shared_interests_o)) %>%
  group_by(match) %>% summarise(count = n())

# attractive_partner
summary(dating$attractive_partner)
dating %>% filter(attractive_partner == 0) %>%
  group_by(match) %>% summarise(count = n())

dating %>% filter(is.na(shared_interests_o)) %>%
  group_by(match) %>% summarise(count = n())

# sincere_partner
summary(dating$sincere_partner)
dating %>% filter(sincere_partner == 0) %>%
  group_by(match) %>% summarise(count = n())

dating %>% filter(is.na(sincere_partner)) %>%
  group_by(match) %>% summarise(count = n())

# intelligence_partner 
summary(dating$intelligence_partner )
dating %>% filter(intelligence_partner  == 0) %>%
  group_by(match) %>% summarise(count = n())

dating %>% filter(is.na(intelligence_partner )) %>%
  group_by(match) %>% summarise(count = n())

# funny_partner
summary(dating$funny_partner )
dating %>% filter(funny_partner  == 0) %>%
  group_by(match) %>% summarise(count = n())

dating %>% filter(is.na(funny_partner )) %>%
  group_by(match) %>% summarise(count = n())

# ambition_partner
summary(dating$ambition_partner )
dating %>% filter(ambition_partner == 0) %>%
  group_by(match) %>% summarise(count = n())

dating %>% filter(is.na(ambition_partner )) %>%
  group_by(match) %>% summarise(count = n())

# shared_interests_partner
summary(dating$shared_interests_partner)
dating %>% filter(shared_interests_partner == 0) %>%
  group_by(match) %>% summarise(count = n())

dating %>% filter(is.na(shared_interests_partner )) %>%
  group_by(match) %>% summarise(count = n())

# like
summary(dating$like)
dating %>% filter(like == 0) %>%
  group_by(match) %>% summarise(count = n())

dating %>% filter(is.na(like)) %>%
  group_by(match) %>% summarise(count = n())

# guess_prob_liked
summary(dating$guess_prob_liked)
dating %>% filter(guess_prob_liked == 0) %>%
  group_by(match) %>% summarise(count = n())

dating %>% filter(is.na(guess_prob_liked)) %>%
  group_by(match) %>% summarise(count = n())

# Except shared_interest_o, sincere_o, sincere_partner, and guess_prob_liked,
# zero values result in no match in most of the columns
# For shared_interest_o and sincere_o, we can make the same assumption.
# This will introduce some bias, but in these columns, both have lower
# percentage of no match compared to overall proportion.
# 
# Therefore, we can impute missing values with zero and median 
# according to the target variables by introducing some biases. 
# 
# Also, we notice funny_o has a max value of 11, which needs correction
dating %>% filter(funny_o > 10) %>% summarise(count = n())

# Only one row. Let's fix it and impute with zero/median
dating <- dating %>% mutate( funny_o = ifelse( funny_o > 10, 10, funny_o))

# let's create a vector to represent these discrete columns
giveMeMVReport(dating)

# 1st to 11th, 13th and 14th giveMeMVReport(dating) correspond to these columns
discreteCol <- as.character( giveMeMVReport(dating)$colnames[c(1:11, 13:14)] )
discreteCol

# Impute missing values where match == 0
dating[dating$match == 0 , discreteCol] <- lapply(dating[dating$match == 0 , discreteCol], 
                                                  function(x){ x <- ifelse( is.na(x), 0, x )   } )

# Impute missing values where match == 1
dating[dating$match == 1 , discreteCol] <- lapply(dating[dating$match == 1 , discreteCol], 
                                                  function(x){ x <- ifelse( is.na(x), median(x, na.rm = TRUE), x )   } )

# Check the missing value report again
giveMeMVReport(dating)

## 2.6  Dealing remaining problematic columns----
### 2.6.1 expected_num_matches----
summary(dating$expected_num_matches)
dating %>% filter(expected_num_matches == 0) %>%
  group_by(match) %>% summarise(count = n())

dating %>% filter(is.na(expected_num_matches)) %>%
  group_by(match) %>% summarise(count = n())

# Compared to previous discrete columns, there is a significant
# portion of match for zero expected_num_matches. 
# Similar to expected_num_interested, we can redefine
# expected_num_matches as following:
# 1. "no match" when expected_num_matches = 0
# 2. 'no sure" when expected_num_matches is NA
# 3. 'maybe" when expected_num_matches > 0


dating <- dating %>% 
  mutate( expected_num_matches = ifelse( is.na(expected_num_matches), 'no sure',
                                         ifelse( expected_num_matches == 0, 'no match', 'maybe' )),
          expected_num_matches = factor(expected_num_matches ))

### 2.6.2 met ----
summary(dating$met)

# the data dictionary defines met == "Have you met your partner before?"
# It should be binary and hence it should be recorded as {0,1} 
# but there are some values of more than 1

# So how many rows that are not missing values, 0, or 1
dating %>% select(met) %>% filter(!(met %in% c(0,1)) & !is.na(met))

# 8 erroneous records. We can assume the user or the data entry had
# mistakened "met" as number of times the users met their partners. 
# So, they should be corrected as "1". Therefore, "met" boils down into
# {0, 1, NA}. We can define {0, 1, NA} as {"never met", "met before", "not sure"}

dating <- dating %>% 
  mutate( met = ifelse(is.na(met), 'not sure', ifelse(met >= 1, 'met before', 'never' )) ,
          met = factor(met))

# 3. Final verification ----
giveMeMVReport(dating)

# no more missng values!
summarizeColumns(dating)

# Note that some discrete values such as gaming record max value higher than 10
# This contradicts with the data dictionary. Let's fix them before we conclude missing value imputation
summarizeColumns(dating) %>% 
  filter(type == 'numeric', max > 10, max < 50)

# Are gaming and reading problematic?
unique(dating$gaming)
unique(dating$reading)

dating %>%  filter(gaming > 10 ) %>% summarise(count = n())
dating %>%  filter(reading > 10 ) %>%  summarise(count = n())

# There are quite a few number of errors. "In data dictionary, we trust". 
# So, it is better fix these errors by capping them at 10
dating <- dating %>%
  mutate( gaming  = ifelse( gaming  > 10, 10, gaming),
          reading = ifelse( reading > 10, 10, reading))

summarizeColumns(dating)

# We leave the discrete columns as "numeric" variable.
# Convert them to factor if necessary when applying learners.
#
# --------------------------------------- [END] -------------------------