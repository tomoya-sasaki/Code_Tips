// Latent Dirichlet Allocation
// Collapsed Gibbs Sampling

// Include
#include <iostream>
#include <sstream>
#include <fstream>
#include <string>
#include <random>
#include <vector>
#include <numeric>
#include <math.h>

// Eigen
#include <Eigen/Dense>

using namespace std;
using namespace Eigen;

// Definition
random_device rd;
mt19937 rng(rd());
std::uniform_real_distribution<double> uniform(0.0,1.0);
// Fixed Parameters
char filepath[] = "data.txt";
int iters = 100;
int K=5; // Number of topics
double alpha = 50.0 / (double)K;
double beta = 0.01;


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
	int M; // number of document
	int K; // number of topic
	MatrixXd Ndk; // number of words assigned to the topic k in the document d
	MatrixXd Nkv; // number of times a word v assigned to a topic k
	int V=0; // unique number of words
	DATA_STRUCT *Z;

	Parameters(int docnum, int topicnum, DATA_STRUCT *data){
		M = docnum;
		K = topicnum;
		initialize_Zdi(data, K);
		count_unique_words(data, M);
	}
	void set_Ndk(int d, int k);
	void set_Nkv();
	void count_unique_words(DATA_STRUCT *data, int M);
	void initialize_Zdi(DATA_STRUCT *data, int K);
};


///////////////////////////
//       Functions       //
///////////////////////////
// File input and output
void read_data(DATA_STRUCT *data, const char *filepath, int data_len);

// Utilities
void num_docs(const char *filepath, int *data_len);

// Stat Functions
int multi1(VectorXd prob);

// Function Initialize
void initialize(DATA_STRUCT *data, Parameters *parameters, int M, int K);


// Function Gibbs
void Gibbs(DATA_STRUCT *data, Parameters *parameters);

// Function Loglikelihood
double llik(DATA_STRUCT *data, Parameters *parameters);

///////////////////////////
//          Main         //
///////////////////////////
int main() {
	int M=0; // Number of documents

	// Get the number of documents
	num_docs(filepath, &M);
	cout << "Number of Documents: " << M << endl;

	// Read Data
	DATA_STRUCT *data = new DATA_STRUCT[M];
	cout << "Data Reading..." << endl;
	read_data(data, filepath, M);
	cout << "Data Read" << endl;

	// Initialize
	Parameters parameters(M, K, data);
	initialize(data, &parameters, M, K);

	// Iteration
	cout << "Iteration start:" << endl;
	for(int iter=0; iter<iters; iter++){
		Gibbs(data, &parameters);

		if(iter % 10 == 0 & iter != 0){
			cout << "  Finished: " << iter << " times: "; 
			cout << "Log likelihood = " << llik(data, &parameters) << endl;
		}
	}

	return 0;
}  


///////////////////////////
//    Function Bodies    //
///////////////////////////
// Functions for Class: Parameters
void Parameters::count_unique_words(DATA_STRUCT *data, int M){
	for(int d=0; d<M; d++){
		int Nd = (data + d) -> words.size();
		for(int i=0; i<Nd; i++){
			int id_ = (data + d) -> words[i];
			if (V < id_)
				V = id_;
		}
	}
	V++; // num words = id + 1 if id starts from 0
	cout << "Unique number of words: " << V << endl;
}

void Parameters::set_Ndk(int d, int k){
	Ndk = MatrixXd::Zero(d,k);
}

void Parameters::set_Nkv(){
	Nkv = MatrixXd::Zero(K,V);
}

void Parameters::initialize_Zdi(DATA_STRUCT *data, int K){
	Z = new DATA_STRUCT[M];
	uniform_int_distribution<int> unirand(0,K-1);

	for(int d=0; d<M; d++){
		int Nd = (data + d) -> words.size();
		for(int i=0; i<Nd; i++){
			int rndnum = unirand(rng);
			Z[d].words.push_back(rndnum); // does not work if (Z+d) -> words
		}
	}
}


// Function: initialize
void initialize(DATA_STRUCT *data, Parameters *parameters, int M, int K){
	parameters -> set_Ndk(M, K);
	parameters -> set_Nkv();

	for(int d=0; d<M; d++){
		int Nd = (data + d) -> words.size();
		for(int i=0; i<Nd; i++){
			int topic = parameters -> Z[d].words[i];
			int word_id = (data + d) -> words[i]; 
			parameters -> Ndk(d,topic) += 1;
			parameters -> Nkv(topic, word_id) += 1;
		}
	}
}


// Function: Read Data
void read_data(DATA_STRUCT *data, const char *filepath, int data_len){
	ifstream ifs(filepath);
	string str, temp;
	int line_num = 0;
	int words_position = 0;

	if(ifs.fail()){
		cerr << "Reading file failed" << endl;
	}
	for(int m=0; m<data_len; m++){ // read file line by line
		getline(ifs, str);
		istringstream stream(str);

		while(getline(stream, temp, ' ')){ // analyze each line
			(data + line_num) -> words.push_back(stoi(temp)); // stoi: string to integer
		}
		line_num += 1;
	}
}


// Function: Get the number of documents 
void num_docs(const char *filepath, int *data_len){
	ifstream infile;
	infile.open(filepath);
	while(!infile.eof()){
		*data_len += 1;
		string line;
		getline(infile, line);
	}
	*data_len -= 1;
}


// Function: Multi(x, 1), return category index
int multi1(VectorXd prob){

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

// Function: Collapsed Gibbs Sampling
void Gibbs(DATA_STRUCT *data, Parameters *parameters){
	int V = parameters -> V;
	int M = parameters -> M;

	// Shuffle the order of documents
	vector<int> odoc(M);
	iota(begin(odoc), end(odoc), 0);

	for(int d=0; d<M; d++){
		int doc_id = odoc[d]; // document_id
		int Nd = (data + doc_id) -> words.size();

		for(int i=0; i<Nd; i++){
			int word_id = (data + doc_id) -> words[i];
			int topic = parameters -> Z[doc_id].words[i];

			parameters -> Nkv(topic, word_id) -= 1;
			parameters -> Ndk(doc_id, topic) -= 1;

			VectorXd prob_vec = VectorXd::Zero(K);
			for(int k=0; k<K; k++){
				int nkv = parameters ->  Nkv(k, word_id);
				int ndk = parameters ->  Ndk(doc_id, k);
				int nk = parameters -> Nkv.row(k).sum();
				int nd = Nd - 1;

			 	prob_vec(k) = ((double)nkv + beta) / ((double)nk + (double)V * beta ) * 
			 		((double)ndk + alpha) / ((double)nd + (double)K * alpha);
			}
			 
			prob_vec = prob_vec / prob_vec.sum();
			int new_topic = multi1(prob_vec);

			parameters -> Z[doc_id].words[i] = new_topic;
			parameters ->  Nkv(new_topic, word_id) += 1;
			parameters ->  Ndk(doc_id, new_topic) += 1;

		}
	}
}

double llik(DATA_STRUCT *data, Parameters *parameters){
	int V = parameters -> V;
	int M = parameters -> M;	

	double polyad = 0.0;
	for(int d=0; d<M; d++){
		double nd = parameters -> Ndk.row(d).sum();
		polyad += lgamma( K*alpha ) - lgamma(K*alpha + nd);

		for(int k=0; k<K; k++){
			polyad += lgamma( (parameters -> Ndk(d,k)) + alpha ) - lgamma(alpha);
		}
	}

	double polyaw = 0.0;
	for(int k=0; k<K; k++){
		double nw = parameters -> Nkv.row(k).sum();
		polyaw += lgamma(V*beta) - lgamma(V*beta + nw);

		for(int v=0; v<V; v++){
			polyaw += lgamma( (parameters -> Nkv(k,v)) + beta) - lgamma(beta);
		}
	}

	double llik = polyad + polyaw;
	return llik;
}
