Learning Objectives Assessed:

The final examination assesses the following Course Learning Objectives:

Critically reflect upon different data sources, types, formats and structures.
Apply data integration techniques to import and combine different sources of data.
Apply different data manipulation techniques to recode, filter, select, split, aggregate, and reshape the data into a format suitable for statistical analysis.
Justify data by detecting and handling missing values, outliers, inconsistencies and errors.
Demonstrate practical experience by having been exposed to real data problems.
Effectively use leading open source software for reproducible, automated data preprocessing.

# DATA PREPROCESSING


#0 Useful Libraries

```r
library(dplyr)
library(readr)
library(tidyr)
library(knitr)
```

## 1. Weird Syntax

`<-` assigns, like `=` normally does
`%>%` piping is the same as the . operator in OO languages

## Inspect functions

```r
str(something)
class(something)
typeof()
dim() # get dimensions
attributes()
length()
# or
something %>% class()
# using pipes, which is like .operator
```
