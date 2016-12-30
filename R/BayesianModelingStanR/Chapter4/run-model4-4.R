library(rstan)
library(ggplot2)

d <- read.csv('originaldata/data-salary.txt')
X_new <- 23:60

data <- list(N=nrow(d), X=d$X, Y=d$Y, N_new=length(X_new), X_new=X_new)
fit <- stan(file='model4-4.stan', data=data, seed=1234)
ms <- rstan::extract(fit)

data.frame.quantile.mcmc <- function(x, y_mcmc,probs=c(2.5, 25, 50, 75, 97.5)/100){
	qua <- apply(y_mcmc, 2, quantile, probs=probs)
	d <- data.frame(X=x, t(qua))
	colnames(d) <- c('X', paste0('p', probs*100))
	return(d)
}

ggplot.5quantile <- function(data){
	p <- ggplot(data=data, aes(x=X, y=p50)) +
				theme_bw(base_size=18) +
				geom_ribbon(aes(ymin=p2.5, ymax=p97.5), fill='black', alpha=1/6) + 
				geom_ribbon(aes(ymin=p25, ymax=p75), fill='black', alpha=2/6) + 
				geom_line(size=1)
	return(p)
}

customize.ggplot.axis <- function(p){
	p <- p + labs(x="X", y="Y") +
				scale_y_continuous(breaks=seq(from=200, to=1400, by=400)) +
				coord_cartesian(xlim=c(22,61), ylim=c(200,1400))
	return(p)
}

d_est <- data.frame.quantile.mcmc(x=X_new, y_mcmc=ms$y_base_new)
p <- ggplot.5quantile(data=d_est)
p <- p + geom_point(data=d, aes(x=X, y=Y), shape=1, size=3)
p <- customize.ggplot.axis(p)

d_est <- data.frame.quantile.mcmc(x=X_new, y_mcmc=ms$y_new)
p1 <- ggplot.5quantile(data=d_est)
p1 <- p1 + geom_point(data=d, aes(x=X, y=Y), shape=1, size=3)
p1 <- customize.ggplot.axis(p1)
