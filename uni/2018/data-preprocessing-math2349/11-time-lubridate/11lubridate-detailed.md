# Module 8 - long version

- The learning objectives of this module are as follows:
- Apply basic date-time manipulations using Base R functions
- Apply basic date-time manipulations using lubridate functions
- Learn basic string manipulations using Base R functions
- Learn basic string manipulations using stringr functions

## BaseR

### Getting current date and time
Base R has functions to get the current date and time. Also the lubridate package offers fast and user friendly parsing of date-time data. In this section I will use both Base R and lubridate functions to demonstrate date-time manipulations.
In order to get the current date and time information you can use


```r
# get time zone information
Sys.timezone()
## [1] "Australia/Melbourne"
# get date information
Sys.Date()
Sys.time()
## [1] "2018-06-15 22:21:02 AEST"


You may also get the same information using the lubridate functions:

```r
install.packages("lubridate")
library(lubridate)
# get current time using `lubridate`

now()
## [1] "2018-06-15 22:21:02 AEST"
```

## Converting strings to dates
When date and time data are imported into R they will often default to a character string (or factors if you are using  stringsAsFactors = FALSE option). If this is the case, we need to convert strings to proper date format.

To illustrate, let’s read in the candy production data which is available here candy_production.csv

```r
candy <- read.csv("data/candy_production.csv", stringsAsFactors = FALSE)

head(candy)
##   observation_date IPG3113N
## 1       1972-01-01  85.6945
## 2       1972-02-01  71.8200
## 3       1972-03-01  66.0229
## 4       1972-04-01  64.5645
## 5       1972-05-01  65.0100
## 6       1972-06-01  67.6467
# check the structure

str(candy$observation_date)
##  chr [1:548] "1972-01-01" "1972-02-01" "1972-03-01" "1972-04-01" ...
```

The observation_date variable was read in as a character. In order to convert this to a date format, we can use different strategies. First one is to convert using as.Date() function under Base R.

```r
candy$observation_date <- as.Date(candy$observation_date)

# check the structure

str(candy$observation_date)
##  Date[1:548], format: "1972-01-01" "1972-02-01" "1972-03-01" "1972-04-01" "1972-05-01" ...
```

Note that the default date format is YYYY-MM-DD; therefore, if your string is of different format you must incorporate the  format argument. There are multiple formats that dates can be in; for a complete list of formatting code options in R type  ?strftime in your console.

Have a look at these two examples:

```r
x <- c("08/03/2018", "23/03/2016", "30/01/2018")
y <- c("08.03.2018", "23.03.2016", "30.01.2018")
This time the string format is DD/MM/YYYY for x and DD.MM.YYYY for y; therefore, we need to specify the format argument explicitly.

x_date <- as.Date(x, format = "%d/%m/%Y")
x_date
## [1] "2018-03-08" "2016-03-23" "2018-01-30"
y_date <- as.Date(y, format = "%d.%m.%Y")
y_date
## [1] "2018-03-08" "2016-03-23" "2018-01-30"
```

The lubridate package on the other hand can automatically recognise the common separators used when recording dates (-, /, ., and ` `). As a result, you only need to focus on specifying the order of the date elements to determine the parsing function applied. Here is the list of lubridate functions used for this purpose:

Function	Order of elements in date-time
```r
ymd()	year, month, day
ydm()	year, day, month
mdy()	month, day, year
dmy()	day, month, year
hm()	hour, minute
hms()	hour, minute, second
ymd_hms()	year, month, day, hour, minute, second
If the strings are in different formats like the following, the lubridate functions can easily handle these.

z <- c("08.03.2018", "29062017", "23/03/2016", "30-01-2018")

z <- dmy(z)

z
## [1] "2018-03-08" "2017-06-29" "2016-03-23" "2018-01-30"
As seen above, even if we used different separators within the same vector, dmy() function was able to fetch this information easily.

Extract & manipulate parts of dates
Sometimes, instead of a single string, we will have the individual components of the date-time spread across multiple columns. Remember the flights data which is in the nycflights13 package.

library(nycflights13)
head(flights)
## # A tibble: 6 x 19
##    year month   day dep_time sched_dep_time dep_delay arr_time
##   <int> <int> <int>    <int>          <int>     <dbl>    <int>
## 1  2013     1     1      517            515         2      830
## 2  2013     1     1      533            529         4      850
## 3  2013     1     1      542            540         2      923
## 4  2013     1     1      544            545        -1     1004
## 5  2013     1     1      554            600        -6      812
## 6  2013     1     1      554            558        -4      740
## # ... with 12 more variables: sched_arr_time <int>, arr_delay <dbl>,
## #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>, dest <chr>,
## #   air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>,
## #   time_hour <dttm>
```

This data frame includes 19 variables, for date manipulations, we will use only the year, month, day, hour and  minute columns.

```r
flights_new <- flights %>%
dplyr::select(year, month, day, hour, minute)

head(flights_new)
## # A tibble: 6 x 5
##    year month   day  hour minute
##   <int> <int> <int> <dbl>  <dbl>
## 1  2013     1     1     5     15
## 2  2013     1     1     5     29
## 3  2013     1     1     5     40
## 4  2013     1     1     5     45
## 5  2013     1     1     6      0
## 6  2013     1     1     5     58
```

As seen in the output, the components of the date information is given in multiple columns. To create a date/time from this sort of input, we can use make_date() for dates and make_datetime() for date-times.

```r
flights_new<- flights_new %>% mutate(departure = make_datetime(year, month, day, hour, minute))

head(flights_new)
## # A tibble: 6 x 6
##    year month   day  hour minute departure
##   <int> <int> <int> <dbl>  <dbl> <dttm>
## 1  2013     1     1     5     15 2013-01-01 05:15:00
## 2  2013     1     1     5     29 2013-01-01 05:29:00
## 3  2013     1     1     5     40 2013-01-01 05:40:00
## 4  2013     1     1     5     45 2013-01-01 05:45:00
## 5  2013     1     1     6      0 2013-01-01 06:00:00
## 6  2013     1     1     5     58 2013-01-01 05:58:00
```

Now, let’s explore functions that let us get and set individual components of date and time.
We can extract individual parts of the date with the accessor functions in lubridate. Here is the list of available functions:

> Accessor Function	Extracts

```r
year()	year
month()	month
mday()	day of the month
yday()	day of the year
wday()	day of the week
hour()	hour
minute()	minute
second()	second
```


For example to extract the year information of the

```r
flights_new$departure column we can use:
flights_new$departure %>% year() %>% head()
## [1] 2013 2013 2013 2013 2013 2013
For month() and wday() we can set label = TRUE argument to return the abbreviated name of the month or day of the week. We can also set abbr = FALSE to return the full name:

flights_new$departure %>% month(label = TRUE, abbr = TRUE) %>% head()
## [1] Jan Jan Jan Jan Jan Jan
## 12 Levels: Jan < Feb < Mar < Apr < May < Jun < Jul < Aug < Sep < ... < Dec
flights_new$departure %>% month(label = TRUE, abbr = FALSE) %>% head()
## [1] January January January January January January
## 12 Levels: January < February < March < April < May < June < ... < December

We can also use each accessor function to set the components of a date/time:

```r
# create a date
datetime <- ymd_hms("2016-07-08 12:34:56")


#replace the year component with 2020
year(datetime) <- 2020

datetime
## [1] "2020-07-08 12:34:56 UTC"
# replace the month component with Jan
month(datetime) <- 01

datetime
## [1] "2020-01-08 12:34:56 UTC"
# add one hour

hour(datetime) <- hour(datetime) + 1

datetime
## [1] "2020-01-08 13:34:56 UTC"
```

## Date arithmetic
Often we may require to compute a new variable from the date - time information. In this section, you will learn to create a sequence of dates and how arithmetic with dates works (including subtraction, addition, and division)

For example, to create a sequence of dates we can use the seq() function with specifying the four arguments  seq(from, to, by, and length.out).

> create a sequence of years from 1980 to 2018 by 2

```r
even_years <- seq(from = 1980, to=2018, by = 2)
even_years
##  [1] 1980 1982 1984 1986 1988 1990 1992 1994 1996 1998 2000 2002 2004 2006
## [15] 2008 2010 2012 2014 2016 2018
```

This can be applied for days, months, minutes, seconds, etc.

```r
hour_list <- seq (ymd_hm("2018-1-1 9:00"), ymd_hm("2018-1-1 12:00"), by = "hour")

hour_list
## [1] "2018-01-01 09:00:00 UTC" "2018-01-01 10:00:00 UTC"
## [3] "2018-01-01 11:00:00 UTC" "2018-01-01 12:00:00 UTC"
month_list <- seq (ymd_hm("2018-1-1 9:00"), ymd_hm("2018-12-1 9:00"), by = "month")

month_list
##  [1] "2018-01-01 09:00:00 UTC" "2018-02-01 09:00:00 UTC"
##  [3] "2018-03-01 09:00:00 UTC" "2018-04-01 09:00:00 UTC"
##  [5] "2018-05-01 09:00:00 UTC" "2018-06-01 09:00:00 UTC"
##  [7] "2018-07-01 09:00:00 UTC" "2018-08-01 09:00:00 UTC"
##  [9] "2018-09-01 09:00:00 UTC" "2018-10-01 09:00:00 UTC"
## [11] "2018-11-01 09:00:00 UTC" "2018-12-01 09:00:00 UTC"

```

In R, when you subtract two dates, you get a time intervals/differences object (a.k.a difftime in R) . To illustrate let’s calculate my age using:


```r
my_age <- today() - ymd(19810529)
my_age
## Time difference of 13531 days
Or, equivalently we can use:

difftime(today(), ymd(19810529))
## Time difference of 13531 days
```

As seen in the output, subtraction of two date-time objects gives an object of time difference class. In order to change the time difference to another unit we can use units argument:

```r
difftime(today(), ymd(19810529), units = "weeks")
## Time difference of 1933 weeks
Logical comparisons are also available for date-time variables.

your_age <- today() - ymd(19890101)
your_age
## Time difference of 10757 days
your_age == my_age
## [1] FALSE
your_age < my_age
## [1] TRUE
```

We can also deal with time intervals/differences by using the duration functions in lubridate. Durations simply measure the time span between start and end dates. lubridate provides simplistic syntax to calculate durations with the desired measurement (seconds, minutes, hours, etc.).

It should be noted that the lubridate package uses seconds as the unit of calculation. Therefore, durations always record the time span in seconds. Larger units are created by converting minutes, hours, days, weeks, and years to seconds at the standard rate **(60 seconds in a minute, 60 minutes in an hour, 24 hours in day, 7 days in a week, 365 days in a year)**.

```r
# create a new duration (represented in seconds)
duration(1)
## [1] "1s"
# create durations for minutes
dminutes(1)
## [1] "60s (~1 minutes)"
# create durations for hours
dhours(1)
## [1] "3600s (~1 hours)"
# create durations for years
dyears(1)
## [1] "31536000s (~52.14 weeks)"
# add/subtract durations from date/time object
x <- ymd_hms("2015-09-22 12:00:00")
x + dhours(10)
## [1] "2015-09-22 22:00:00 UTC"
x + dhours(10) + dminutes(33) + dseconds(54)
## [1] "2015-09-22 22:33:54 UTC"
```

## Dealing with Characters/Strings
String/character manipulations are often overlooked in data analysis because the focus typically remains on numeric values. However, the growth in text mining resulted in greater emphasis on handling, cleaning and processing character strings. In the second part of this module I will give the foundation of working with characters by covering string manipulation with Base R and stringr and the set operations for character strings.

### Character string basics
This section includes how to create, convert and print character strings along with how to count the number of elements and characters in a string.

### Creating Strings
The most basic way to create strings is to use quotation marks and assign a string to an object similar to creating number sequences like this:

```r
a <- "MATH2349"    # create string a
b <- "is awesome"     # create string b
```

The paste() function under Base R is used for creating and building strings. It takes one or more R objects, converts them to character, and then it concatenates (pastes) them to form one or several character strings.

Here are some examples of paste() function:

```r
# paste together string a & b
paste(a, b)
## [1] "MATH2349 is awesome"
# paste character and number strings (converts numbers to character class)

paste("The life of", pi)
## [1] "The life of 3.14159265358979"
# paste multiple strings

paste("I", "love", "Data Preprocessing")
## [1] "I love Data Preprocessing"
# paste multiple strings with a separating character

paste("I", "love", "Data", "Preprocessing", sep = "-")
## [1] "I-love-Data-Preprocessing"
# use paste0() to paste without spaces between characters

paste0("I", "love",  "Data", "Preprocessing")
## [1] "IloveDataPreprocessing"
# paste objects with different lengths

paste("R", 1:5, sep = " v1.")
## [1] "R v1.1" "R v1.2" "R v1.3" "R v1.4" "R v1.5"
## [1] "R v1.1" "R v1.2" "R v1.3" "R v1.4" "R v1.5"
```

### Sorting character strings is very simple using using sort() function:

```r
a <- c("MATH2349", "MATH1324")
   
sort(a)
## [1] "MATH1324" "MATH2349"
```

### Converting to Strings
Similar to the numerics, strings and characters can be tested with is.character() and any other data format can be converted into strings/characters with as.character() or with toString().

```
a <- "The life of"
b <- pi

is.character(a)
## [1] TRUE
is.character(b)
## [1] FALSE
c <- as.character(b)
is.character(c)
## [1] TRUE
toString(c("Jul", 25, 2017))
## [1] "Jul, 25, 2017"
```

### Printing Strings
Printing strings/characters can be done with the following functions:

```r
Function | Usage ———|——- print() | generic printing noquote() | print with no quotes cat() | concatenate and print with no quotes
```

The primary printing function in R is print().

```
# basic printing

a <- "MATH2349 is awesome"

print(a)
## [1] "MATH2349 is awesome"
# print without quotes

print(a, quote = FALSE)
## [1] MATH2349 is awesome
# alternative to print without quotes

noquote(a)
## [1] MATH2349 is awesome
```

### Concatenating strings

The cat() function allows us to concatenate objects and print them either on screen or to a file. The output result is very similar to noquote(); however, cat() does not print the numeric line indicator. As a result, cat() can be useful for printing nicely formated responses to users.

```r
# basic printing (similar to noquote)
cat(a)
## MATH2349 is awesome
# combining character strings

cat(a, "and I love R")
## MATH2349 is awesome and I love R
# basic printing of alphabet

cat(letters)
## a b c d e f g h i j k l m n o p q r s t u v w x y z
# specify a seperator between the combined characters

cat(letters, sep = "-")
## a-b-c-d-e-f-g-h-i-j-k-l-m-n-o-p-q-r-s-t-u-v-w-x-y-z
# collapse the space between the combine characters

cat(letters, sep = "")
## abcdefghijklmnopqrstuvwxyz
```

You can also format the line width for printing long strings using the fill argument:

```r
x <- "Today I am learning how to manipulate strings."
y <- "Tomorrow I plan to work on my assignment."
z <- "The day after I will take a break and drink a beer :)"

# No breaks between lines

cat(x, y, z, fill = FALSE)
## Today I am learning how to manipulate strings. Tomorrow I plan to work on my assignment. The day after I will take a break and drink a beer :)
# Breaks between lines

cat(x, y, z, fill = TRUE)
## Today I am learning how to manipulate strings.
## Tomorrow I plan to work on my assignment.
## The day after I will take a break and drink a beer :)
```

### Counting string elements and characters
To count the number of elements in a string use length():

```r
length("How many elements are in this string?")
## [1] 1
length(c("How", "many", "elements", "are", "in", "this", "string?"))
## [1] 7
To count the number of characters in a string use nchar():

nchar("How many characters are in this string?")
## [1] 39
nchar(c("How", "many", "characters", "are", "in", "this", "string?"))
## [1]  3  4 10  3  2  4  7
```

### String manipulation with Base R

Basic string manipulation typically includes case conversion, simple character replacement, abbreviating, substring replacement, adding/removing whitespace, and performing set operations to compare similarities and differences between two character vectors.

These operations can all be performed with base R functions; however, some operations are greatly simplified with the  stringr package. Therefore, after illustrating base R string manipulation for case conversion, simple character replacement, abbreviating, and substring replacement, we will switch to stringr package to cover many of the other fundamental string manipulation tasks.

## Upper/lower case conversion

To convert all upper case characters to lower case we will use tolower():

```r
a <- "MATH2349 is AWesomE"

tolower(a)
## [1] "math2349 is awesome"
```

To convert all lower case characters to upper case we will use toupper():

```r
toupper(x)
## [1] "TODAY I AM LEARNING HOW TO MANIPULATE STRINGS."
```

### Simple Character Replacement
To replace a character (or multiple characters) in a string we can use chartr():

```r
# replace 'A' with 'a'
x <- "This is A string."
chartr(old = "A", new = "a", x)
## [1] "This is a string."
# multiple character replacements
# replace any 'd' with 't' and any 'z' with 'a'

y <- "Tomorrow I plzn do lezrn zbout dexduzl znzlysis."
chartr(old = "dz", new = "ta", y)
## [1] "Tomorrow I plan to learn about textual analysis."
```

Note that chartr() replaces every identified letter for replacement so you need to use it when you are certain that you want to change every possible occurence of that letter(s).

String Abbreviations
To abbreviate strings we can use abbreviate():

```rstreets <- c("Victoria", "Yarra", "Russell", "Williams", "Swanston")

# default abbreviations
abbreviate(streets)
## Victoria    Yarra  Russell Williams Swanston
##   "Vctr"   "Yarr"   "Rssl"   "Wllm"   "Swns"
# set minimum length of abbreviation
abbreviate(streets, minlength = 2)
## Victoria    Yarra  Russell Williams Swanston
##     "Vc"     "Yr"     "Rs"     "Wl"     "Sw"
```

Extract/Replace Substrings
To extract or replace substrings in a character vector there are two primary base R functions to use: substr() and  strsplit().

The purpose of substr() is to extract and replace substrings with specified starting and stopping characters. Here are some examples on substr() usage:

```r
alphabet <- paste(LETTERS, collapse = "")

alphabet
## [1] "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
# extract 18th character in alphabet
substr(alphabet, start = 18, stop = 18)
## [1] "R"
# extract 18-24th characters in alphabet
substr(alphabet, start = 18, stop = 24)
## [1] "RSTUVWX"
# replace 19-24th characters with `R`

substr(alphabet, start = 19, stop = 24) <- "RRRRRR"
alphabet
## [1] "ABCDEFGHIJKLMNOPQRRRRRRRYZ"
```

To split the elements of a character string we can use strsplit(). Here are some examples:

```r
z <- "The day after I will take a break and drink a beer :)"
strsplit(z, split = " ")
## [[1]]
##  [1] "The"   "day"   "after" "I"     "will"  "take"  "a"     "break"
##  [9] "and"   "drink" "a"     "beer"  ":)"
a <- "Victoria-Yarra-Russell-Williams-Swanston"
strsplit(a, split = "-")
## [[1]]
## [1] "Victoria" "Yarra"    "Russell"  "Williams" "Swanston"
```

Note that the output of strsplit() is a list. To convert the output to a simple atomic vector simply wrap in unlist():

```r
unlist(strsplit(a, split = "-"))
## [1] "Victoria" "Yarra"    "Russell"  "Williams" "Swanston"
```

### Set opperatons for character strings

There are also base R functions that allows for assessing the set union, intersection, difference, equality, and membership of two vectors.

To obtain the elements of the union between two character vectors we can use union():

```r
set_1 <- c("lagunitas", "bells", "dogfish", "summit", "odell")
set_2 <- c("sierra", "bells", "harpoon", "lagunitas", "founders")

union(set_1, set_2)
## [1] "lagunitas" "bells"     "dogfish"   "summit"    "odell"     "sierra"
## [7] "harpoon"   "founders"
```

To obtain the common elements of two character vectors we can use intersect().

```r
intersect(set_1, set_2)
## [1] "lagunitas" "bells"
```

In order to obtain the non-common elements, or the difference, of two character vectors we can use setdiff().

```
# returns elements in set_1 not in set_2
setdiff(set_1, set_2)
## [1] "dogfish" "summit"  "odell"
# returns elements in set_2 not in set_1
setdiff(set_2, set_1)
## [1] "sierra"   "harpoon"  "founders"
```

In order to test if two vectors contain the same elements regardless of order we can use setequal()

```
set_3 <- c("VIC", "NSW", "TAS")
set_4 <- c("WA", "SA", "NSW")
set_5 <- c("NSW", "SA", "WA")

setequal(set_3, set_4)
## [1] FALSE
setequal(set_4, set_5)
## [1] TRUE
```

We can use identical() to test if two character vectors are equal in content and order.

```
set_6 <- c("VIC", "NSW", "TAS")
set_7 <- c("NSW", "VIC", "TAS")
set_8 <- c("VIC", "NSW", "TAS")

identical(set_6, set_7)
## [1] FALSE
identical(set_6, set_8)
## [1] TRUE
```

In order to test if an element is contained within a character vector use is.element() or %in%. Here are some examples:

```
set_6 <- c("VIC", "NSW", "TAS")
set_7 <- c("NSW", "VIC", "TAS")
set_8 <- c("VIC", "NSW", "TAS")

is.element("VIC", set_8)
## [1] TRUE
"VIC" %in% set_8
## [1] TRUE
"WA" %in% set_8
## [1] FALSE
```

### String manipulation with stringr

The stringr package was developed by Hadley Wickham to provide a consistent and simple wrappers to common string operations. Before using these functions, we need to install and load the stringr package.

```
install.packages("stringr")
library(stringr)
```

Basic operations
There are three string functions that are closely related to their base R equivalents, but with a few enhancements. They are:

```r
Concatenate with str_c()
Number of characters with str_length()
Substring with str_sub()
str_c() is equivalent to the paste() function in Base R.

# same as paste0()

str_c("Learning", "to", "use", "the", "stringr", "package")
## [1] "Learningtousethestringrpackage"
# same as paste()

str_c("Learning", "to", "use", "the", "stringr", "package", sep = " ")
## [1] "Learning to use the stringr package"
str_length() is similiar to the nchar() function; however, str_length() behaves more appropriately with missing  NA values:

# some text with NA
text = c("Learning", "to", NA, "use", "the", NA, "stringr", "package")

# compare `str_length()` with `nchar()`
nchar(text)
## [1]  8  2 NA  3  3 NA  7  7
str_length(text)
## [1]  8  2 NA  3  3 NA  7  7
```

As seen above, str_length() function returns NA for the missing values, where else, nchar() counts the number of characters in NA and returns 2 as a value.

### Duplicate Characters within a String
The stringr provides a new functionality using str_dup() in which base R does not have a specific function for is character duplication.

```r
str_dup("apples", times = 4)
## [1] "applesapplesapplesapples"
str_dup("apples", times = 1:4)
## [1] "apples"                   "applesapples"
## [3] "applesapplesapples"       "applesapplesapplesapples"
```r

### Remove Leading and Trailing Whitespace
In string processing, a common task is parsing text into individual words. Often, this results in words having blank spaces (whitespaces) on either end of the word. The str_trim() can be used to remove these spaces. Here are some examples:

```r
text <- c("Text ", "  with", " whitespace ", " on", "both ", " sides ")
text
## [1] "Text "        "  with"       " whitespace " " on"
## [5] "both "        " sides "
# remove whitespaces on the left side
str_trim(text, side = "left")
## [1] "Text "       "with"        "whitespace " "on"          "both "
## [6] "sides "
# remove whitespaces on the right side
str_trim(text, side = "right")
## [1] "Text"        "  with"      " whitespace" " on"         "both"
## [6] " sides"
# remove whitespaces on both sides
str_trim(text, side = "both")
## [1] "Text"       "with"       "whitespace" "on"         "both"
## [6] "sides"
```

### Pad a String with Whitespace
To add whitespace, or to pad a string, we will use str_pad(). We can also use str_pad() to pad a string with specified characters. The width argument will give width of padded strings and the pad argument will specify the padding characters. Here are some examples:

```r
str_pad("apples", width = 10, side = "left")
## [1] "    apples"
str_pad("apples", width = 10, side = "both")
## [1] "  apples  "
str_pad("apples", width = 10, side = "right", pad = "!")
## [1] "apples!!!!"
```

### Additional Resources and Further Reading
For more information on lubridate and stringr packages and available functions, you can refer to the lubridate package manual and the stringr package manual.

Our recommended textbooks (Boehmke (2016) and Wickham and Grolemund (2016)) are great resources for the basics of date and character manipulations. If you want to learn more on the high level text manipulations and text mining, you may refer to “Automated Data Collection with R: A practical guide to web scraping and text mining” (by Munzert et al. (2014)).

References
Boehmke, Bradley C. 2016. Data Wrangling with R. Springer.

Munzert, Simon, Christian Rubba, Peter Meißner, and Dominic Nyhuis. 2014. Automated Data Collection with R: A Practical Guide to Web Scraping and Text Mining. John Wiley & Sons.

Wickham, Hadley, and Garrett Grolemund. 2016. R for Data Science: Import, Tidy, Transform, Visualize, and Model Data. “ O’Reilly Media, Inc.”
