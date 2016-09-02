#include <iostream>
#include <vector> // KLの格納用
#include "Eigen/Dense"
// Eigenでは、vectorは縦ベクトルのようなので注意
#include <iomanip> // 小数点以下の表示に必要


using namespace std;
using namespace Eigen;

double calc_KL(VectorXd mu1, MatrixXd lambda1, VectorXd mu2, MatrixXd lambda2, int D){
	double KL;
	KL = (1.0/2.0) * (  (log(lambda2.determinant()) - log(lambda1.determinant())) +
			(lambda2.inverse() * lambda1).trace() + 
			(mu1-mu2).transpose() * lambda2.inverse() * (mu1-mu2) - (double)D );
	return KL;
}

//(1/2) * (  (  log(np.linalg.det(lambda2)) -  log(np.linalg.det(lambda1)) )   +\
//                 np.trace(inv(lambda2) * lambda1) +\
//            (mu1-mu2) * inv(lambda2) * (mu1-mu2).T - D )

int main(){
	int D=2; // Dimension
	double theta=2.0*M_PI/12.0;
	Matrix2d A;
 	A << cos(theta), -sin(theta), 
       sin(theta), cos(theta);
	
	VectorXd mu = VectorXd::Zero(D);

	Matrix2d temp;
	temp << 1.0, 0.0,
			 		0.0, 10.0;
	MatrixXd lambda = (A * temp.inverse() * A.transpose() ).inverse();

	// Initialize
	VectorXd mu_h = VectorXd::Random(D);
	MatrixXd lambda_h = MatrixXd::Random(D,D);

	// Iteration
	int max_iter = 16;	
	vector<double> KL_result;

	for(int i=0; i<max_iter; i++){
		mu_h[0] = mu[0] - 1/lambda(0,0) * lambda(0,1) * (mu_h[1] - mu[1]);
		lambda_h(0,0) = lambda(0,0);

		mu_h[1] = mu[1] - 1/lambda(1,1) * lambda(1,0) * (mu_h[0] - mu[0]);
		lambda_h(1,1) = lambda(1,1);

		// calculate KL divergence
		KL_result.push_back(calc_KL(mu_h, lambda_h, mu, lambda, D));
	}//for(i)

	// Show results
	for (auto x: KL_result) {
	        cout << fixed << setprecision(5) << x << endl;
	}
	return 0;
	
}
