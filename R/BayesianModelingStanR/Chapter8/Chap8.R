setwd("~/Dropbox/Backup/GitHubData/Code_Tips/R/BayesianModelingStanR")
library(ggplot2)
library(gridExtra)
library(rstan)

rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

d <- read.csv(file='Chapter8/originaldata/data-salary-2.txt')
d$KID <- as.factor(d$KID)

# 8.1.2
res_lm <- lm(Y ~ X, data=d)
coef <- as.numeric(res_lm$coefficients)

pleft <- ggplot(d, aes(x=X, y=Y, shape=KID)) +
					theme_bw(base_size=18) +
					geom_abline(intercept=coef[1], slope=coef[2], size=2, alpha=0.4) +
					geom_point(size=2.5) +
					scale_shape_manual(values=c(16,2,4,9)) +
					labs(x="X", y='Y')

pright <- ggplot(d, aes(x=X, y=Y, shape=KID)) +
						ggtitle('Plot for Each Company') +	
						theme_bw(base_size=20) +
						geom_abline(intercept=coef[1], slope=coef[2], size=2, alpha=0.4) +
						facet_wrap(~KID) +
						geom_line(stat='smooth', method='lm', se=TRUE, size=1, color='black', linetype='31', alpha=0.9) +
						geom_point(size=3) +
						scale_shape_manual(values=c(16,2,4,9)) +
						labs(x='X', y='Y') + 	theme(plot.title = element_text(hjust = 0.5)) 


g1 <- ggplotGrob(pright)
id.legend <- grep("guide", g1$layout$name)
legend <- g1[["grobs"]][[id.legend]]
gA <- grid.arrange(pleft + theme(legend.position="none"), 
          pright + theme(legend.position="none"), 
          legend, 
          layout_matrix = rbind(c(1,1,1,1,2,2,2,3))
          )

ggsave(file = "Chapter8/sec8.1.png", plot = gA, dpi = 200, width = 10.5, height = 6.2)


# 8.1.4
## Data Generation
set.seed(123)
N <- 40
K <- 4
N_k <- c(15,12,10,3)
a0 <- 350
b0 <- 12
s_a <- 60
s_b <- 4
s_Y <- 25

X <- sample(x=0:35, size=N, replace=T)
KID <- rep(1:4, times=N_k)

a <- rnorm(K, mean=0, sd=s_a) + a0
b <- rnorm(K, mean=0, sd=s_b) + b0
d <- data.frame(X=X, KID=KID, a=a[KID], b=b[KID])


# 8.2.1
d <- read.csv('Chapter8/originaldata/data-salary-3.txt')
KIDGID <- unique(d[,3:4])

N <- nrow(d)
K <- 30
G <- 3

coefs <- as.data.frame(t(sapply(1:K, function(k){
																	d_sub <- subset(d, KID==k)
																	as.numeric(lm(Y~X, data=d_sub)$coefficients)
})))
colnames(coefs) <- c('a', 'b')
d_plot <- data.frame(coefs,KIDGID)

lmplot <- function(var){
	bw <- diff(range(d_plot[var])) /20 
	p <- ggplot(data=d_plot, aes_string(x=var)) +
				theme_bw(base_size=18) +
				facet_wrap(~GID, nrow=3) +
				geom_histogram(binwidth=bw, color='black', fill='white') +
				geom_density(eval(bquote(aes(y=..count..*.(bw)))), alpha=0.3, color='black', fill='gray20') +
				labs(x=var, y='count')
	return(p)
}
lmplot("a")

gA <- grid.arrange(lmplot("a"), 
          lmplot("b"), 
          layout_matrix = rbind(c(1,1,1,2,2,2))
          )

ggsave(file = "Chapter8/sec8.2.png", plot = gA, dpi = 200, width = 10.5, height = 4.9)

# 8.2.4
K2G <- unique(d[, c('KID', 'GID')])$GID

# 8.4
model8.8 <- "
data {
  int N;
  int C;
  int I;
  int<lower=0, upper=1> A[N];
  real<lower=0, upper=1> Score[N];
  int<lower=1, upper=N> PID[I];
  int<lower=1, upper=C> CID[I];
  real<lower=0, upper=1> W[I];
  int<lower=0, upper=1> Y[I];
}

parameters {
  real b[4];
  real b_P[N];
  real b_C[C];
  real<lower=0> s_P;
  real<lower=0> s_C;
}

transformed parameters {
  real x_P[N];
  real x_C[C];
  real x_J[I];
  real x[I];
  real q[I];
  for (n in 1:N)
    x_P[n] = b[2]*A[n] + b[3]*Score[n] + b_P[n];
  for (c in 1:C)
    x_C[c] = b_C[c];
  for (i in 1:I) {
    x_J[i] = b[4]*W[i];
    x[i] = b[1] + x_P[PID[i]] + x_C[CID[i]] + x_J[i];
    q[i] = inv_logit(x[i]);
  }
}

model {
  for (n in 1:N)
    b_P[n] ~ normal(0, s_P);
  for (c in 1:C)
    b_C[c] ~ normal(0, s_C);
  for (i in 1:I)
    Y[i] ~ bernoulli(q[i]);
}

"

source('common.R')

d1 <- read.csv('Chapter8/originaldata/data-attendance-4-1.txt')
d2 <- read.csv('Chapter8/originaldata/data-attendance-4-2.txt')
N <- 50
C <- 10
I <- nrow(d2)
conv <- c(0, 0.2, 1)
names(conv) <- c('A', 'B', "C")
data <- list(N=N, C=C, I=I, A=d1$A, Score=d1$Score/200, PID=d2$PersonID, CID=d2$CourseID, W=conv[d2$Weather], Y=d2$Y)
fit <- stan(model_code=model8.8, data=data, pars=c('b','b_P','b_C','s_P','s_C','q'), seed=1234)
ms <- rstan::extract(fit)
N_mcmc <- length(ms$lp__)

param_names <- c('mcmc', paste0('b', 1:4), 's_P', 's_C')
d_est <- data.frame(1:N_mcmc, ms$b, ms$s_P, ms$s_C)
colnames(d_est) <- param_names
d_qua <- data.frame.quantile.mcmc(x=param_names[-1], y_mcmc=d_est[, -1])
d_melt <- reshape2::melt(d_est, id=c('mcmc'), variable.name="X")
d_melt$X <- factor(d_melt$X, levels=rev(levels(d_melt$X)))

pleft <- ggplot() +
					theme_bw(base_size=18) +
					coord_flip() +
					geom_violin(data=d_melt, aes(x=X, y=value), fill='white', color='gray80', size=2, alpha=0.4, scale='width') +
					geom_pointrange(data=d_qua, aes(x=X, y=p50, ymin=p2.5, ymax=p97.5), size=1) +
					labs(x='parameter', y='value') +
					scale_y_continuous(breaks=seq(from=-2, to=6, by=2))


d_est <- data.frame(1:N_mcmc, ms$b_C)
colnames(d_est) <- c('mcmc', paste0('b_C', 1:10))
d_mode <- data.frame(t(apply(ms$b_C, 2, function(x) {
  dens <- density(x)
  mode_i <- which.max(dens$y)
  mode_x <- dens$x[mode_i]
  mode_y <- dens$y[mode_i]
  c(mode_x, mode_y)
})))
colnames(d_mode) <- c('X', 'Y')
d_melt <- reshape2::melt(d_est, id=c('mcmc'), variable.name='X')

pright <- ggplot() + 
			theme_bw(base_size=18) + 
			geom_density(data=d_melt, aes(x=value, group=X), fill='black', color='black', alpha=0.15) + 
			geom_segment(data=d_mode, aes(x=X, xend=X, y=Y, yend=0), color='black', linetype='dashed', alpha=0.6) + 
			geom_rug(data=d_mode, aes(x=X), sides='b') + 
			labs(x='value', y='density') + 
			scale_x_continuous(breaks=seq(from=-4, to=4, by=2))


gA <- grid.arrange(pleft, 
          pright, 
          layout_matrix = rbind(c(1,1,1,2,2,2))
          )

ggsave(file = "Chapter8/sec8.4.png", plot = gA, dpi = 200, width = 10.5, height = 4.9)
