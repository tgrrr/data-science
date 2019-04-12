# Tidy and manipulate data pt2

## Functions


`Gather()`
`spread()`
`separate()`
`unite()`

|   | What it does  | Eg |
|---|---|---|
| **Columns** from `tidyr::` | Reshape a dataframe |
|`gather()`| Wide data -> longer   | `dataframe %>% gather(Year, newColumnName, 2:4)`
|`spread()`| long data -> wider  | `dataframe %>% spread(Year, ColumnWithValuesForNewColumn)`
|`separate()`| single column -> multiple columns  | `dataframe %>% separate(date, c("year", "month", "day"), sep = "-")` |
|`unite()`| multiple columns -> single  | `unite(date, year, month, day, sep = "-")`|
| **Get specific values** |
| `filter()` | pick observations based on values |
| `>, >=, !=, ==, etc` | comparison operators |
| `arrange()` | reorder rows |
  | `desc()` | reorder rows in descending order
| `select()` | select variables |
  | - `starts_with()` | select variables based on patterns
  | - `ends_with()` |
  | - `contains()` |
| **Create new variables ** |
| `mutate()` | create new variables |
| `transmute()` | create new variables |
| `summarise()` | summarise data |
| `group_by()` | group based on categorical values |
| `%>%` | piping operator from `magrittr::` |
