library(rstan)
library(ggplot2)
library(gridExtra)

data <- read.csv('originaldata/data-attendance-1.txt')

model5.3 <- "
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
	for (n in 1:N)
		y_pred[n] = normal_rng(mu[n], sigma);
}

"

dataList <- list(N=nrow(data), A=data$A, Score=data$Score/200, Y=data$Y)
fit <- stan(model_code=model5.3, data=dataList, seed=1234)
ms <- rstan::extract(fit)

# Results Visualization p.61-
## Observed values and Predicted values
d_qua <- t(apply(ms$y_pred, 2, quantile, prob=c(0.1, 0.5, 0.9))) # 80% predicted values interval
colnames(d_qua) <- c('p10', 'p50', 'p90')
d_qua <- data.frame(data, d_qua)
d_qua$A <- as.factor(d_qua$A)

res_vis <- ggplot(data=d_qua, aes(x=Y, y=p50, ymin=p10, ymax=p90, shape=A, fill=A)) +
						theme_bw(base_size=18) + theme(legend.key.height=grid::unit(2.5,'line')) +
						coord_fixed(ratio=1, xlim=c(0, 0.5), ylim=c(0, 0.5)) +
						geom_pointrange(size=0.7, color='gray5') + 
						geom_abline(aes(slope=1, intercept=0), color='black', alpha=3/5, linetype='31') + 
						scale_shape_manual(values=c(21,24)) + 
						scale_fill_manual(values=c('white', 'gray70')) + 
						labs(x="Observed", y='Predicted') +
						scale_x_continuous(breaks=seq(from=0, to=0.5, by=0.1)) +
						scale_y_continuous(breaks=seq(from=0, to=0.5, by=0.1))

ggsave(file='modelres5-3_PredValues.png', plot=res_vis, dpi=200, w=5, h=4)

## Distribution of the estimated error
N_mcmc <- length(ms$lp__)

d_noise <- data.frame(t(-t(ms$mu) + data$Y))
colnames(d_noise) <- paste0('noise', 1:nrow(data))
d_est <- data.frame(mcmc=1:N_mcmc, d_noise)
d_melt <- reshape2::melt(d_est, id=c('mcmc'), variable.name='X')

d_mode <- data.frame(t(apply(d_noise, 2, function(x){
		dens <- density(x)
		mode_i <- which.max(dens$y) # $y is where density is stored / densityがmaxの場所 -> MAP
		mode_x <- dens$x[mode_i]
		mode_y <- dens$y[mode_i]
		c(mode_x, mode_y)
})))
colnames(d_mode) <- c('X', 'Y')

pleft <- ggplot() +
					theme_bw(base_size=18) +
					geom_line(data=d_melt, aes(x=value, group=X), stat='density', color='black', alpha=0.4) +
					geom_segment(data=d_mode, aes(x=X, xend=X, y=Y, yend=0), color='black', linetype='dashed', alpha=0.4) + # dashed line to show the mode = MAP
					geom_rug(data=d_mode, aes(x=X), sides='b') + # bars below
					labs(x='value', y='density') 


s_dens <- density(ms$sigma)
s_MAP <- s_dens$x[which.max(s_dens$y)] # densityがmaxの場所 -> MAP 
bw <- 0.01
pright <- ggplot(data=d_mode, aes(x=X)) +
						theme_bw(base_size=18) +
						geom_histogram(binwidth=bw, color='black', fill='white') +
						geom_density(eval(bquote(aes(y=..count..*.(bw)))), alpha=0.5, color='black', fill='gray20') +
						stat_function(fun=function(x) nrow(data)*bw*dnorm(x, mean=0, sd=s_MAP), linetype='dashed') + # dnorm is a density / density \times number of data = count?
						labs(x='value', y='count') +
						xlim(range(density(d_mode$X)$x)) 
pright

pA <- grid.arrange(pleft, 
									 pright,
									 layout_matrix = rbind(c(1,1,2,2)))

ggsave(file='modelres5-3_DistError.png', plot=pA, dpi=200, w=7, h=4)


# Reference
## From http://qiita.com/hoxo_b/items/13d034ab0ed60b4dca88
### 縦軸をcountにした上でhistogramと確率密度関数を描く
### library(ggplot2)
### 
### dens <- density(faithful$waiting)
### bw <- diff(range(faithful$waiting))/20
### 
### ggplot(faithful, aes(x=waiting)) +
###   geom_histogram(binwidth=bw, fill='white', color='black') +
###   geom_density(eval(bquote(aes(y=..count..*.(bw)))), fill='black', alpha=0.3)+
###   xlim(range(dens$x))
