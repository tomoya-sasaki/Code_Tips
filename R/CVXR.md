# CVXR

## Table of Contents
1. [Match two objects](#match-two-objects)
2. [One-to-many](#one-to-many)


## Match two objects
```r 
> round(res_mat, 3)
          1      2      3      4      5      6      7      8      9     10     11    12
 [1,] 0.000  0.000  0.000  5.154 11.713 52.830 11.121 19.156  0.013  0.001  0.012 0.000
 [2,] 0.000  0.000 49.495  2.448  2.908  0.003 25.948 19.169  0.012  0.008  0.008 0.001
 [3,] 0.001  0.001  0.001  1.714  5.128  0.001  6.405  8.905  0.008 77.831  0.004 0.000
 [4,] 0.000  0.001  0.000  0.088  2.440  0.001  0.067  3.364  0.001  0.000 94.039 0.000
 [5,] 0.000  0.000  0.000  1.890  0.676  0.000  0.842  1.112 95.479  0.001  0.000 0.000
 [6,] 0.004 47.197  0.001  6.966 23.843  0.003 10.028 11.882  0.017  0.001  0.053 0.004
 [7,] 0.098  0.000  0.000  0.202 12.911 67.707  6.661 11.425  0.974  0.001  0.022 0.000
 [8,] 0.008  0.000 41.145 14.931 20.412  0.009 12.433 11.042  0.014  0.001  0.002 0.001
 [9,] 0.000  0.000  0.000  0.024 99.907  0.000  0.025  0.037  0.001  0.000  0.001 0.004
[10,] 0.000  0.000  0.000 99.914  0.025  0.000  0.038  0.020  0.000  0.000  0.002 0.000
[11,] 0.000  0.000  0.000  0.026  0.041  0.000  0.076 99.855  0.001  0.000  0.001 0.000
[12,] 0.000  0.000  0.000  0.029  0.025  0.000 99.916  0.025  0.002  0.000  0.003 0.000

> M <- Int(rows=nrow(res_mat), cols=ncol(res_mat))  # Indicator (which to use)
> obj <- Maximize(sum(M * res_mat))
> c1 <- M <=1
> c2 <- M >=0
> c3 <- sum_entries(M, axis=1) == 1
> c4 <- sum_entries(M, axis=2) == 1
> cts <- list(c1, c2, c3, c4)
> prob <- Problem(objective=obj, constraints=cts)
> sol <- solve(prob)
> sol_val <- round(sol$getValue(M))
> sol_val
      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12]
 [1,]    0    0    0    0    0    0    0    0    0     0     0     1
 [2,]    0    0    1    0    0    0    0    0    0     0     0     0
 [3,]    0    0    0    0    0    0    0    0    0     1     0     0
 [4,]    0    0    0    0    0    0    0    0    0     0     1     0
 [5,]    0    0    0    0    0    0    0    0    1     0     0     0
 [6,]    0    1    0    0    0    0    0    0    0     0     0     0
 [7,]    0    0    0    0    0    1    0    0    0     0     0     0
 [8,]    1    0    0    0    0    0    0    0    0     0     0     0
 [9,]    0    0    0    0    1    0    0    0    0     0     0     0
[10,]    0    0    0    1    0    0    0    0    0     0     0     0
[11,]    0    0    0    0    0    0    0    1    0     0     0     0
[12,]    0    0    0    0    0    0    1    0    0     0     0     0
> matched <- apply(sol_val, 2, function(x){which(x==1)})
> matched
 [1]  8  6  2 10  9  7 12 11  5  3  4  1
```


## One-to-many
```r
# First make a block
> data_blocked <- blockData(cand, bio, varnames = c("year", "prefecture_id", "kunr"))

==================== 
blockData(): Blocking Methods for Record Linkage
==================== 

Blocking variables.
    Blocking variable year using exact blocking.
    Blocking variable prefecture_id using exact blocking.
    Blocking variable kunr using exact blocking.

Combining blocked variables for final blocking assignments.

blocks <- names(data_blocked)
index = 3

cand_index <- data_blocked[[blocks[index]]]$dfA.inds
bio_index <- data_blocked[[blocks[index]]]$dfB.inds
block1 <- cand[cand_index, ]
block2 <- bio[bio_index, ]

> block1$name_jp
[1] "中山なりあき"   "ばば洋光"       "かわむら秀三郎" "上杉光弘"      
> block2$name_jp
[1] "上杉光弘"   "中山成彬"   "川村秀三郎" "馬場洋光"   "鶴丸千夏"  

mat <- stringdist::stringdistmatrix(block1$name_jp,block2$name_jp)
> mat
     [,1] [,2] [,3] [,4] [,5]
[1,]    6    4    6    6    6
[2,]    4    4    5    2    4
[3,]    7    7    4    7    7
[4,]    0    4    5    4    4

M <- Int(rows = nrow(block1), cols = nrow(block2))  # Indicator (which to use)
obj <- Minimize(sum(M * mat))

# Constraints
c1 <- M <=1
c2 <- M >=0
if (nrow(block1) < nrow(block2)) {
  c3 <- sum_entries(M, axis = 1) == 1
  c4 <- sum_entries(M, axis = 2) <= 1
} else if (nrow(block1) < nrow(block2)){
  c3 <- sum_entries(M, axis = 1) <= 1
  c4 <- sum_entries(M, axis = 2) == 1
} else {
  c3 <- sum_entries(M, axis = 1) == 1
  c4 <- sum_entries(M, axis = 2) == 1
}
cts <- list(c1, c2, c3, c4)
prob <- Problem(objective = obj, constraints = cts)
sol <- solve(prob)
sol_val <- round(sol$getValue(M))
matched <- apply(sol_val, 1, function(x){which(x==1)}) %>% unlist()

> cand$name_jp[cand_index]
[1] "中山なりあき"   "ばば洋光"       "かわむら秀三郎" "上杉光弘"      
> bio$name_jp[bio_index[matched]]
[1] "中山成彬"   "馬場洋光"   "川村秀三郎" "上杉光弘"  
```
