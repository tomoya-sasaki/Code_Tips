# RStan
Consider using [`brms`](https://das-kino.hatenablog.com/entry/2018/12/15/230938).

## Table of Contents
1. [Visualization](#visualization)
2. [Multi core](#multi-core)
3. [Initialization](#initialization)
4. [Diagnosis](#diagnosis)
5. [Self-defined functions](#self-defined-functions)

## Visualization
* [Bayesplot](https://github.com/stan-dev/bayesplot)
* [ShinyStan](http://mc-stan.org/interfaces/shinystan)
* [tidybayes](https://github.com/mjskay/tidybayes)

### With ggplot2
```r
result <- rstan::extract(resStan)

# Line Plot
values <- as.tibble((result$predicted_values))
colnames(values) <- paste0("X", colnames(values))
values_qua <- (t(apply(values, 2, quantile, prob=c(0.05, 0.5, 0.95))))
colnames(values_qua) <- c('p5', 'p50', 'p95')
values_qua <- transform(values_qua, X=rownames(values_qua))
values_melt <- gather(values, value=X)
```

Quantile with `group_by()`
```r
theta_melted %>%
    group_by(Year, Type) %>%
    do(data.frame(t(quantile(.$Proportion, probs=c(0.025, 0.5, 0.975)))))
```

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

## Diagnosis
[Documentation](https://www.rdocumentation.org/packages/rstan/versions/2.17.3/topics/Diagnostic%20plots)

```r
stan_diag(object)
stan_par(object, par, chain = 0, ...)  
stan_rhat(object, pars, ...)
stan_ess(object, pars, ...)
stan_mcse(object, pars, ...)
```

## Self-defined functions
[Reference](https://github.com/stan-dev/math/issues/214)
```stan
functions{
	real normal_lb_ub_rng(real mu, real sigma, real lb, real ub) {
			if(mu > 1.0)
				return 1.0;
			else if(mu < -1.0)
				return -1.0;
			else{
				real p1 = normal_cdf(lb, mu, sigma);  // cdf with lower bound
				real p2 = normal_cdf(ub, mu, sigma);  // cdf with upper bound
				real u = uniform_rng(p1, p2);
				return (sigma * inv_Phi(u)) + mu;  // inverse cdf 
			}
	}
}
data{
}
```
