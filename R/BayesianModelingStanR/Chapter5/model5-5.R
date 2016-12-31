library(rstan)
library(ggplot2)

rstan_options(auto_write=TRUE)
options(mc.cores=parallel::detectCores())	

d <- read.csv('originaldata/data-attendance-3.txt')

# Check distribution
aggregate(Y ~ Weather, data=d, FUN=table)

model5.5 <- "
data{
	int I;
	int<lower=0, upper=1> A[I];
	real<lower=0, upper=1> Score[I];
	real<lower=0, upper=1> W[I];
	int<lower=0, upper=1> Y[I];
}

parameters{
	real b[4];
}

transformed parameters{
	real q[I];
	for (i in 1:I)
		q[i] = inv_logit(b[1] + b[2]*A[i] + b[3]*Score[i] + b[4]*W[i]);
}

model{
	for (i in 1:I)
		Y[i] ~ bernoulli(q[i]);
}

"

conv <- c(0, 0.2, 1)
names(conv) <- c('A', 'B', 'C')
data <- list(I=nrow(d), A=d$A, Score=d$Score/200, W=conv[d$Weather], Y=d$Y)
fit <- stan(model_code=model5.5, data=data, seed=1234)
ms <- rstan::extract(fit)

# Result Visualization
d_qua <- t(apply(ms$q, 2, quantile, prob=c(0.1, 0.5, 0.9)))
colnames(d_qua) <- c('p10', 'p50', 'p90')
d_qua <- data.frame(d, d_qua)
d_qua$Y <- as.factor(d_qua$Y)
d_qua$A <- as.factor(d_qua$A)

res_vis <- ggplot(data=d_qua, aes(x=Y, y=p50)) +
						theme_bw(base_size=18) + 
						coord_flip() +
						geom_violin(trim=F, size=1.5, color='gray45') + 
						geom_point(aes(color=A), position=position_jitter(w=0.15, h=0), size=1, alpha=0.1) +
						scale_color_manual(values=c('blue', 'red')) +
						labs(x="Y", y='q')
ggsave(file='modelres5-5.png', plot=res_vis, dpi=300, w=5.5, h=3)
