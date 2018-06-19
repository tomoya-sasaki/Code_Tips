# purrr

1. [List to vector](#list-to-vector)
2. [Nested Data Frame](#nested-data-frame)

## List to vector
```r
flatten_int()
```    

## Nested Data Frame
```r
> head(res$W)
$text1
 [1]  0  1  2  3  4  5  6  4  7  8  9 10 11  9 12 13 14 15 16 17 18 19 20 21 22
[26] 23 24 25 11 26 27 16 28 29 19 30 31 32 33 34 35 36 37
$text2
 [1] 38 39 40 41 42 43 44 45 38 46 47 48 46 49 50 51 46 52 53 54 55 56 57 58 59
[26]  4 19 60 61 48 39 62 63 57

> res$W %>%
  names() -> doc_names # [1] "text1"   "text2"   "text3" ...

> res$W %>%
  map(length) %>%
  flatten_int() -> doc_len # [1]  43  34   7...

> doc_names <- rep(doc_names, doc_len) 

> res$W %>%
  flatten_int() -> words
  
> res$Z %>%
  flatten_int() -> topics

> tibble(doc = doc_names,words=words,topics=topics) %>%
   group_by(doc) %>%
   tidyr::nest(words, topics, .key=data)
# A tibble: 404 x 2
      doc              data
    <chr>            <list>
 1  text1 <tibble [43 x 2]>
 2  text2 <tibble [34 x 2]>
 3  text3  <tibble [7 x 2]>
 [..omitted..]
```