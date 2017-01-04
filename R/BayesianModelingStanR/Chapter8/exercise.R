library(rstan)
library(ggplot2)

rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

setwd("~/Dropbox/Backup/GitHubData/Code_Tips/R/BayesianModelingStanR")

#########
## (1) ##
#########
model8.2 <- "
data {
  int N;
  int K;
  real X[N];
  real Y[N];
  int<lower=1, upper=K> KID[N];
}

parameters {
  real a[K];
  real b[K];
  real<lower=0> s_Y;
}

model {
  for (n in 1:N)
    Y[n] ~ normal(a[KID[n]] + b[KID[n]]*X[n], s_Y);
}

generated quantities{
	real y_pred[N];
	for (n in 1:N)
		y_pred[n] = normal_rng(a[KID[n]] + b[KID[n]]*X[n] , s_Y);
}

"

d <- read.csv('Chapter8/originaldata/data-salary-2.txt')
N <- nrow(d)
K <- 4
data <- list(N=N, X=d$X, Y=d$Y, KID=d$KID)
fit2 <- stan(model_code=model8.2, data=data, seed=1234)

ms2 <- rstan::extract(fit2)

y_pred <- t(ms2$y_pred)
y_pred <- t(apply(data.frame(y_pred), 1, quantile, probs=c(0.025, 0.5, 0.975)))
colnames(y_pred) <- c('p2.5', 'p50', 'p97.5')
b_exp <- transform(y_pred, X=d$X, Y=d$Y, KID=as.factor(d$KID))

d$KID <- as.factor(d$KID)

p1 <- ggplot(data=b_exp, aes(x=X, y=Y, shape=KID)) +
				theme_bw(base_size=18) + theme(legend.key.width=grid::unit(2.5, 'line')) +
				facet_wrap(~KID) +
				geom_point(size=3) +
				geom_ribbon(data=b_exp,aes(y=p50, ymin=p2.5, ymax=p97.5), fill='black', alpha=1/5) +
				geom_line(aes(y=p50), size=1, alpha=0.8) +
				scale_shape_manual(values=c(16,2,4,9)) +
				labs(x='X', y='Y', shape='KID')
ggsave(file = "Chapter8/Ex1.png", plot = p1, dpi = 200, width = 5.5, height = 4.9)

#########
## (2) ##
#########

model8.3 <- "
data {
  int N;
  int K;
  real X[N];
  real Y[N];
  int<lower=1, upper=K> KID[N];
	int<lower=0> XMax;
}

parameters {
  real a0;
  real b0;
  real ak[K];
  real bk[K];
  real<lower=0> s_a;
  real<lower=0> s_b;
  real<lower=0> s_Y;
}

transformed parameters {
  real a[K];
  real b[K];
  for (k in 1:K) {
    a[k] = a0 + ak[k];
    b[k] = b0 + bk[k];
  }
}

model {
  for (k in 1:K) {
    ak[k] ~ normal(0, s_a);
    bk[k] ~ normal(0, s_b);
  }

  for (n in 1:N)
    Y[n] ~ normal(a[KID[n]] + b[KID[n]]*X[n], s_Y);
}

generated quantities{
	matrix[XMax, K] y_pred;

	for (k in 1:K){
		for (x in 1:XMax)
			y_pred[x, k] = normal_rng(a[k] + b[k]*x, s_Y);
	}
}

"

d <- read.csv('Chapter8/originaldata/data-salary-2.txt')
N <- nrow(d)
K <- 4
data <- list(N=N, X=d$X, Y=d$Y, KID=d$KID, XMax=max(d$X))
fit3 <- stan(model_code=model8.3, data=data, seed=1234)
ms3 <- rstan::extract(fit3)

res <- data.frame()
for (k in 1:K){
	temp <- ms3$y_pred[, , k]
	temp_quantile <- t(apply(data.frame(t(temp)), 1, quantile, probs=c(0.025, 0.5, 0.975)))
	colnames(temp_quantile) <- c('p2.5', 'p50', 'p97.5')

	res <- rbind(res, transform(temp_quantile, KID=as.factor(k), X=1:max(d$X)))
}
d$KID <- as.factor(d$KID)

p2 <- ggplot(data=d, aes(x=X, y=Y, shape=KID)) +
				theme_bw(base_size=18) + theme(legend.key.width=grid::unit(2.5, 'line')) +
				facet_wrap(~KID) +
				geom_point(size=3) +
				geom_ribbon(data=res, aes(y=p50, ymin=p2.5, ymax=p97.5), fill='black', alpha=1/5) +
				geom_line(data=res, aes(y=p50), size=1, alpha=0.8, color='blue') +
				scale_shape_manual(values=c(16,2,4,9)) +
				labs(x='X', y='Y', shape='KID') + ggtitle('Chapter 8: Exercise 2') + theme(plot.title = element_text(hjust = 0.5))
ggsave(file = "Chapter8/Ex2.png", plot = p2, dpi = 200, width = 5.5, height = 4.9)


#########
## (3) ##
#########
model8.5 <- "
data {
  int N;
  int G;
  int K;
  real X[N];
  real Y[N];
  int<lower=1, upper=K> KID[N];
  int<lower=1, upper=G> K2G[K];
}

parameters {
  real a0;
  real b0;
  real a1[G];
  real b1[G];
  real a[K];
  real b[K];
  real<lower=0> s_ag;
  real<lower=0> s_bg;
  real<lower=0> s_a;
  real<lower=0> s_b;
  real<lower=0> s_Y;
}

model {
  for (g in 1:G) {
    a1[g] ~ normal(a0, s_ag);
    b1[g] ~ normal(b0, s_bg);
  }

  for (k in 1:K) {
    a[k] ~ normal(a1[K2G[k]], s_a);
    b[k] ~ normal(b1[K2G[k]], s_b);
  }

  for (n in 1:N)
    Y[n] ~ normal(a[KID[n]] + b[KID[n]]*X[n], s_Y);
}

"

d <- read.csv('Chapter8/originaldata/data-salary-3.txt')
N <- nrow(d)
K <- 30
G <- 3
K2G <- unique(d[ , c('KID','GID')])$GID
data5 <- list(N=N, G=G, K=K, X=d$X, Y=d$Y, KID=d$KID, K2G=K2G)
fit5 <- stan(model_code=model8.5, data=data5, seed=12345)
ms5 <- rstan::extract(fit5)

a_ind <- data.frame((ms5$a1))
colnames(a_ind) <- c('a1_1', 'a1_2', 'a1_3')
a_ind_qua <- data.frame(t(apply(a_ind, 2, quantile, prob=c(0.05, 0.5, 0.95))))
colnames(a_ind_qua) <- c('p5', 'p50', 'p95')
a_ind_qua <- transform(a_ind_qua, X=rownames(a_ind_qua))

a_ind_melt <- reshape2::melt(a_ind, variable.name="X")

p3 <- ggplot() +
				theme_bw(base_size=18) +
				coord_flip() +
				geom_violin(data=a_ind_melt, aes(x=X, y=value), fill='white', color='gray80', size=2, alpha=0.4, scale='width') +
				geom_pointrange(data=a_ind_qua, aes(x=X, y=p50, ymin=p5, ymax=p95), size=1) +
				scale_x_discrete(limits = c('a1_3', 'a1_2', 'a1_1'))
ggsave(file = "Chapter8/Ex3.png", plot = p3, dpi = 200, width = 5.5, height = 4.9)


#########
## (4) ##
#########
library(dplyr)
library(gridExtra)

d <- read.csv('Chapter8/originaldata/data-attendance-4-2.txt')

d_person <- d %>% group_by(PersonID) %>%
									summarize(mean=mean(Y))
bw <- (max(d_person$mean) - min(d_person$mean)) / 30

p_person <- ggplot(data=d_person, aes(x=mean)) +
							geom_histogram(color='black', fill='lightblue', binwidth=bw) +
							geom_density(eval(bquote(aes(y=..count..*.(bw)))), fill='gray80', alpha=0.4) 

d_course <- d %>% group_by(CourseID) %>%
									summarize(mean=mean(Y))
bw <- (max(d_course$mean) - min(d_course$mean)) / 30

p_course <- ggplot(data=d_course, aes(x=mean)) +
							geom_histogram(color='black', fill='lightgreen', binwidth=bw) +
							geom_density(eval(bquote(aes(y=..count..*.(bw)))), fill='gray80', alpha=0.4) 
						
pA <- grid.arrange(p_person, p_course, layout_matrix=rbind(c(1,1,1,2,2,2)))
ggsave(file='Ex4.png', plot=pA, dpi=200, w=7, h=4)

#########
## (5) ##
#########
# Skipped

#########
## (6) ##
#########
d <- read.csv('Chapter8/originaldata/data7a.csv')
modelEx6 <- "
data{
	int N; // number of data
	int Y[N];
	int ID[N];
}

parameters {
	real b;
	real b_I[N];
	real<lower=0> s_I;
}

transformed parameters{
	real q[N];
	for (n in 1:N)
		q[n] ~ inv_logit(b + b_I[n])
}

model{
	for (n in 1:N)
		b_I[n] ~ normal(0, s_I);
	for (n in 1:N)
		Y[n] ~ binomial(8, q[n])
}

"


#########
## (7) ##
#########
