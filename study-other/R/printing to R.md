## Printing to R output

# cat
- works without the line number
```r
cat("factors_all_years:")
```

## print

print("factors_all_years:", row.names = FALSE)


## paste

paste has sep default " "
paste0 has sep default "" (no space)

## paste0

paste0(render_markdown("factors_all_years:"))

```r
person <-"Grover"
action <-"flying"
message(paste0("On ", Sys.Date(), " I realized ", person, " was...\n", action, " by the street"))
```
## sprintf
```r
person <-"Grover"
action <-"flying"
message(sprintf("On %s I realized %s was...\n%s by the street", Sys.Date(), person, action))
```

#### Source
[paste, paste0, and sprintf](https://www.r-bloggers.com/paste-paste0-and-sprintf/)
https://www.r-bloggers.com/difference-between-paste-and-paste0/
further reading about shiny: https://stackoverflow.com/questions/23233497/outputting-multiple-lines-of-text-with-rendertext-in-r-shiny
