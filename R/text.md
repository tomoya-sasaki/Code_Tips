# Text

## Save a text file
```r
fileConn <- file("test.txt")
  writeLines(paste(sentences_vector, collapse = "\n"), sep = "", fileConn)
close(fileConn)
```
