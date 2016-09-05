// Reference: http://d.hatena.ne.jp/chrofieyue/20111128/1322486240
#include <iostream>
#include <vector> // KLの格納用
#include "Eigen/Dense"
// Eigenでは、vectorは縦ベクトルのようなので注意
#include <iomanip> // 小数点以下の表示に必要
// Used in ReadVector
#include <fstream>
#include <string>
// Save Results
#include <cstdlib> // EXIT_FAILURE のため


using namespace std;
using namespace Eigen;

/* Read Useful Functions */
#include "psi.h" // Digamma (downloaded from CODECOGS)
#include "eigenmvn.cpp" // Multi Variate Normal Using Eigen

// logsumexp Reference: http://d.hatena.ne.jp/echizen_tm/20100628/1277735444
double logsumexp(double x, double y, bool flg){
	if(flg) return y; // init mode
	if(x==y) return x + 0.69314718055; // log(2)
		double vmin = std::min (x,y);
		double vmax = std::max (x,y);
		if (vmax > vmin + 50){
			return vmax;
		}else{
			return vmax + std::log(std::exp(vmin-vmax) + 1.0);
		}
}



/* 
  Read File
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

/* Various Functions Used in VB-E-Step 
 	Dirichlet
	Wishart
	Normal
	Normalization of Responsibility
*/
// Dirichlet
VectorXd expect_pi(VectorXd alpha){
	return alpha.array() / alpha.sum();
}

VectorXd expect_lpi(VectorXd alpha){
	int len = alpha.size();
	double temp = Maths::Special::Gamma::psi(alpha.sum());
	VectorXd ret = VectorXd::Zero(len);

	for(int i=0; i<len; i++){
		ret(i) =  Maths::Special::Gamma::psi(alpha(i)) - temp;
	}
	return ret;
}

// Wishart
double expect_llambda(MatrixXd Wk, double nu_k){
	int ndim = Wk.cols();
	double arr = 0.0;

	for(int index=0; index<ndim; index++){
		double i = (double)index + 1.0;
		arr = Maths::Special::Gamma::psi((nu_k + 1.0 - i)/2.0);
	}

	return (arr + ndim * log(2) + log(Wk.determinant()));
}

MatrixXd expect_lambda(MatrixXd Wk, double nu_k){
	return Wk * nu_k;
}

// Normal
VectorXd expect_quad(MatrixXd x, VectorXd mk, double beta_k, MatrixXd Wk, double nu_k){ // Part of PRML(10.46)
	int ndim = x.cols();
	int nrow = x.rows();
	VectorXd res = VectorXd::Zero(nrow);

	for(int xrow=0; xrow<nrow; ++xrow){
		res(xrow) = (double)ndim / beta_k + ( nu_k * (x.row(xrow).transpose() - mk).transpose() * Wk * (x.row(xrow).transpose() - mk) ).value();
			// x.row() seems to create a horizontal vector
	}

	return res;
}

VectorXd expect_log(MatrixXd x, VectorXd mk, double beta_k, MatrixXd Wk, double nu_k){ // Part of PRML(10.46)
	int ndim = x.cols();
	int nrow = x.rows();
	VectorXd res = VectorXd::Zero(nrow);

	double ex_llambda = expect_llambda(Wk, nu_k);
	VectorXd ex_quad = expect_quad(x, mk, beta_k, Wk, nu_k);
	res = (ex_llambda - (double)ndim * log(2*M_PI) - ex_quad.array()) / 2.0;
		// you need .array() to calculate element by element
		 
	return res;
}

// Normalization of Responsibility
MatrixXd normalize_response(MatrixXd lrho){
	int num = lrho.rows();
	int num_class = lrho.cols();
	MatrixXd ret = MatrixXd::Zero(num, num_class);

	for(int rowindex=0; rowindex<num; ++rowindex){
		VectorXd lrho_row = lrho.row(rowindex);

		double temp=0.0;
		for(int k=0; k<num_class; ++k){
			temp = logsumexp(temp, lrho_row(k), (k==0));
		}

		ret.row(rowindex) = exp(lrho_row.array() - temp);

		for(int k=0; k<num_class; ++k){ //avoid zero
			if(ret(rowindex, k) < 1e-10) ret(rowindex, k) = 1e-10;
		}

		ret.row(rowindex) = ret.row(rowindex).array() / ret.row(rowindex).sum();
	}//for rowindex

	return ret;
}


/* Various Functions Used in VB-M-Step 
	Calculate x_bar PRML(10.52)	
	Calculate S PRML(10.53)
	Calculate m PRML(10.61)
	Calculate W PRML(10.62)
*/
MatrixXd calc_xbar(MatrixXd x, MatrixXd r_nk){
	int num = x.rows();
	int ndim = x.cols();
	int num_class = r_nk.cols();
	MatrixXd ret = MatrixXd::Zero(num_class, ndim);

	for(int k=0; k<num_class; ++k){
		VectorXd clres = r_nk.col(k);
		VectorXd temp = VectorXd::Zero(ndim);
		for(int i=0; i<num; i++){
			temp += clres(i) * x.row(i);
		}
		ret.row(k).array() = temp.array() / clres.sum();
		
	}

	return ret;
}

MatrixXd calcu_m(MatrixXd xbar, VectorXd Nk, VectorXd m0, double beta0, VectorXd beta){
	int num_class = xbar.rows();
	int ndim = xbar.cols();
	MatrixXd ret = MatrixXd::Zero(num_class, ndim);

	for(int k=0; k<num_class; ++k){
		VectorXd temp = (beta0 * m0 + (Nk(k) * xbar.row(k)).transpose()).array() / beta(k);
		ret.row(k) = temp;
	}
	return ret;
}


typedef struct{ // there is no three-dimensional array in C++ like in Python
	MatrixXd S_k;
	MatrixXd W_k;
}KEEP_RES; // create for the number of class

void calc_S(KEEP_RES *Keep_Res, MatrixXd x, MatrixXd xbar, MatrixXd r_nk, int class_index){
	int num = x.rows();
	int ndim = x.cols();	
	int num_class = r_nk.cols();
	MatrixXd ret = MatrixXd::Zero(ndim, ndim);

	VectorXd clres = r_nk.col(class_index);
	MatrixXd temp = MatrixXd::Zero(ndim, ndim);
	VectorXd diff_i = VectorXd::Zero(ndim);
	for(int i=0; i<num; ++i){
		temp = temp + clres(i) * diff_i * diff_i.transpose();
	}
	ret = temp.array() / clres.sum();
	Keep_Res->S_k = ret;
}

void calc_W(KEEP_RES *Keep_Res, MatrixXd xbar, MatrixXd Sk, VectorXd Nk, VectorXd m0, double beta0, MatrixXd inv_W0, int class_index){
	int num_class = xbar.rows();
	int ndim = xbar.cols();
	MatrixXd ret = MatrixXd::Zero(ndim, ndim);
	double frac = 0.0;

	ret = inv_W0 + Nk(class_index) * Sk;
	frac = beta0 * Nk(class_index) / (beta0 + Nk(class_index));
	ret = ret + frac * (xbar.row(class_index).transpose() - m0) * (xbar.row(class_index).transpose() - m0).transpose();
		// xbar.row(class_index) - m0 is horizontal
	ret = ret.inverse();

	Keep_Res->W_k = ret;
}



int main(){

	/* Read File */
	int num; // number of Data
	int ndim; // number of dimension
	MatrixXd x; // store data
	x = readMatrix("faithful.txt"); // https://github.com/aidiary/PRML/blob/master/ch9/faithful.txt
	num = x.rows();
	ndim = x.cols();
	cout << "num: " << num << " / ndim: " << ndim << endl;

	/* Initialization */
	int num_class = 6;
	int num_iter = 120;
	VectorXd alpha0 = VectorXd::Constant(num_class, 1e-3); // vertical vector
	double beta0 = 1e-3;
	VectorXd m0 = VectorXd::Zero(ndim); // vertical vector
	MatrixXd W0 = MatrixXd::Identity(ndim, ndim);
	MatrixXd inv_W0 = W0.inverse();
	double nu0 = 1.0;
	std::srand((unsigned int) time(0)); // for Random
	MatrixXd r_nk = MatrixXd::Random(num,num_class); // Initialize Responsibility (VB-E Step)
	for(int i=0; i<num; ++i) r_nk.row(i) = r_nk.row(i).array() / r_nk.row(i).sum();

	KEEP_RES *Keep_Res = new KEEP_RES[num_class]; // there is no three-dimensional array in C++ like in Python
	VectorXd Nk = VectorXd::Zero(num_class);
	VectorXd alpha = VectorXd::Zero(num_class);
	VectorXd beta = VectorXd::Zero(num_class);
	MatrixXd xbar = MatrixXd::Zero(num_class, ndim);
	MatrixXd mk = MatrixXd::Zero(num_class, ndim);
	VectorXd nu = VectorXd::Zero(num_class);

	VectorXd ex_lpi = VectorXd::Zero(num_class);
	MatrixXd ex_log = MatrixXd::Zero(num, num_class);
	MatrixXd lrho = MatrixXd::Zero(num, num_class);

	/* Run */
	for(int iter=0; iter<num_iter; ++iter){
		// VB-M Step (Dirichlet)
		Nk = r_nk.colwise().sum();
		alpha = alpha0 + Nk;

		// VB-M Step (Normal-Wishart)
		xbar = calc_xbar(x, r_nk);
		for(int k=0; k<num_class; ++k) calc_S(&Keep_Res[k], x, xbar, r_nk, k); 
		beta = beta0 +  Nk.array();
		mk = calcu_m(xbar, Nk, m0, beta0, beta);
		for(int k=0; k<num_class; ++k) calc_W(&Keep_Res[k], xbar, Keep_Res[k].S_k, Nk, m0, beta0, inv_W0, k);
		nu = nu0 + Nk.array();

		// VB-E Step
		ex_lpi = expect_lpi(alpha);
		for(int k=0; k<num_class; ++k) ex_log.col(k) = expect_log(x, mk.row(k), beta(k), Keep_Res[k].W_k, nu(k));
		for(int i=0; i<num; ++i) lrho.row(i) = ex_lpi.transpose() + ex_log.row(i);
		r_nk = normalize_response(lrho);
	}

	cout << "Nk:\n" << Nk << "\n" << endl;
	//cout << "Nk:\n" << Nk * 0.5<< "\n" << endl;
	cout << "alpha:\n" << expect_pi(alpha) << "\n" <<endl;
	cout << "mk:\n" << mk << "\n" <<endl;


	/* Plot Results */
	VectorXd expected_pi = VectorXd::Zero(num_class);
	expected_pi = expect_pi(alpha);
	Nk = r_nk.colwise().sum();

	// Generate mu_k using m_k
	IOFormat CommaInitFmt(StreamPrecision, DontAlignCols, ",", ",", "", "", "", "");

// If there is already a file, clear it
		fstream fs;
		fs.open("VBGMM-output.txt", ios::out | ios::trunc); // Overwright
		if(!fs.is_open()){
			return EXIT_FAILURE;
		}
		fs << "parameter,class,value1,value2" << endl;
		fs.close();

	VectorXd mean = VectorXd::Zero(ndim);
	for(int k=0; k<num_class; ++k){
		mean = mk.row(k);
		MatrixXd covar = MatrixXd::Zero(ndim, ndim);
		covar = beta(k) * expect_lambda(Keep_Res[k].W_k, nu(k));
		Eigen::EigenMultivariateNormal<double> normX_solver(mean,covar);

		fstream fs;
		fs.open("VBGMM-output.txt", ios::out|ios::app); // Can write (append mode)
		if(!fs.is_open()){
			return EXIT_FAILURE;
		}
		fs << "mu," << k << "," << normX_solver.samples(10000).rowwise().mean().transpose().format(CommaInitFmt) << endl;
		fs << "alpha," << k << "," << expected_pi(k) << endl;
		fs << "nk," << k << "," << Nk(k) << endl;
		fs.close();
	}

	return 0;
	
}
