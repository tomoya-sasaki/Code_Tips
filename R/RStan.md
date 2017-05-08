# RStan

## Table of Contents
1. [Visualization](#visualization)
2. [Multi core](#multi-core)

## Visualization
* [Bayesplot](https://github.com/stan-dev/bayesplot)
* [ShinyStan](http://mc-stan.org/interfaces/shinystan)

## Multi core
```r
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
```
