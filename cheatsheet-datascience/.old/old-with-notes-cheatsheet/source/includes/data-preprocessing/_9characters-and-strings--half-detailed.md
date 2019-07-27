# 9.1 Strings and Characters

String/character manipulations are often overlooked in data analysis because the focus typically remains on numeric values. However, the growth in text mining resulted in greater emphasis on handling, cleaning and processing character strings.

This section includes:

- how to create, convert and print character strings
- how to count the number of elements and characters in a string.

## Creating Strings
The most basic way to create strings is to use quotation marks and assign a string to an object similar to creating number sequences like this:

```r
a <- "MATH2349"    # create string a
b <- "is awesome"     # create string b
```

## `paste()` creating and building strings.

It takes one or more R objects, converts them to character, and then it concatenates (pastes) them to form one or several character strings.

```r

# paste multiple strings with a separating character
c <- "Preprocessing"
paste("I", "love", "Data", c, sep = "-")
## [1] "I-love-Data-Preprocessing"

# use paste0() to paste without spaces between characters
paste0("I", "love",  "Data", "Preprocessing")
## [1] "IloveDataPreprocessing"
# paste objects with different lengths

paste("R", 1:5, sep = " v1.")
## [1] "R v1.1" "R v1.2" "R v1.3" "R v1.4" "R v1.5"
## [1] "R v1.1" "R v1.2" "R v1.3" "R v1.4" "R v1.5"
```

## `sort()` Sorting character strings:

```r
a <- c("MATH2349", "MATH1324")
   
sort(a)
## [1] "MATH1324" "MATH2349"
```

## `toString()` Converting to Strings
Similar to the numerics, strings and characters can be tested with is.character() and any other data format can be converted into strings/characters with as.character() or with toString().

```r
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

## `print()` - Printing Strings
Printing strings/characters can be done with the following functions:

| Function | Usage |
| --- | --- |
| `print()` | generic printing |
| `noquote()` | print with no quotes |
| `cat()` | concatenate and print with no quotes |

The primary printing function in R is `print()`.

```r
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

## `cat()` Concatenating strings

The `cat()` function allows us to concatenate objects and print them either on screen or to a file. The output result is very similar to `noquote()`; however, cat() does not print the numeric line indicator. As a result, `cat()` can be useful for printing nicely formatted responses to users.

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

## `length()` Counting string elements and characters
To count the number of elements in a string use `length()`:

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

# 9.2 String manipulation with Base R

Basic string manipulation typically includes:

#### Base:

- case conversion
- simple character replacement
- abbreviating
- substring replacement

#### Stringr:

- adding/removing whitespace
- and performing set operations to compare similarities and differences between two character vectors.

These operations can all be performed with base R functions; however, some operations are greatly simplified with the `stringr` package.

## `toupper()` and `tolower()` case conversion

`tolower()` - To convert all upper case characters to lower case:

```r
a <- "MATH2349 is AWesomE"

tolower(a)
## [1] "math2349 is awesome"
```

`toupper()` - To convert all lower case characters to upper case:

```r
toupper(x)
## [1] "TODAY I AM LEARNING HOW TO MANIPULATE STRINGS."
```

## `chartr()` Simple Character Replacement
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

## `abbreviate()` String Abbreviations
To abbreviate strings we can use abbreviate():

```r
streets <- c("Victoria", "Yarra", "Russell", "Williams", "Swanston")

# default abbreviations
abbreviate(streets)
## Victoria    Yarra  Russell Williams Swanston
##   "Vctr"   "Yarr"   "Rssl"   "Wllm"   "Swns"
# set minimum length of abbreviation
abbreviate(streets, minlength = 2)
## Victoria    Yarra  Russell Williams Swanston
##     "Vc"     "Yr"     "Rs"     "Wl"     "Sw"
```

## `substr()` Extract/Replace Substrings

To extract or replace substrings in a character vector there are two primary base R functions to use: `substr()` and  `strsplit()`.

The purpose of `substr()` is to extract and replace substrings with specified starting and stopping characters. Here are some examples on `substr()` usage:

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

## `strsplit()`

To split the elements of a character string we can use `strsplit()`. Here are some examples:

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

Note that the output of `strsplit()` is a list.

## `unlist()`

To convert the output to a simple atomic vector simply wrap in `unlist()`:

```r
unlist(strsplit(a, split = "-"))
## [1] "Victoria" "Yarra"    "Russell"  "Williams" "Swanston"
```

# 9.3 `Vector` operations Set operations for character strings

There are also base R functions that allows for assessing the set union, intersection, difference, equality, and membership of two vectors.

## `union()`
To obtain the elements of the union between two character vectors we can use `union()`:

```r
set_1 <- c("lagunitas", "bells", "dogfish", "summit", "odell")
set_2 <- c("sierra", "bells", "harpoon", "lagunitas", "founders")

union(set_1, set_2)
## [1] "lagunitas" "bells"     "dogfish"   "summit"    "odell"     "sierra"
## [7] "harpoon"   "founders"
```

## `intersect()`
To obtain the common elements of two character vectors we can use intersect().

```r
intersect(set_1, set_2)
## [1] "lagunitas" "bells"
```

## `setdiff()`
In order to obtain the non-common elements, or the difference, of two character vectors we can use setdiff().

```r
# returns elements in set_1 not in set_2
setdiff(set_1, set_2)
## [1] "dogfish" "summit"  "odell"
# returns elements in set_2 not in set_1
setdiff(set_2, set_1)
## [1] "sierra"   "harpoon"  "founders"
```

## `setequal()`
In order to test if two vectors contain the same elements regardless of order we can use setequal()

```r
set_3 <- c("VIC", "NSW", "TAS")
set_4 <- c("WA", "SA", "NSW")
set_5 <- c("NSW", "SA", "WA")

setequal(set_3, set_4)
## [1] FALSE
setequal(set_4, set_5)
## [1] TRUE
```

## `identical()`
We can use identical() to test if two character vectors are equal in content and order.

```r
set_6 <- c("VIC", "NSW", "TAS")
set_7 <- c("NSW", "VIC", "TAS")
set_8 <- c("VIC", "NSW", "TAS")

identical(set_6, set_7)
## [1] FALSE
identical(set_6, set_8)
## [1] TRUE
```

## `is.element()`
In order to test if an element is contained within a character vector use `is.element()` or `%in%`. Here are some examples:

```r
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

# 9.4 `stringr` String manipulation

The stringr package was developed by Hadley Wickham to provide a consistent and simple wrappers to common string operations. Before using these functions, we need to install and load the stringr package.

```r
install.packages("stringr")
library(stringr)
```

There are three string functions that are closely related to their base R equivalents, but with a few enhancements.

They are:

- Concatenate with `str_c()`
- Number of characters with `str_length()`
- Substring with `str_sub()`

## `str_c()`
```r
str_c() is equivalent to the paste() function in Base R.

# same as paste0()

str_c("Learning", "to", "use", "the", "stringr", "package")
## [1] "Learningtousethestringrpackage"
# same as paste()

str_c("Learning", "to", "use", "the", "stringr", "package", sep = " ")
## [1] "Learning to use the stringr package"
```

## `str_length()`
```r
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

## `str_dup()` Duplicate Characters within a String
The stringr provides a new functionality using str_dup() in which base R does not have a specific function for is character duplication.

```r
str_dup("apples", times = 4)
## [1] "applesapplesapplesapples"
str_dup("apples", times = 1:4)
## [1] "apples"                   "applesapples"
## [3] "applesapplesapples"       "applesapplesapplesapples"
```

## `str_trim()` Remove Leading and Trailing Whitespace
In string processing, a common task is parsing text into individual words. Often, this results in words having blank spaces (whitespaces) on either end of the word. The `str_trim()` can be used to remove these spaces. Here are some examples:

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

## `str_pad()` - Pad a String with Whitespace
To add whitespace, or to pad a string, we will use `str_pad()`. We can also use `str_pad()` to pad a string with specified characters. The width argument will give width of padded strings and the pad argument will specify the padding characters. Here are some examples:

```r
str_pad("apples", width = 10, side = "left")
## [1] "    apples"
str_pad("apples", width = 10, side = "both")
## [1] "  apples  "
str_pad("apples", width = 10, side = "right", pad = "!")
## [1] "apples!!!!"
```
