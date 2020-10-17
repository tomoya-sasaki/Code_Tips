# Matrix


## Elementwise division
```r
sdiv <- function(X, Y) {
  sX <- summary(X)
  sY <- summary(Y)
  sRes <- merge(sX, sY, by = c("i", "j"))
  sparseMatrix(i = sRes[,1], j = sRes[,2], x = sRes[,3]/sRes[,4])
}
sdiv(A, B)
```
