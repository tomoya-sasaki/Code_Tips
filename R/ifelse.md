# ifelse

## Table of Contents
1. [NAを含む場合](#naを含む場合)

## NAを含む場合
```r
fun_ii9 <- function(x){ 
  if(is.na(x)){return(NA)} 
  if(x==99){return(NA)} 
  else{return(x)} 
}
data$ii9 <- apply(data["ii9"], 1, fun_ii9)
```
