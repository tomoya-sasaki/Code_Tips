#include <math.h>
#include <random>
#include <Eigen/Dense>

// Dirichlet
// Reference: http://wildpie.hatenablog.com/entry/20150419/1429435583
random_device rd;
mt19937 rng(rd());
VectorXd DirichletSampling(const VectorXd& alpha)
{
  VectorXd x(alpha.size());
  for (int i = 0; i < alpha.size(); i++)
  {
    std::gamma_distribution<double> gamma(alpha(i));
    x(i) = gamma(rng);
  }
  x /= x.sum();

  return x;
}

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

int multi1(VectorXd prob){
	// Multi(x, 1), return category index
	random_device rd;
	mt19937 rng(rd());
	std::uniform_real_distribution<double> uniform(0.0,1.0);

	double u = uniform(rng);
	double temp = 0.0;
	int index = 0;
	for(int i=0; i<prob.size(); i++){
		temp += prob(i);
		if(u < temp){
			index = i;
			break;
		}
	}
	return index;
}

// Random selection from a vector
int random_vec(vector<int> &vec){
   std::random_device rd;
   std::mt19937 rng(rd());
   std::uniform_int_distribution<int> dist(0, vec.size() - 1);

   int random_element = vec[dist(rng)];
   return random_element;
}
