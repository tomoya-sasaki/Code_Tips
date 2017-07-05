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

## Merge Result
```r
resStan1 <- vb(model, data=stan_data, seed=123, iter=100000, output_samples=1000, tol_rel_obj=0.005)
resStan2 <- vb(model, data=stan_data, seed=919, iter=100000, output_samples=1000, tol_rel_obj=0.005)
resStan3 <- vb(model, data=stan_data, seed=515, iter=100000, output_samples=1000, tol_rel_obj=0.005)
resStan <- sflist2stanfit(list(resStan1, resStan2, resStan3))
```
