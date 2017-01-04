library(rstan)
library(ggplot2)

modelZIP <- "
functions {
  real ZIP_lpmf(int Y, real q, real lambda) {
    if (Y == 0) {
      return log_sum_exp(
        bernoulli_lpmf(0 | q),
        bernoulli_lpmf(1 | q) + poisson_log_lpmf(0 | lambda)
      );
    } else {
      return bernoulli_lpmf(1 | q) + poisson_log_lpmf(Y | lambda);
    }
  }
}

data {
  int N;
  int D;
  int<lower=0> Y[N];
  matrix[N,D] X;
}

parameters {
  vector[D] b[2];
}

transformed parameters {
  vector[N] q_x;
  vector[N] q;
  vector[N] lambda;

  q_x = X*b[1];
  lambda = X*b[2];
  for (n in 1:N)
    q[n] = inv_logit(q_x[n]);
}

model {
  for (n in 1:N)
    Y[n] ~ ZIP(q[n], lambda[n]);
}

" 

d <- read.csv('Chapter11/originaldata/data-ZIP.txt')

d$Age <- d$Age/10
X <- cbind(1, d[,-ncol(d)])
data <- list(N=nrow(d), D=ncol(X), Y=d$Y, X=as.matrix(X))
fit <- stan(model_code=modelZIP, data=data, pars=c('b', 'q', 'lambda'), seed=123)

ms <- rstan::extract(fit)
N_mcmc <- length(ms$lp__)

r <- sapply(1:N_mcmc, function(i) cor(ms$lambda[i, ], ms$q[i,], method='spearman'))
quantile(r, prob=c(0.025, 0.25, 0.5, 0.75, 0.975))
