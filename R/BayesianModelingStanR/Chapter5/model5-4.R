library(rstan)
library(ggplot2)
library(gridExtra)

d <- read.csv('originaldata/data-attendance-2.txt')
data <- list(N=nrow(d), A=d$A, Score=d$Score/200, M=d$M, Y=d$Y)

model5.4 <- "
data{
	int N;
	int<lower=0, upper=1> A[N];
	real<lower=0, upper=1> Score[N];
	int<lower=0> M[N];
	int<lower=0> Y[N];
}

parameters{
	real b1;
	real b2;
	real b3;
}

transformed parameters{
	real q[N];
	for (n in 1:N)
		q[n] = inv_logit(b1 + b2*A[n] + b3*Score[n]);
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


fit <- stan(model_code=model5.4, data=data, seed=1234)

ms <- rstan::extract(fit)
d_qua <- t(apply(ms$y_pred, 2, quantile, prob=c(0.1, 0.5, 0.9))) # 80% predicted values interval
colnames(d_qua) <- c('p10', 'p50', 'p90')
d_qua <- data.frame(d, d_qua)
d_qua$A <- as.factor(d_qua$A)

res_vis <- ggplot(data=d_qua, aes(x=Y, y=p50, ymin=p10, ymax=p90, shape=A, fill=A)) +
						theme_bw(base_size=18) + theme(legend.key.height=grid::unit(2.5,'line')) +
						coord_fixed(ratio=1, xlim=c(5, 70), ylim=c(5, 70)) +
						geom_pointrange(size=0.7, color='gray5') + 
						geom_abline(aes(slope=1, intercept=0), color='black', alpha=3/5, linetype='31') + 
						scale_shape_manual(values=c(21,24)) + 
						scale_fill_manual(values=c('white', 'gray70')) + 
						labs(x="Observed", y='Predicted') +
						scale_x_continuous(breaks=seq(from=0, to=0.5, by=0.1)) +
						scale_y_continuous(breaks=seq(from=0, to=0.5, by=0.1))
