# Practice Chapter 4
library(rstan)

# Data Generation
set.seed(123)
N1 <- 30
N2 <- 20
Y1 <- rnorm(n=N1, mean=0, sd=5)
Y2 <- rnorm(n=N2, mean=1, sd=4)

# (1)
library(ggplot2)
dY1 <- data.frame(type=1, Y=Y1)
dY2 <- data.frame(type=2, Y=Y2)
data <- rbind(dY1, dY2)
data$type <- as.factor(data$type)
p1 <- ggplot(data, aes(Y, color=type, fill=type)) +
				geom_density(alpha=0.2)

p1

p1ans <- ggplot(data=data, aes(x=type, y=Y, group=type, col=type)) + 
			geom_boxplot(outlier.size=0) + 
			geom_point(size=2)
p1ans

# (3)
dataList <- list(N1=N1, N2=N2, Y1=Y1, Y2=Y2)
stanmodel3 <- "
data{
	int N1;
	int N2;
	real Y1[N1];
	real Y2[N2];
}

parameters{
	real u1;
	real u2;
	real<lower=0> sigma;
}

model{
	for (i1 in 1:N1)
		Y1[i1] ~ normal(u1, sigma);

	for (i2 in 1:N2)
		Y2[i2] ~ normal(u2, sigma);
}

"

fit3 <- stan(model_code=stanmodel3, data=dataList, seed=1234)

# (4)
ms <- rstan::extract(fit3)
N_mcmc <- length(ms$lp__)
u1 <- ms$u1
u2 <- ms$u2
res3 <- data.frame(u1=ms$u1, u2=ms$u2)

fun_compare <- function(x){
	if(x[1] < x[2]) return(1)
	else return(0)
}
percent <- sum(apply(res3, 1, fun_compare)) / N_mcmc


# Anscode
percent_ans <- sum(ms$u1 < ms$u2) / N_mcmc

# (5)
stanmodel5 <- "
data{
	int N1;
	int N2;
	real Y1[N1];
	real Y2[N2];
}

parameters{
	real u1;
	real u2;
	real<lower=0> sigma1;
	real<lower=0> sigma2;
}

model{
	for (i1 in 1:N1)
		Y1[i1] ~ normal(u1, sigma1);

	for (i2 in 1:N2)
		Y2[i2] ~ normal(u2, sigma2);
}

"

fit5 <- stan(model_code=stanmodel5, data=dataList, seed=1234)

ms <- rstan::extract(fit5)
percent_ans <- sum(ms$u1 < ms$u2) / N_mcmc
