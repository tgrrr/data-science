---
title: "Data structures in R"
---

# Data structures in R

```{r}

var_integer_example <- c(1L, 2L, 3L)
class(var_integer_example)

var_class_example <- c(1,2,3)
class(var_class_example)
# defaults to numeric without integer


var_factor <- factor( c('male', 'female', 'male', 'male')   )
var_factor

class(var_factor)

# interested in
# factor_scope <- factor.scope(factor = var_factor, scope = )


```

```{r}
ex4[1:3]

```


```{r}
#library(dplyr)
#library(readr)
#library(tidyr)
#library(knitr)
```

1. Use command c() to create vectors as listed below and check their class as you go. For factor class, check it’s levels and label it.

```{r}

# i) Integers from 1 to 5 and name it vect_int.

vect_int <- c(1:5)

vect_int
class(vect_int)

# ii) Double numeric variables from 0.5 to 3.5 incrementing it 1, and name it vect_dbl.

vect_dbl <- c(0.5:3.5)

class(vect_dbl)

# iii) Character variables using name of the colours red, green, blue, yellow, white and name it vect_char.

vect_char <- c("red", "green", "blue", "yellow", "white")

class(vect_char)

# iv) Factor variables using very low, low, medium, high, very high and name it vect_fact. Order the levels and name it vect_fact2 then check the levels again.

vect_fact <- factor(
  c("very low", "low", "medium", "high", "very high")
    )

class(vect_fact)
levels(vect_fact)

vect_fact2 <- factor(
  c("very low", "low", "medium", "high", "very high"),
  levels = c("very low", "low", "medium", "high", "very high")
    )
class(vect_fact2)
levels(vect_fact2)


vect_fact3 <- factor(
  c("very low", "low", "medium", "high", "very high"),
  levels = c("very low", "low", "medium", "high", "very high", ordered=TRUE)
    )
class(vect_fact3)
levels(vect_fact3)

vect_fact3_better <- vect_fact

levels(vect_fact3_better) <- c(levels(vect_fact))

vect_fact3_better

```

3. Combine vect_int and vect_fact3 using c() command, name it as vect_comb. Guess the type of  vect_comb’s class.
```{r}

vect_comb <- c(vect_int, vect_fact3)

vect_comb

class(vect_comb)

```


Use the vectors you created in the previous exercise and create a list and name it vect_list. Check the structure of vect_list. Add states of Australia as a vector to the list and name it vect_list2 (Hint: Use append() function).

```{r}

vect_list <- list(vect_int, vect_dbl, vect_char, vect_fact, vect_fact2, vect_fact3)

class(vect_list)

states = c("NSW", "Vic", "SA", "Tas", "Qld", "NT")

vect_list2 <- append(vect_list, list(states))

vect_list2

# Check the structure then name the elements of the list as comp1, comp2, …,comp9.

str(vect_list2)

names(vect_list2) <- c ("comp1", "comp2", "comp3", "comp4", "comp5", "comp6", "comp7")

str(vect_list2)

```

i) Select the third element of comp5.
```{r}
vect_list2$comp5[3]
```
ii) Select the second, fourth and eighth component of the list all together.
```{r}
vect_list2[c(2,4,8)]
```


5. Create a 5×4 numeric matrix using seq(0,36,by=2). Check out the warning message, notice that 5th row, 4th column is 0. Explain in a few words the reason of the warning and what this is called. (Hint: Refresh your memory with swirl package). Save this matrix as mat1, check the structure and attributes of it.
```{r}

mat1 <- matrix(seq(0,36,by=2), nrow = 5, ncol = 4)

mat1

# Because the sequence is going up by 2 (2,4,6,8,...), there are only 19 numbers generated in the sequence. We need 20 numbers (5x4) to fill the matrix

```

6. Create a matrix from vect_int and vect_fact3 using row-bind and column-bind and name it m1 and m2 respectively.
```{r}
# vect_int
# vect_fact3

m1 <- rbind(vect_int, vect_fact3)
m1

m2 <- cbind(vect_int, vect_fact3)
m2
```

Pick a suitable bind function to add m2 onto mat1 to create 5×6 matrix, name it mat2, check the attributes and structure. Have you noticed that the columns don’t have names?

```{r}
mat1
m2

mat2 <- cbind(mat1, m2)
mat2
str(mat2)

```

7. Create a matrix with vect_dbl and c(1,2,3,4), name it m3. Then combine m2 and m3 using column-bind. Explain in a few words what went wrong.

```{r}

m3 <- matrix(vect_dbl, c(1,2,3,4))
m3

m2

column_bind_matrix <- cbind(m2, m3)

# We can only combine matrices that have the same number of cols with cbind and same number of rows with rbind
# m3 has 1 row, 4 cols
# m2 has 5 rows, 2 cols
# even if function can map vect_int onto row #1, and vect_fact3 onto col #2

```

8. Add column names to the matrix mat2 and name it seq1, seq2, seq3, seq4, colours, factor1. Add row names to the matrix mat2 and name it x1, x2, x3, x4, x5. Check attributes.

lecture:
rownames(m4) <- c("subject1", "subject2", "subject3")
colnames(m4) <- c("var1", "var2", "var3")

```{r}
mat2

colnames(mat2) <- c("seq1", "seq2", "seq3", "seq4", "colours", "factor1")
rownames(mat2) <- c("x1", "x2", "x3", "x4", "x5")

mat2
```

9. Create a data frame using vectors vect_int and vect_char and name it df1. Check it’s structure. As you can see when creating a data frame from existing vectors with different classes, the structures are carried to the new data frame.
```{r}

df1 <- data.frame(vect_int, vect_char)
df1
# Check it’s structure.
str(df1)
```
Remove the factors from the second column and rename the data frame as df2, check the structure and compare with df1’s structure.
```{r}


df2 <- data.frame(vect_int, vect_char, stringsAsFactors = FALSE)
df2
str(df2)

# Doesn't include the levels
# ie. df1: vect_char: **Factor w/ 5 levels** "blue","green",..
# ie. df2: vect_char: chr  "red" "green" "blue" "yellow"

```

10. Add vect_fact3 onto df1 as a third column and name it df3. Check the structure, use stringsAsFactors command to remove the factors. What could be the reason why it’s not working? Now add vect_dbl to df3. Discuss the reason why we can’t combine vect_dbl and df3.
```{r}

df3 <- cbind(df1, vect_fact3, stringsAsFactors = TRUE)
df3
str(df3)
# I didn't get an error?
df3_without_factors <- cbind(df1, vect_fact3, stringsAsFactors = FALSE)
df3_without_factors
str(df3_without_factors)

# df3 <- cbind(df3, vect_dbl)
# df3

# The problem is we should have used rbind, not cbind
# We can then output a dataframe of 6x3

df4 <- rbind(df3, vect_dbl)
df4

```

11. Add column and row names to df3. Set the column names to numbers, colours, scale and row names to r1, r2, r3, r4, r5.
```{r}
df3
colnames(df3) <- c("numbers", "colours", "scale")
rownames(df3) <- c("r1", "r2", "r3", "r4", "r5")
df3


```

12. Subset df3 by row numbers, only select the fourth and fifth rows.
```{r}
df3[4:5,]


```

Then subset df3 by column numbers, only select first and third columns. For both tasks use subsetting by row/column number and then the row/column name. Subset the third column using $ operator.
```{r}
df3[,(1,3)]


```

13. Convert df3’s columns using as.
```{r}

```
