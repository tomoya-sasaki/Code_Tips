data{
  int<lower=0> N; // number of observations
  int<lower=1> K; //number of category
  int count_level; // count_level (range of covariate)
  vector[N] covariate;// count_level (0:12)
  int<lower=1,upper=K> Y[N];
}
transformed data{
  vector[1] Zero_vec;
  Zero_vec = rep_vector(0, 1);
}
parameters{
  vector[K-1] beta_raw;
  vector[K-1] alpha_raw; // we need alpha for a linear model with one covariate
}
transformed parameters{
  vector[K] beta;
  vector[K] alpha;
  matrix[N, K] mu;
  beta = append_row(Zero_vec, beta_raw);
  alpha = append_row(Zero_vec, alpha_raw);
  mu = covariate * beta';
}
model{

  for(i in 1:N){
    Y[i] ~ categorical_logit(mu[i,]' + alpha); // make sure to transpose
  }

}
generated quantities{
  // Make prediction
  matrix[K, count_level] predicted; 
    // probability of observing category k with level count_level

  for(count in 1:count_level){ // count of topics
    predicted[ ,count] = softmax(beta * (count-1.0) + alpha);
  } 
}
