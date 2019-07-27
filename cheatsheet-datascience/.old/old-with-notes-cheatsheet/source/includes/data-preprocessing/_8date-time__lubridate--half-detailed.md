# Module 8 - long version

- The learning objectives of this module are as follows:
- Apply basic date-time manipulations using Base R functions
- Apply basic date-time manipulations using lubridate functions
- Learn basic string manipulations using Base R functions
- Learn basic string manipulations using stringr functions

# 8.0 BaseR

## Getting current date and time
Base R has functions to get the current date and time. Also the lubridate package offers fast and user friendly parsing of date-time data. In this section I will use both Base R and lubridate functions to demonstrate date-time manipulations.

In order to get the current date and time information you can use:

```r
# get time zone information
Sys.timezone()
## [1] "Australia/Melbourne"
# get date information
Sys.Date()
Sys.time()
## [1] "2018-06-15 22:21:02 AEST"
```

# 8.1 Lubridate

```r
install.packages("lubridate")
library(lubridate)
```

> get current time using `lubridate`

```
now()
## [1] "2018-06-15 22:21:02 AEST"
```

You may also get the same information using the lubridate functions:

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
## BaseR - Converting strings to dates
When date and time data are imported into R they will often default to a character string (or factors if you are using  `stringsAsFactors = FALSE` option). If this is the case, we need to convert strings to proper date format.

To illustrate, let’s read in the candy production data which is available here `candy_production.csv`


```r
candy$observation_date <- as.Date(candy$observation_date)
# check the structure

str(candy$observation_date)
##  Date[1:548], format: "1972-01-01" "1972-02-01" "1972-03-01" "1972-04-01" "1972-05-01" ...
```
The observation_date variable was read in as a character. In order to convert this to a date format, we can use different strategies. First one is to convert using as.Date() function under Base R.

Note that the default date format is `YYYY-MM-DD`; therefore, if your string is of different format you must incorporate the format argument. There are multiple formats that dates can be in; for a complete list of formatting code options in R type `?strftime` in your console.

> For example:

```r
x <- c("08/03/2018", "23/03/2016", "30/01/2018")
y <- c("08.03.2018", "23.03.2016", "30.01.2018")
```

> This time the string format is `DD/MM/YYYY` for x and `DD.MM.YYYY` for y; therefore, we need to specify the format argument explicitly.

```r
x_date <- as.Date(x, format = "%d/%m/%Y")
x_date
## [1] "2018-03-08" "2016-03-23" "2018-01-30"
y_date <- as.Date(y, format = "%d.%m.%Y")
y_date
## [1] "2018-03-08" "2016-03-23" "2018-01-30"
```

## Lubridate package

The lubridate package on the other hand can automatically recognise the common separators used when recording dates (-, /, ., and ` `). As a result, you only need to focus on specifying the order of the date elements to determine the parsing function applied. Here is the list of lubridate functions used for this purpose:

> Function vs Order of elements in date-time

```r
ymd() #	year, month, day
ydm() #	year, day, month
mdy() #	month, day, year
dmy() #	day, month, year
hm() #	hour, minute
hms() #	hour, minute, second
ymd_hms() #	year, month, day, hour, minute, second
```

> If the strings are in different formats like the following, the lubridate functions can easily handle these.

```r
z <- c("08.03.2018", "29062017", "23/03/2016", "30-01-2018")
dmy(z)
## [1] "2018-03-08" "2017-06-29" "2016-03-23" "2018-01-30"
```

> Even with different separators within the same vector, `dmy()` function was able to fetch this information easily.

## Extract & manipulate parts of dates
Sometimes, instead of a single string, we will have the individual components of the date-time spread across multiple columns.

> selecting just date and time

```r
library(nycflights13)
flights_new <- flights %>%
dplyr::select(year, month, day, hour, minute)

head(flights_new, 1)
## # A tibble: 6 x 5
##    year month   day  hour minute
##   <int> <int> <int> <dbl>  <dbl>
## 1  2013     1     1     5     15

```

>  The date is given in multiple columns

> To create a date/time from this sort of input, we can use `make_date()` for dates and `make_datetime()` for date-times.

```r
flights_new <- flights_new %>%
  mutate(departure =
    make_datetime(year, month, day, hour, minute))

head(flights_new, 1)
## # A tibble: 6 x 6
##    year month   day  hour minute departure
##   <int> <int> <int> <dbl>  <dbl> <dttm>
## 1  2013     1     1     5     15 2013-01-01 05:15:00
```

Now, let’s explore functions that let us get and set individual components of date and time.
We can extract individual parts of the date with the accessor functions in lubridate. Here is the list of available functions:

## Accessor Function	Extracts

|  |  |
| --- | --- |
| `year()` | year |
| `month()` | month |
| `mday()` | day of the month |
| `yday()` | day of the year |
| `wday()` | day of the week |
| `hour()` | hour |
| `minute()` | minute |
| `second()` | second |

Eg. to extract the year information of the `flights_new$departure` column we can use:

```r
flights_new$departure %>% year() %>% head()
## [1] 2013 2013 2013 2013 2013 2013
```

For `month()` and `wday()` we can set `label = TRUE` argument to return the abbreviated name of the month or day of the week.

We can also set `abbr = FALSE` to return the full name:

```r
flights_new$departure %>% month(label = TRUE, abbr = TRUE) %>% head()
## [1] Jan Jan Jan Jan Jan Jan
## 12 Levels: Jan < Feb < Mar < Apr < May < Jun < Jul < Aug < Sep < ... < Dec
flights_new$departure %>% month(label = TRUE, abbr = FALSE) %>% head()
## [1] January January January January January January
## 12 Levels: January < February < March < April < May < June < ... < December
```

## Set date/time
We can also use each accessor function to set the components of a date/time:

> create a date

```r
datetime <- ymd_hms("2016-07-08 12:34:56")
```

> replace the year component with 2020

```r
year(datetime) <- 2020
datetime
## [1] "2020-07-08 12:34:56 UTC"
```

> replace the month component with Jan

```r
month(datetime) <- 01
datetime
## [1] "2020-01-08 12:34:56 UTC"
```

> add one hour

```r
hour(datetime) <- hour(datetime) + 1
datetime
## [1] "2020-01-08 13:34:56 UTC"
```

## Date arithmetic
Often we may require to compute a new variable from the date - time information. In this section, you will learn to create a sequence of dates and how arithmetic with dates works (including subtraction, addition, and division)

For example, to create a sequence of dates we can use the seq() function with specifying the four arguments  seq(from, to, by, and length.out).

## `seq()`

create a sequence of years from 1980 to 2018 by 2

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
## `difftime()`
In R, when you subtract two dates, you get a time intervals/differences object (a.k.a `difftime()` in R) . To illustrate let’s calculate my age using:

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

## `duration()`
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
