library(rstan)
library(ggplot2)

rstan_options(auto_write=TRUE)
options(mc.cores=parallel::detectCores())	

# (1)
source('model5-3.R')

e <- t( d$Y - t(ms$mu) )

# (2)
modelEx5.2 <- "
data{
	int N;
	int<lower=0, upper=1> A[N];
	real<lower=0, upper=1> Score[N];
	real<lower=0, upper=1> Y[N];
}

parameters{
	real b1;
	real b2;
	real b3;
	real<lower=0> sigma;
}

transformed parameters{
	real mu[N];
	for (n in 1:N)
		mu[n] = b1 + b2*A[n] + b3*Score[n];
}

model{
	for (n in 1:N)
		Y[n] ~ normal(mu[n], sigma);
}

generated quantities{
	real y_pred[N];
	real e[N];

	for (n in 1:N) {
		y_pred[n] = normal_rng(mu[n], sigma);
		e[n] = Y[n] - mu[n];
	}
}

"

fit2 <- stan(model_code=modelEx5.2, data=dataList, seed=1234)
ms2 <- rstan::extract(fit2)

# (3)
d <- read.csv(file='originaldata/data-attendance-3.txt')
aggregate(Y ~ A, data=d, FUN=table)

# (4)
modelEx5.4 <- "
data{
	int I;
	int<lower=0, upper=1> A[I];
	real<lower=0, upper=1> Score[I];
	int<lower=0, upper=3> W[I];
	int<lower=0, upper=1> Y[I];
}

parameters{
	real b[3];
	real wprop2;
	real wprop3;
}

transformed parameters{
	real bw[3];
	bw[1] = 0;
	bw[2] = wprop2;
	bw[3] = wprop3;
}

model{
	for (i in 1:I)
		Y[i] ~ bernoulli_logit(b[1] + b[2]*A[i] + b[3]*Score[i] + bw[W[i]]); // 初めはここにbを掛けてしまっていて遅かった
}

"

conv <- c(1, 2, 3)
names(conv) <- c('A', 'B', 'C')
data <- list(I=nrow(d), A=d$A, Score=d$Score/200, W=conv[d$Weather], Y=d$Y)
fit4 <- stan(model_code=modelEx5.4, data=data, seed=1234)
ms <- rstan::extract(fit4)


# (5)
source('model5-6.R')

## Observed values and Predicted values
d_qua <- t(apply(ms$m_pred, 2, quantile, prob=c(0.1, 0.5, 0.9))) # 80% predicted values interval
colnames(d_qua) <- c('p10', 'p50', 'p90')
d_qua <- data.frame(d, d_qua)
d_qua$A <- as.factor(d_qua$A)

res_vis <- ggplot(data=d_qua, aes(x=M, y=p50, ymin=p10, ymax=p90, shape=A, fill=A)) +
						theme_bw(base_size=18) + theme(legend.key.height=grid::unit(2.5,'line')) +
						coord_fixed(ratio=1, xlim=c(5, 80), ylim=c(5, 80)) +
						geom_pointrange(size=0.7, color='gray5') + 
						geom_abline(aes(slope=1, intercept=0), color='black', alpha=3/5, linetype='31') + 
						scale_shape_manual(values=c(21,24)) + 
						scale_fill_manual(values=c('red', 'blue')) + 
						labs(x="Observed", y='Predicted') +
						scale_x_continuous(breaks=seq(from=0, to=0.5, by=0.1)) +
						scale_y_continuous(breaks=seq(from=0, to=0.5, by=0.1))
ggsave(file='modelresEx5.png', plot=res_vis, dpi=300, w=4, h=3)

# (6)
d <- read.csv('originaldata/data3a.csv')

modelEx5.6 <- "
data{
	int N;
	real<lower=0, upper=15> x[N];
	int<lower=0, upper=1> f[N];
	int<lower=2, upper=15> Y[N];
}

parameters{
	real b[3];
}

transformed parameters{
	real lambda[N];
	for (n in 1:N)
		lambda[n] = b[1] + b[2]*x[n] + b[3]*f[n];
}

model{
	for (n in 1:N)
		Y[n] ~ poisson_log(lambda[n]); // better to use this than using exp (p.76)
}

generated quantities{
	int Y_pred[N];
	for (n in 1:N)
		Y_pred[n] = poisson_log_rng(lambda[n]);
}

"

conv <- c(0, 1)
names(conv) <- c('C', 'T')
data <- list(N=nrow(d), Y=d$y, x=d$x, f=conv[d$f])
fit6 <- stan(model_code=modelEx5.6, data=data, seed=1234)
ms6 <- rstan::extract(fit6)


# (7)
d <- read.csv('originaldata/data4a.csv')

modelEx5.7 <- "
data{
	int<lower=0> N;
	int<lower=0> M[N];
	real<lower=0, upper=15> X[N];
	int<lower=0, upper=1> F[N];
	int<lower=0> Y[N];
}

parameters{
	real b[3];
}

transformed parameters{
	real q[N];
	for (n in 1:N)
		q[n] = inv_logit(b[1] + b[2]*X[n] + b[3]*F[n]);
}

model{
	for (n in 1:N)
		Y[n] ~ binomial(M[n], q[n]);
}

generated quantities{
	real y_pred[N];
	for (n in 1:N)
		y_pred[n] = binomial_rng(M[n], q[n]);
}

"

conv <- c(0, 1)
names(conv) <- c('C', 'T')
data <- list(N=nrow(d), M=d$N, Y=d$y, X=d$x, F=conv[d$f])
fit7 <- stan(model_code=modelEx5.7, data=data, seed=1234)
ms7 <- rstan::extract(fit7)
