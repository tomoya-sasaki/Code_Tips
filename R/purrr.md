# purrr

1. [List to vector](#list-to-vector)
2. [Nested Data Frame](#nested-data-frame)
3. [reduce](#reduce)
4. [Apply a function to a list](#apply-a-function-to-a-list)
5. [Apply multiple functions](#apply-multiple-functions)

## List to vector
```r
flatten_int()
```    

## Nested Data Frame
Check [dplyr](https://github.com/Shusei-E/Code_Tips/blob/master/R/dplyr.md#nested-data-frame) as well.

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


## reduce
Element-wise mean over a list of matrices:
```r
> res
[[1]]
           [,1]      [,2]      [,3]
[1,] -1.3468857  4.361029 2.6439033
[2,] -1.4050666 13.093184 5.0243749
[3,]  0.4598971  2.453038 1.0621873
[4,] -2.2853001  1.375237 0.3613922

[[2]]
           [,1]      [,2]      [,3]
[1,] -1.3468857  4.361029 2.6439033
[2,] -1.4050666 13.093184 5.0243749
[3,]  0.4598971  2.453038 1.0621873
[4,] -2.2888568  1.384942 0.3474066

> reduce(res_Lambda, `+`) / length(res_Lambda)
           [,1]      [,2]      [,3]
[1,] -1.3469296  4.361458 2.6431927
[2,] -1.4145961 13.093153 5.0282564
[3,]  0.5359136  2.425231 1.0977963
[4,] -2.2387312  1.030103 0.4059852
```
`Reduce("+", res_Lambda)/ length(res_Lambda)` also works. Be careful with a quotation mark (baseR) and a backtick (purrr).


## Apply a function to a list
```r
> keywords <- list(c("workers", "jobs"))  # add more words later
> map(keywords, quanteda::char_wordstem, language = "en")
[[1]]
[1] "worker" "job"
```

## Apply multiple functions
```r
map(res_chains, function(x){map(x$iter_pi, max)})
```
Take `iter_pi` list in `res_chains` list and apply `max`.
