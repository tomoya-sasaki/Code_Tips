// Reference: http://kivantium.hateblo.jp/entry/2015/08/17/235832

#include <iostream>
#include <vector>
#include <cmath>
// Used in ReadVector
#include <fstream>
#include <string>
#include <iomanip> // 小数点以下の出力
// Save Results
#include <cstdlib> // EXIT_FAILURE のため

#include "Eigen/Dense"

using namespace std;
using namespace Eigen;

/* Read File
	 Firstly, prepare the funcion to read the file
*/
#define MAXBUFSIZE  ((int) 1e6)
MatrixXd readMatrix(const char *filename)
    {
    int cols = 0, rows = 0;
    double buff[MAXBUFSIZE];

    // Read numbers from file into buffer.
    ifstream infile;
    infile.open(filename);
    while (! infile.eof())
        {
        string line;
        getline(infile, line);

        int temp_cols = 0;
        stringstream stream(line);
        while(! stream.eof())
            stream >> buff[cols*rows+temp_cols++];

        if (temp_cols == 0)
            continue;

        if (cols == 0)
            cols = temp_cols;

        rows++;
        }

    infile.close();

    rows--;

    // Populate matrix with numbers.
    MatrixXd result(rows,cols);
    for (int i = 0; i < rows; i++)
        for (int j = 0; j < cols; j++)
            result(i,j) = buff[ cols*i+j ];

    return result;
};

/*
 Normal Distribution
*/
double Norm(VectorXd x, VectorXd mu, MatrixXd sigma, int D){ //(2)式
    return exp(((x-mu).transpose() * sigma.inverse() * (x-mu)/(-2.0)).value()) 
        / sqrt(sigma.determinant())
        / pow(2.0*M_PI, D/2.0);
}

/*
 Main Part
*/
int main() {
	const int D=2; // Dimension
	const int K=2; // number of distribution
	int N; // number of Data
	MatrixXd x;

	x = readMatrix("faithful.txt"); // https://github.com/aidiary/PRML/blob/master/ch9/faithful.txt
	cout << "x.row(1).transpose(): \n" << x.row(1).transpose() << "\n" <<  endl;
	N = x.rows();

	VectorXd mu[K]; // mean vector
	MatrixXd sigma[K]; // covariance matrix
	VectorXd pi = VectorXd::Zero(K); // mixture
	VectorXd N_k = VectorXd::Zero(K); // effective cluster size
	MatrixXd gamma(N,K); // responsibility
	
	// Initialization
	for(int i=0; i<K; ++i) mu[i] = VectorXd::Zero(D);

	// Initialize mu as a mean of input
	VectorXd init_mu = VectorXd::Zero(D);
	for(int i=0; i<N; ++i) init_mu += x.row(i).transpose(); // add elements by row
	init_mu /= N;
	cout << "init_mu: \n" << init_mu << "\n" << endl;
	
	mu[0] = 1.1 * init_mu;
	mu[1] = 0.9 * init_mu;	
	cout << "mu[0]: \n" << mu[0] << "\n" <<  endl;

	for(int i=0; i<K; ++i) sigma[i] = MatrixXd::Identity(D, D);
	for(int i=0; i<K; ++i) pi[i] = 1.0/K;
	cout << "sigma[1]: \n" << sigma[1] << "\n" << endl; 
	cout << "pi[1]: \n" << pi[1] << "\n" << endl;
	cout << "Norm(x.row(1).transpose(), mu[0], sigma[0]): \n" << Norm(x.row(1).transpose(), mu[0], sigma[0], D) << endl;

	for(int i=0; i<25; ++i){
		// E Step
		for(int n=0; n<N; n++){
			for(int k=0; k<K; ++k){
				// Equation (8)
				double denominator=0;
				for(int j=0; j<K; ++j){
					denominator += pi[j] * Norm(x.row(n).transpose(), mu[j], sigma[j], D);
				}//for(j)
				
				gamma(n,k) = pi[k] * Norm(x.row(n).transpose(), mu[k], sigma[k], D) / denominator;
			}//for(k)
		}//for(n)

		// M Step
		for(int k=0; k<K; ++k){
			// N_k and mu
			VectorXd tmp_mu = VectorXd::Zero(D);
			N_k[k] = 0; // make it 0 before add up each time

			for(int n=0; n<N; ++n){
				N_k[k] += gamma(n,k);
				tmp_mu += gamma(n,k) * x.row(n).transpose();
			}//for(n)
			mu[k] = tmp_mu / N_k[k];

			MatrixXd tmp_sigma = MatrixXd::Zero(D, D);
			for(int n=0; n<N; ++n) tmp_sigma += gamma(n,k)*(x.row(n).transpose()-mu[k])*(x.row(n).transpose()-mu[k]).transpose();
				// Be careful when you use .row(n), it's a horizontal vector
			sigma[k] = tmp_sigma / N_k[k];
			
			pi[k] = N_k[k] / N;
		}//for(k)

		// Save Results
		for(int k=0; k<K; ++k){
			fstream fs;
			fs.open("em-output.txt", ios::out|ios::app); // Can write (append mode)
			if(!fs.is_open()){
				return EXIT_FAILURE;
			}
			fs << "Loop: " << i << " / Category: " << k << endl; 
			fs << "pi:\n" << pi[k] << "\nmu\n" << mu[k] << "\nsigma\n" << sigma[k] << "\n" << endl;
			fs.close();
		}//for(k)

	}//for(i)

}
