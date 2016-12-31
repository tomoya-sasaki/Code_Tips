library(rstan)
library(ggplot2)

rstan_options(auto_write=TRUE)
options(mc.cores=parallel::detectCores())	

d <- read.csv('originaldata/data-attendance-2.txt')

model5.6 <- "
data{
	int N;
	int<lower=0, upper=1> A[N];
	real<lower=0, upper=1> Score[N];
	int<lower=0> M[N];
}

parameters{
	real b[3];
}

transformed parameters{
	real lambda[N];
	for (n in 1:N)
		lambda[n] = b[1] + b[2]*A[n] + b[3]*Score[n];
}

model{
	for (n in 1:N)
		M[n] ~ poisson_log(lambda[n]); // better to use this than using exp (p.76)
}

generated quantities{
	int m_pred[N];
	for (n in 1:N)
		m_pred[n] = poisson_log_rng(lambda[n]);
}

"

data <- list(N=nrow(d), A=d$A, Score=d$Score/200, M=d$M)
fit <- stan(model_code=model5.6, data=data, seed=1234)
ms <- rstan::extract(fit)
