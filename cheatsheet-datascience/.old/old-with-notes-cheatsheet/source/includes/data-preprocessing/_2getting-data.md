# 2.

### Vectors
```r
vector_name <- c(1:5) #
```
### Factors
```r
vector_fact2 <- factor(
  c("very low", "low", "medium", "high", "very high"),
  levels = c("very low", "low", "medium", "high", "very high")
    )
```
### Lists
```r
vector_list <- list(
  vector_int, vector_dbl, vector_char, vector_fact, vector_fact2, vector_fact3)

# name elements in a list  
names(vect_list2) <- c ("comp1", "comp2", "comp3", "comp4", "comp5", "comp6", "comp7")

```

### Matrix

```r
mat1 <- matrix(seq(0,36,by=2), nrow = 5, ncol = 4)
```

### Data.frame

```r
OurDataframe <- data.frame(row, col)
```


### Data.table (not covered)

### Tibble (not covered)

## Combining
```r
vector_combined <- c(vector_int, vector_fact3)

# Appending
vector_list2 <- append(vector_list, list(states))

# Bind rows
bindRows <- rbind(vector_int, vector_fact3)
# Bind columns
bindColumns <- cbind(vector_int, vector_fact3)

# cbind data.frames requires stringsAsFactors set
df <- cbind(OurDataframe, vect_fact3, stringsAsFactors = TRUE)
df
```

Add column and row names

```r
colnames(df3) <- c("numbers", "colours", "scale")
rownames(df3) <- c("r1", "r2", "r3", "r4", "r5")
```

## Selecting / subsetting

df[4:5,] # subset a dataframe by row numbers

df[,(1,3)] # subset a dataframe by col numbers

df$colName[3] # Select the third element of dataframe from the column named colName

## Saving

```{r}
library(xlsx)

write.xlsx(df, file = "cars.xlsx")

multiple_df <- createWorkbook()

# Create worksheets within workbooks
cars_df <- createSheet(wb = multiple_df, sheetName = "Cars")
iris_df <- createSheet(wb = multiple_df, sheetName = "Iris")

# Add dataframes to worksheets
addDataFrame(x = mtcars, sheet = car_df)
addDataFrame(x = iris, sheet = iris_df)

saveWorkbook(multiple_df, file = "combined.xlsx")

save(foo, bar, file = "foobar.RData")

save.image()

saveRDS(input, "something.rds")
output <- readRDS("something.rds")
identical(input, output)
# [1] TRUE
```
