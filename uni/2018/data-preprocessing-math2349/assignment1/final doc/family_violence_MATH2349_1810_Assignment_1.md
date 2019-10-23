---
title: "MATH2349 Semester 1, 2018"
author: "Phil Steinke s3725547@student.rmit.edu.au"
subtitle: "Assignment 1 - Victorian family violence cases 2012-2017"
output:
  html_notebook: default
---

## Setup

Install and load the necessary packages to reproduce the report here:

```{r, echo = FALSE, warnings = FALSE}

library(readr) # Useful for importing data
library(foreign) # Useful for importing SPSS, SAS, STATA etc. data files
library(rvest) # Useful for scraping HTML data
library(knitr) # Useful for creating nice tables
library(forcats)
library(mosaic)
library(readxl)
library(rmarkdown)
library("miceadds", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")
library("plotly")


```

## Data Description

**A clear description of data and its source should be provided in this section.**

"Victims Support Agency Data Tables- 2016-17.xlsx"
Table 2. Number of VAP family violence cases initiated for new clients by client gender and age group, July 2012 to June 2017

Source: [https://www.crimestatistics.vic.gov.au/sites/default/files/embridge_cache/emshare/original/public/2017/12/74/906ab3fb8/Victims%20Support%20Agency%20Data%20Tables-%202016-17.xlsx](https://www.crimestatistics.vic.gov.au/sites/default/files/embridge_cache/emshare/original/public/2017/12/74/906ab3fb8/Victims%20Support%20Agency%20Data%20Tables-%202016-17.xlsx)

As a minimum, your data set should include:
* one numeric variable = number of family violence cases
* one qualitative (categorical) variable = Age Range

## Read/Import Data

```{r}

# This is an R chunk for importing the data. Provide your R codes here:
rm(list=ls())
setwd('../../datasets/')

# Read/Import the data into R, then save it as a data frame.

family_violence <-
  read_excel(
    "Victims Support Agency Data Tables- 2016-17.xlsx",
    sheet = "Table 2",
    range = cell_rows(12:58)
  ) %>%
  data.frame()

# woud not let me set `stringsAsFactors = FALSE`

class(family_violence) # -> family violence is a "data.frame"

# You must also provide the R codes with outputs
# (i.e. `head()` of the data set) that you used to import/read/scrape the data set:

head(family_violence)

```

## Inspect and Understand

Inspect the data frame and variables using R functions. As a minimum, you should:

* check the dimensions of the data frame.
* check the data types (i.e., character, numeric, integer, factor, and logical) of the variables in the data set.
* check the levels of factor variables, rename/rearrange them if required.
* check the column names in the data frame, rename them if required.

## * check the dimensions of the data frame.
```{r}
dim(family_violence)
# OR
nrow(family_violence)
ncol(family_violence)

# check the attributes in the data.
attributes(family_violence)

```
- It has 46 rows and 7 columns
- It's names are X__1, ...
- It's row names are numbers 1,2,3...
- It's a data.frame

## check the data types (i.e., character, numeric, integer, factor, and logical) of the variables in the data set.

```{r}

class(family_violence) # -> family_violence is a data.frame

head(family_violence[,1]) #  [1] "Gender and age group" "Male" NA NA ...          
class(family_violence[,1]) # ->  is a character

head(family_violence[,2]) # [1] NA             "0 - 4"        "5 - 9"        "10 - 14"      "15 - 19"      "20 - 24"
class(family_violence[,2]) # -> is a character

head(family_violence[,3]) #  [1] "2012-13" "74"      "84"      "72"      "52"      "64"      "62"         
class(family_violence[,3])# ->  is a character

head(family_violence[,4]) #  [1] "2013-14" "61"      "121"     "80"      "70"      "47"      "60"          
class(family_violence[,4])  # ->  is a character

head(family_violence[,5]) #  [1] "2013-14" "61"      "121"     "80"      "70"      "47"      "60"          
class(family_violence[,5])  # ->  is a character

head(family_violence[,6]) # "2015-16" "41"      "107"     "88"      "74"      "95"     
class(family_violence[,6])  # ->  is a character

```

- Everything is treated as a character because of the column titles are included in the spreadsheet

### check the levels of factor variables

```{r}
# family_violence[1,] # column names for reference

cat("Gender Col levels:\n")
levels_gender <-
  c(family_violence[,1]) %>%
  factor(ordered= TRUE) %>%
  levels() %>%
  print()

cat("\nAge Range levels:\n")
factor_age_range <-
  c(family_violence[,2]) %>%
  factor(ordered= TRUE) %>%
  levels() %>%
  print()

cat("\nLevels for all year cols from 2012-17\n")
levels_all_years <-
c(family_violence[,3],
  family_violence[,4],
  family_violence[,5],
  family_violence[,6],
  family_violence[,7]
) %>%
  factor() %>%
  levels() %>%
  print()

cat("\nLevels for one year col from 2012-13 in case you needed that: \n")
levels_2012_13 <-
  c(family_violence[,3]) %>%
  factor(ordered= TRUE) %>%
  levels() %>%
  print()

```

# * check the column names in the data frame, rename them if required.

```{r}
# check the column names in the data frame
colnames(family_violence)

```

```{r}
# rename them if required.
colnames(family_violence) <- c("Gender", "Age Range", c(family_violence[1,3:7]))

#The excel doesn't include Male/Female accross all of the fields, so here I've filled them in:
family_violence[c(3:16),1] <- "Male"
family_violence[c(18:31),1] <- "Female"

# Removing the empty rows and rows with totals in them
family_violence <- family_violence[-c(1, 16, 31:46), ]

# Fixing the Row numbering
rownames(family_violence) <- c(1:length(family_violence$`Gender`))
family_violence

```

```{r}
class(family_violence) # -> family_violence is a data.frame
family_violence[1, 'Age Range'] # -> "0 - 4"
class(family_violence[3, 'Age Range']) # -> "Age Range" is a character
family_violence[3, '2012-13']
class(family_violence[3, '2012-13']) # -> "Year" is a character
family_violence[1, 4]
class(family_violence[1, 4]) # -> "Gender" and N/A is a character

```


```{r}
# fixing the data types: rename/rearrange if required

cat("Setting each year's data to integers\n")
class(family_violence[3:7])
family_violence[3:7] <- Map(as.integer, family_violence[3:7])

Map(is.integer, family_violence[3:7])

# Previous code that seemed cumbersome:
#class(family_violence$`2012-13`)
family_violence$`2012-13` %>%
  as.integer() -> family_violence$`2012-13`
#class(family_violence$`2012-13`)
```

# New data types
```{r}
cat("New data types\n")
class(family_violence) # -> family_violence is a data.frame
cat("Age Range\n")
family_violence[1, 'Age Range'] # -> "0 - 4"
class(family_violence[3, 'Age Range']) # -> "Age Range" is a character
cat("Year col 2012-13\n")
family_violence$'2012-13'
class(family_violence$'2012-13') # -> All Year cols are now an integer
cat("single value from a year column 2012-13\n")
family_violence[1, 5]
class(family_violence[1, 4]) # -> Grabbing a single value from a year col which is now an integer

```

## Subsetting I

Subset the data frame using first 10 observations (include all variables). Then convert it to a matrix.

```{r}

# This is a chunk to subset your data and convert it to a matrix
# Provide the R codes with outputs and explain everything that you do in this step.

# Subset the data frame using first 10 observations (include all variables)

# What are all variables?
names(family_violence) -> all_variables
all_variables

# I assume you mean this because all_variables
data_frame_subset <- family_violence[1:10,]
data_frame_subset
# or this if you just wanted a matrix of integers:
# family_violence[1:10,3:7]
# or this, but I doubt it
# family_violence[1:2,3:7]

# Then convert it to a matrix

data_frame_subset %>%
  as.matrix(
  ) %>%
  print()

```

Do not forget to explain why you got this error.
- I didn't get an error

## Subsetting II

Subset the data frame including only first and the last variable in the data set, save it as an R object file (.RData). Provide the R codes with outputs and explain everything that you do in this step.

```{r}
## Subset the data frame including only first and the last variable in the data set

# I didn't understand what 'variables' referred to in this context so I thought I'd start by getting them:
names(family_violence) -> all_variables
all_variables
```

This function works
I used `length(family_violence)`
because it's possible to grab the last variables in a vector the following way:
[How to access the last value in a vector?](https://stackoverflow.com/a/37238415/3281978)

```{r}
first_and_last_subset <-
  subset(
    family_violence,
    select = c(1, length(family_violence)))
class(first_and_last_subset)
```

Then I piped the same code:

```{r}

family_violence %>%
  subset (
    select = c(
      1,
      length(family_violence)
    )
  ) -> first_and_last_subset

first_and_last_subset

```

And just for good measure, I also checked:

`head(family_violence,n=1)
tail(family_violence,n=1)`


## This didn't work:
```{r}

## save it as an R object file (.RData).

save.image() # Saving the workspace

first_and_last_subset

save(first_and_last_subset, file = "data/first_and_last_subset.Rdata")
rm(first_and_last_subset)
testing_save_worked <- load("data/first_and_last_subset.Rdata")
testing_save_worked

?save

testing_save_worked

identical(first_and_last_subset, testing_save_worked) # FALSE

```

hmm, I keep getting this random problem with saving as RData

```{R}

# Random data.frame
foo_dataframe <- data.frame(runif(10), runif(10), runif(10))
save(foo_dataframe, file = "data/foo.RData")
bar <- load(file = "data/foo.RData")
identical(foo_dataframe, bar) # [1] FALSE

foo_matrix <- matrix(runif(10))
attributes(foo_matrix)
save(foo_matrix, file = "data/foo_matrix.RData")
bar_matrix <- load(file = "data/foo_matrix.RData")
attributes(bar_matrix)
identical(foo_matrix, bar_matrix) # [1] FALSE
help(load)
# Got it working with readRDS
saveRDS(foo_dataframe, file = "data/foo.rds")
bar <- readRDS("data/foo.rds")
identical(foo_dataframe, bar) # TRUE

unlink(".RData")

```

```{r}

# lets try load.Rdata2 from miceadds

save.Rdata(first_and_last_subset, "data/first_and_last_subset.RData")

testing_save_worked <- load.Rdata2(filename = "data/first_and_last_subset.RData", path=getwd())

identical(first_and_last_subset, testing_save_worked) # [1] TRUE

```


## IMPORTANT NOTE:

This report must be uploaded to Turnitin as a PDF with your code chunks showing. The easiest way to achieve this is to Preview your notebook in HTML (by clicking Preview) → Open in Browser (Chrome) → Right click on the report in Chrome → Click Print and Select the Destination Option to Save as PDF.

```{r}

# p <- plot_ly(family_violence, x = , y =  type = "bar")

p <- plot_ly(x = c(1, 2), y = c(1, 2))
api_create(p, filename = "test")
p

p <- plot_ly (
      x = family_violence$`Age Range`,
      y = "family_violence[3]",
      type = "bar",
      mode = "markers" )
p

# api_create(p, filename = "name-of-my-plotly-file") save-online
# Cheatsheet https://images.plot.ly/plotly-documentation/images/r_cheat_sheet.pdf
# reference https://plot.ly/r/reference/

```

<br>
<br>
