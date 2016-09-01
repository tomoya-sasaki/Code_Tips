#include <iostream>
#include <vector>
#include <cmath>
#include "Eigen/Dense"

using namespace std;
using namespace Eigen;

double Norm(VectorXd x, VectorXd mu, MatrixXd sigma){
    return exp(((x-mu).transpose() * sigma.inverse() * (x-mu)/(-2.0)).value()) 
        / sqrt(sigma.determinant())
        / pow(2.0*M_PI, x.size()/2.0);
}

int main() {
    const int D = 2; // dimension
    const int K = 2; // number of distribution
    int N;           // number of data
    vector<VectorXd> x;

    while(cin){
        double hoge;
        VectorXd tmp(D);
        for(int i=0; i<D; ++i){cin>>hoge; tmp(i)=hoge;}
        x.push_back(tmp);
    }

    // last data is null
    N = x.size()-1;
   
    VectorXd mu[K];     // mean vector
    MatrixXd sigma[K];  // covariant matrix
    double pi[K];       // mixture
    double eSize[K];     // effective cluster size (N_k in PRML)
    vector<vector<double> > gamma; // responsibility
    gamma.resize(N);
    for(int i=0; i<N; ++i) gamma[i].resize(K);
  
    // initialization
    for(int i=0; i<K; ++i) mu[i] = VectorXd::Zero(D);

    // initialize mu as mean of input
    VectorXd init_mu = VectorXd::Zero(D);
    for(int i=0; i<N; ++i) init_mu += x[i];
    init_mu /= N;

    mu[0] = 1.1 * init_mu;
    mu[1] = 0.9 * init_mu;

    for(int i=0; i<K; ++i) sigma[i] = MatrixXd::Identity(D, D);
    for(int i=0; i<K; ++i) pi[i] = 1.0/K;
    
    for(int loop = 0; loop < 20; ++loop){
        // E step
        for(int n=0; n<N; ++n){
            for(int k=0; k<K; ++k){
                double tmp = 0;
                for(int j=0; j<K; ++j){
                    tmp += pi[j] * Norm(x[n], mu[j], sigma[j]);
                }
                gamma[n][k] = pi[k] * Norm(x[n], mu[k], sigma[k]) / tmp;
            }
        }

        // M step
        for(int k=0; k<K; ++k){
           eSize[k] = 0;
           for(int n=0; n<N; ++n){
               eSize[k] += gamma[n][k];
            }
        }

        for(int k=0; k<K; ++k){
            VectorXd tmp_mu = VectorXd::Zero(D);
            for(int n=0; n<N; ++n){
                tmp_mu += gamma[n][k]*x[n];
            }
            mu[k] = tmp_mu / eSize[k];

            MatrixXd tmp_sigma = MatrixXd::Zero(D, D);
            for(int n=0; n<N; ++n) tmp_sigma += gamma[n][k]*(x[n]-mu[k])*(x[n]-mu[k]).transpose();
            sigma[k] = tmp_sigma / eSize[k];

            pi[k] = eSize[k] / N;
        }
        // show results
        cout << "start loop " << loop << ":" << endl;
        for(int k=0; k<K; ++k){
            cout << "pi" << k << ": " << pi[k] << endl;
            cout << "mu" << k << ": " << endl << mu[k] << endl;
            cout << "sigma" << k << ": " << endl << sigma[k] << endl;
        }
        cout << endl;
    }
}
