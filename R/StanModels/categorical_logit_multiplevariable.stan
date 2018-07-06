data{
  int<lower=0> N;
  int<lower=1> K; //number of category
  int<lower=1> M; // number of covariates
  int count_level; // count_level (range of one of the covariates)
  matrix[N, M] covariates;// We suppose risk (binary) and count_level (0:12)
  int<lower=1,upper=K> Y[N];
}
transformed data{
  // Check Ahiru-book
  vector[M] Zero_vec;
  Zero_vec = rep_vector(0, M);
}
parameters{
  matrix[M, K-1] beta_raw;
}
transformed parameters{
  matrix[M, K] beta;
  matrix[N, K] mu;
  beta = append_col(Zero_vec, beta_raw);
  mu = covariates*beta;
}
model{

  for(i in 1:N){
    Y[i] ~ categorical_logit(mu[i,]'); // make sure to transpose
  }

}
generated quantities{
  // Make predictions for each level of risk
  matrix[K, count_level] predicted_risk0; 
  matrix[K, count_level] predicted_risk1; 
  vector[M] cov_pred;
    // probability of observing category k with level count_level

  for(count in 1:count_level){ // count of topics
    cov_pred[1] = 1;
    cov_pred[2] = count-1.0;
    predicted_risk0[ ,count] = softmax(beta' * cov_pred);

    cov_pred[1] = 2;
    cov_pred[2] = count-1.0;

    predicted_risk1[ ,count] = softmax(beta' * cov_pred);
  } 
}
