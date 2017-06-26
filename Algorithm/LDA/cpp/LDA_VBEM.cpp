// Variational EM for LDA
// Does not update \alpha
// Before run this code, create (sparse) document-term matrix in R
#include <Rcpp.h>
#include <RcppEigen.h>
#include <random>
#include <math.h>
#include <iostream>
#include <vector>
#include <numeric>
#include <chrono>
using namespace std;
using namespace Rcpp;
using namespace Eigen;


#include <boost/math/special_functions/digamma.hpp> // for digamma
using namespace boost::math;

// Use c++11 and link functions to R
// [[Rcpp::plugins("cpp11")]]
// [[Rcpp::depends("RcppEigen")]]
// [[Rcpp::depends("BH")]]


///////////////////////////
//      Definitions      //
/////////////////////////// 
random_device rd;
mt19937 rng(rd());
// Dirichlet
VectorXd rdirichlet(const VectorXd& alpha);
// Uniform
std::uniform_real_distribution<double> uniform(0.0,1.0);

///////////////////////////
//        Structs        //
/////////////////////////// 
// Store data
typedef struct{
	vector<int> words; // Store Word IDs
}DATA_STRUCT;


///////////////////////////
//        Classes        //
/////////////////////////// 
class Parameters{
public: 
	int N; // number of Docs
	int L; // number of Topics
	int K; // Unique number of words
	// LDA parameters
	VectorXd alpha; // [l]
	MatrixXd beta; // [l,k], in log-scale
	// Variational parameters
	// Phi is defined when initialized
	MatrixXd gamma; // [i,l]
	double ***phi; // [i,j,l]
	// Data
	VectorXi Ni_vec; // number of words in document i 
	// Return variables
	NumericVector lower_bound;
	List Z;
	List TopWordIDs;

	// Functions
	Parameters(int docnum, int topicnum, int uwordnum,
			VectorXi Ni); // constructor
	~Parameters(); // destructor
	double calc_lowerbound(DATA_STRUCT *data); // calculate lower bound using the current parameters
	void createZ();
	void createTopWordIDs(int num=10);
};


///////////////////////////
//   Function Headers    //
///////////////////////////f

// Count the number of words in a document i 
VectorXi count_words(const SparseMatrix<int>& dtm, int *docnum);

// logsumexp
double two_logsumexp(double x, double y, bool flg);
double logsumexp(VectorXd a);

// Variational EM
void iteration(DATA_STRUCT *data, SparseMatrix<int> dtm, Parameters *parameters,
		int *max_conv);

// Create Data
void data_create(DATA_STRUCT *data, const SparseMatrix<int>& dtm, int *K, int *N);

// Convert c++ array to Eigen matrix
MatrixXd Array2DToEigenMatrix(double **data, int row, int col);
MatrixXd Array3DToEigenMatrix(double ***data, int row, int col, int axis);

// Sort vector
vector<size_t> sort_indexes(const vector<int> v, int ascending);

void test(Parameters *parameters, DATA_STRUCT *data){
	// Function to return test output
	//cout << parameters -> gamma.row(1) << endl;
	//cout << parameters -> phi[1][2][1] << endl;
	//cout << parameters -> theta.row(1) << endl;
}


///////////////////////////
//          Main         //
/////////////////////////// 
// [[Rcpp::export]]
List LDA_VEM(MappedSparseMatrix<int> dtm, 
		int docnum, int topicnum, int uwordnum,
		int max_iter=20, int max_conv=300)
{
	// Create data
	DATA_STRUCT *data = new DATA_STRUCT[docnum];
	data_create(data, dtm, &uwordnum, &docnum);

	
	// Initialization
	VectorXi Ni_vec = count_words(dtm, &docnum);
	Parameters parameters(docnum, topicnum, uwordnum, Ni_vec);
	cout << "Initialization finished." << endl;

	// Inference
	cout << "Iteration starts." << endl;
	for(int iter=0; iter<max_iter; iter++){
		auto start = std::chrono::system_clock::now();

		cout << "Iteration: " << iter << "....." << endl;
		iteration(data, dtm, &parameters, &max_conv);

		auto dur = std::chrono::system_clock::now() - start;
		auto msec = std::chrono::duration_cast<std::chrono::seconds>(dur).count();
		cout << "   " << msec << " sec for this iteration" << endl;
	}

	// Create Return Object
	parameters.createZ();
	parameters.createTopWordIDs(30);
	List return_list = List::create(Named("lower_bound") = parameters.lower_bound,
			Named("Z") = parameters.Z,
			Named("TopWordIDs") = parameters.TopWordIDs );

	test(&parameters, data);

	return return_list;
}


///////////////////////////
//       Functions       //
/////////////////////////// 

void iteration(DATA_STRUCT *data, SparseMatrix<int> dtm, Parameters *parameters, int *max_conv)
{
	cout.precision(12);
	int word = 0;
	double beta_value = 0.0;
	double res_lse = 0.0;
	double gamma_sum = 0.0;
	double phi_sum = 0.0;
	double beta_sum = 0.0;

	// E-Step
	double lower_bound_old = parameters -> calc_lowerbound(data);
	double lower_bound_new = 0.0;
	cout << "   " << lower_bound_old << " --> ";
	int count = 0;
	int count_total = 0;
	while(1){
		//// phi
		for(int i=0; i < parameters -> N; i++){
			for(int j=0; j < parameters -> Ni_vec(i); j++){
				word = (data+i) -> words[j];
				
				res_lse = 0.0; // store the value of logsumexp
				for(int l=0; l < parameters -> L; l++){
					beta_value = parameters -> beta(l, word);
					parameters -> phi[i][j][l] 
						 = beta_value + boost::math::digamma( parameters -> gamma(i,l) );
						// betas are stored in log-scale

					res_lse = two_logsumexp(res_lse, parameters -> phi[i][j][l], (l==0));
				}
				// Normalization
				for(int l=0; l < parameters -> L; l++){
					parameters -> phi[i][j][l] 
							 = parameters -> phi[i][j][l] - res_lse;
				}
			}
		}

		//// gamma
		for(int i=0; i < parameters -> N; i++){
			for(int l=0; l < parameters -> L; l++){
				gamma_sum = 0.0;
				for(int j=0; j < parameters -> Ni_vec(i); j++){
					gamma_sum += exp( parameters -> phi[i][j][l] );
						// phi is stored in log-scale
				}
				parameters -> gamma(i,l) = (parameters -> alpha(l)) + gamma_sum;
			}
		}

		if(count > 8){
			// Since calculating lower bound is coputationally expensive, 
			// run 8 times without checking lower bound
			lower_bound_new = parameters -> calc_lowerbound(data);
			if(lower_bound_new - lower_bound_old < 0.0001 | count_total > (*max_conv))
				break;
			lower_bound_old = lower_bound_new;
			count = 0;
		}
		//cout << "."; //<< lower_bound_new << endl;
		count += 1;
		count_total += 1;
	}
	cout << lower_bound_new << endl;
	// Store parameter
	parameters -> lower_bound.push_back(lower_bound_new);


	// M-Step
	// beta
	for(int l=0; l < parameters -> L; l++){
		beta_sum = 0.0;

		for(int k=0; k < parameters -> K; k++){
			phi_sum = 0.0;

			for(int i=0; i < parameters -> N; i++){
				for(int j=0; j < parameters -> Ni_vec(i); j++){
					if( (data+i) -> words[j] ==k )
						phi_sum += exp( parameters -> phi[i][j][l] );

				} // for j
			} // for i
			parameters -> beta(l, k) = log(phi_sum);

			beta_sum = two_logsumexp(beta_sum, log(phi_sum), (k==0));
		} // for k
		
		// Normalization
		for(int k=0; k < parameters -> K; k++)
			parameters -> beta(l,k) -= beta_sum;
	} // for l

}

double Parameters::calc_lowerbound(DATA_STRUCT *data)
{
	double lower_bound = 0.0;

	for(int i=0; i<N; i++){
		lower_bound += lgamma( (double)alpha.sum() ); // first term

		for(int l=0; l<L; l++){
			lower_bound -= lgamma( (double)alpha(l) ); // second term

			lower_bound += (alpha(l) - 1.0) * ( digamma(gamma(i,l)) - digamma(gamma.row(i).sum())  ); // third term
		} // for l

		for(int j=0; j<Ni_vec(i); j++){
			for(int l=0; l<L; l++){
				lower_bound += exp(phi[i][j][l]) * ( digamma(gamma(i,l)) - digamma(gamma.row(i).sum()) ); // fourth term

				for(int k=0; k<K; k++){
					if( (data+i) -> words[j] ==k )
						lower_bound += exp(phi[i][j][l]) * beta(l,k); // fifth term
							// beta is stored in log-scale
				} // for k
			} // for l
		} // for j

		lower_bound -= lgamma( gamma.row(i).sum() ); // sixth term

		for(int l=0; l<L; l++){
			lower_bound += lgamma( gamma(i,l) ); // seventh term
			lower_bound -= (gamma(i,l) - 1) * ( digamma(gamma(i,l)) - digamma(gamma.row(i).sum()) ); // eighth term
			
			for(int j=0; j<Ni_vec(i); j++){
				lower_bound -= exp(phi[i][j][l]) * phi[i][j][l]; // nineth term
			}
		}

	} // for i

	return lower_bound;
}


Parameters::Parameters(int docnum, int topicnum, int uwordnum,
		VectorXi Ni)
{
	// constructor

	// Insert values
	N = docnum;
	L = topicnum;
	K = uwordnum;
	Ni_vec = Ni;

	// Initialization = randomly insert values
	//// alpha
	alpha = VectorXd::Constant(L, 1.0); // alpha has a fixed value

	//// gamma
	gamma = MatrixXd::Zero(N,L);
	for(int i=0; i<N; i++){
		for(int l=0; l<L; l++){
			gamma(i,l) = alpha(l) + (double)Ni_vec(i)/L;
		}
	}
	

	//// beta, log-scale
	beta = MatrixXd::Zero(L,K);
	for(int l=0; l<L; l++){
		for(int k=0; k<K; k++){
			beta(l,k) = log( uniform(rng) );
		}
		beta.row(l) = beta.row(l).array() - logsumexp(beta.row(l)); // normalization
	}

	/// phi, log-scale
	double invL = 1.0/(double)L;
	phi = new double**[N];
	for(int i=0; i<N; i++){
		phi[i] = new double*[Ni_vec(i)];

		for(int j=0; j < Ni_vec(i); j++){
			phi[i][j] = new double[L];

			for(int l=0; l<L; l++){
				phi[i][j][l] = log(invL);
			}
		}
	}


} // Parameters:Parameters ... constructor

void Parameters::createZ(){
	// Create output: Z (topic assignments for each document)
	MatrixXd temp;
	VectorXd::Index topic_id;
	
	for(int i=0; i<N; i++){
		NumericVector docZ;
		temp = Array3DToEigenMatrix(phi, Ni_vec(i), L, i); 
					// prop of topic assignment dist for each word
		for(int j=0; j<Ni_vec(i); j++){
			temp.row(j).exp().maxCoeff(&topic_id);
			docZ.push_back(topic_id);
		}
		Z.push_back(docZ);
	}
}

void Parameters::createTopWordIDs(int num){
	// Create output: Show top wordsID in each topic

	for(int l=0; l<L; l++){
		vector<int> temp_betas (beta.row(l).data(), beta.row(l).data() + beta.row(l).size() );
		vector<size_t> sorted = sort_indexes(temp_betas, 0); // return sorted index
		NumericVector tempid;

		for(int i=0; i<num; i++){
			tempid.push_back( sorted[i] + 1 ); // adjust id for R
				// in C++, index starts from 0 while 1 in R
		}

		TopWordIDs.push_back(tempid);
	}

}

Parameters::~Parameters(){
	// Delete array (free memory)
	// phi[i][j][l]
	for(int i = 0; i < N; i++){
		for(int j=0; j < Ni_vec(i); j++)
				delete[] phi[i][j];
		delete[] phi[i];
	}
	delete[] phi;
}


void data_create(DATA_STRUCT *data, const SparseMatrix<int>& dtm, int *K, int *N)
{
	int word_count = 0;
	VectorXi word_list = VectorXi::Zero(*K);

	for(int i=0; i<(*N); i++){
		word_list = dtm.row(i);
		for(int k=0; k<(*K); k++){
			word_count = word_list(k);
			if(word_count > 0){
				for(int count=0; count<word_count; count++)
					(data + i) -> words.push_back(k);
			}
		}
	}
}


VectorXi count_words(const SparseMatrix<int>& dtm, int *docnum)
{
	// Count the number of words in a document i
	VectorXi Ni_vec = VectorXi::Zero(*docnum);

	for(int i=0; i<(*docnum); i++){
		Ni_vec(i) = (int)dtm.row(i).sum();
	}
	
	return Ni_vec;
}

VectorXd rdirichlet(const VectorXd& alpha)
{
  VectorXd x(alpha.size());
  for (int i = 0; i < alpha.size(); i++)
  {
		std::gamma_distribution<double> randgamma(alpha(i));
    x(i) = randgamma(rng);
  }
  x /= x.sum();

  return x;
}


double two_logsumexp(double x, double y, bool flg)
{
	if (flg) return y; // init mode
	if (x == y) return x + 0.69314718055; // log(2)
	double vmin = std::min (x, y);
	double vmax = std::max (x, y);
	if (vmax > vmin + 50) {
	return vmax;
	} else {
	return vmax + std::log (std::exp (vmin - vmax) + 1.0);
	}
}

double logsumexp(VectorXd a)
{
	double result = 0.0;

	for(int i=0; i<a.size(); i++){
		result = two_logsumexp(result, a(i), (i==0));
	}

	return result;
}

vector<size_t> sort_indexes(const vector<int> v, int ascending) 
{
  // initialize original index locations
  vector<size_t> idx(v.size());
  iota(idx.begin(), idx.end(), 0);

  // sort indexes based on comparing values in v
	if(ascending){
		sort(idx.begin(), idx.end(),
				 [&v](size_t i1, size_t i2) {return v[i1] < v[i2];});
	}else{
		sort(idx.begin(), idx.end(),
				 [&v](size_t i1, size_t i2) {return v[i1] > v[i2];});
	}

  return idx;
}

// Eigen related functions
MatrixXd Array2DToEigenMatrix(double **data, int row, int col)
{
  MatrixXd Emat(row, col);
  for(int r=0; r<row; r++){
    Emat.row(r) = VectorXd::Map(&(data[r][0]), col);
  }

  return Emat;
}

MatrixXd Array3DToEigenMatrix(double ***data, int row=0, int col=0, int axis=0)
{
  // axis: which dimension you slice the array
  // [axis][row][col]
  
  double **array;
  array = new double *[row];
  for(int r=0; r<row; r++){
    array[r] = new double[col];
    
    for(int c=0; c<col; c++){
      array[r][c] = data[axis][r][c];
    }

  }

  return Array2DToEigenMatrix(array, row, col);

}
