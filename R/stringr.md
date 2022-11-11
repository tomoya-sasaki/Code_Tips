# stringr

## Special characters
Using `fixed()` works:

We want to replace `_` to `\_` in `filename_000.R`.
```r
file <- str_replace_all("filename_000_1.R", fixed("_"), "\\_") 
cat(file)  # it returns `filename\_000\_1.R`
```
