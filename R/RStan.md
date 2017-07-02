# RStan

## Table of Contents
1. [Visualization](#visualization)
2. [Multi core](#multi-core)
3. [Initialization](#initialization)

## Visualization
* [Bayesplot](https://github.com/stan-dev/bayesplot)
* [ShinyStan](http://mc-stan.org/interfaces/shinystan)

## Multi core
```r
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
```

## Initialization
```r
generated quantities {
real T[K] = to_array_1d(rep_vector(0, K));
vector[K] a = rep_vector(0, K);
matrix[M, N] b = rep_matrix(0, M, N);
```
