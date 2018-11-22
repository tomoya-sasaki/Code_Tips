A <- 0.7
x <- seq(-5, 5, 0.5)
y <- 1.0 / (1.0 + exp( -x * A))
plot(x, y)
