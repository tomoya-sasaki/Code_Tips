### Read Library
library(mvtnorm)
library(ggplot2)
### Read Data 
data <- faithful
K <- 2 # Number of category

### Prepare Function
likelihood <- function(X, mean_, cov_, pi_){
	# log likelihood
	summation <- 0.0
	for(n in 1:dim(X)[1]){
		temp = 0.0
		for(k in 1:K){
			temp <- temp + pi_[k] * dmvnorm(X[n,], mean_[k,], cov_[,,k])
		}
		summation <- summation + log(temp)
	}
	return(summation)
}


### Algorithm
X <- data.matrix(data[,1:2], rownames.force = NA)
N <- dim(X)[1] # number of observation

## Initialization
init_mu <- t(matrix(c(mean(X[,1]), mean(X[,2]))))
mean_ <- rbind(1.1*init_mu, 0.9*init_mu)
cov_ <- array(rep(0,4*K), dim=c(K, 2, 2)) # Multi dimensional array
for(k in 1:K) cov_[,,k] = diag(K)

pi_ <- matrix(rep(1, 2), nrow=2, ncol=1) / K

gamma_ <- matrix(rep(0, N*K), nrow=N, ncol=K)
like <- likelihood(X, mean_, cov_, pi_)

## Iteration
iter <- 0

while(1){
	## E-Step
	for(n in 1:N){
		denominator <- 0.0
		for(k in 1:K)
			denominator <- denominator + pi_[k] * dmvnorm(X[n,], mean_[k,], cov_[,,k])

		for(k in 1:K)
			gamma_[n,k] <- pi_[k] * dmvnorm(X[n,], mean_[k,], cov_[,,k]) / denominator
	}

	## M-Step
	for(k in 1:K){
		Nk <- sum(gamma_[,k])

		# Calculate mean
		mean_[k,] <- rep(0,K)
		for(n in 1:N)
			mean_[k, ] <- mean_[k, ] + gamma_[n,k] * X[n,]
		mean_[k, ] <- mean_[k, ] / Nk

		# Calculate covariance
		cov_[,,k] <- array(rep(0,4*K), dim=c(2, 2))
		for(n in 1:N){
			temp <- matrix(X[n,] - mean_[k,])
			cov_[,,k] <- cov_[,,k] + gamma_[n,k] * temp %*% t(temp) 
		}
		cov_[,,k] <- cov_[,,k] / Nk

		# Calculate mixture proportion
		pi_[k] <- Nk / N
	}

	## Judge convergence
	new_like <- likelihood(X, mean_, cov_, pi_)
	difference <- new_like - like
	if(difference < 0.001) break
	like <- new_like
	iter <- iter+1
	print(c(as.integer(iter), like))
}


### Visualize Result
## Prepare grid
eruptions <- seq(0.5, 6, by = 0.03)
waiting <- seq(40, 100, by = 0.03) 
Grid1 <- expand.grid(eruptions, waiting) 
names(Grid1) <- c("eruptions", "waiting")
Grid2 <- expand.grid(eruptions, waiting) 
names(Grid2) <- c("eruptions", "waiting")

## Probability on each point
Grid1 <- cbind(Grid1, prob=dmvnorm(Grid1, mean_[1,], cov_[,,1]))
Grid2 <- cbind(Grid2, prob=dmvnorm(Grid2, mean_[2,], cov_[,,2]))

result <- ggplot(NULL) +
						geom_contour(data=Grid1, aes(x = eruptions, y = waiting, z=prob, colour = rev(..level..))) +
						geom_contour(data=Grid2, aes(x = eruptions, y = waiting, z=prob, colour = rev(..level..))) +
						geom_point(data=data, aes(x=eruptions, y=waiting), shape=1, color='red') +
						theme(legend.position="none")
result
