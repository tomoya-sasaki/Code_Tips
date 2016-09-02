#include <math.h>


double pnorm(double x, double mean, double sd){
	//Cumulative Distribution Function (CDF) Calculator for the Normal Distribution (distribution function)
	double result=0.50000 * ( 1.00000 + erf( (x-mean) / (sd * sqrt(2.0000)  )  )    );
	return result;
}


double dnorm(double x, double mean, double sd){
	// Probability Density Function
	double result= (1 / (sd * sqrt(2 * M_PI))) * exp(- ( pow((x-mean),2) / (2 * pow(sd,2))));
	return result;
}


VectorXd sample(VectorXd x, int size, VectorXd prob){
// Weighted Random Generation http://goo.gl/mr5d8G 
// Require Eigen
//// Vector3d prob(0.2,0.2,0.6); // mixture rate (sum is 1)
//// size: the number you want to get
	double rnd;
	VectorXd prob_total(prob.count()); 
	double running_total = 0.0;
	VectorXd result(size);

	for(int i=0; i<prob.count(); i++){ 
		running_total += prob[i];
		prob_total[i] = running_total;
  }

	random_device seed_gen; // http://cpprefjp.github.io/reference/random.html
	mt19937 engine(seed_gen());
	uniform_real_distribution<> dist1(0.0, 1.0);
	for(int i=0; i<size; i++){
		rnd = dist1(engine) * running_total;

		for(int s=0; s<prob.count(); s++){ // x.count() = prob.count()
			if (rnd < prob_total[s]){
				result[i] = x[s];
				break;
			}//end if
		}//end for(s)

	}//end for(i)

	return result;
}// end function(sample)


double rnorm(double mean, double sd){
	// random generation for the normal distribution
	random_device seed_gen; // http://cpprefjp.github.io/reference/random.html
	mt19937 engine(seed_gen());
  normal_distribution<double> distribution(mean, sd);

	return distribution(engine);
}
