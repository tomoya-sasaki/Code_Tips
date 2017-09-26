# include <iostream>
# include <random>
#include <chrono>
using namespace std;

namespace randgen{
  // Default seed 
  int seed = chrono::system_clock::now().time_since_epoch().count();
  mt19937 mt(seed);
  mt19937 rand_gen = mt;

  void set_seed(int use_seed){
    mt19937 mt(use_seed);
    rand_gen = mt;
  }
  double bernoulli(double p){
    uniform_real_distribution<double> rand(0, 1);
    double r = rand(rand_gen);
    if(r > p){
      return 0;
    }
    return 1;
  }
  double gamma(double a, double b){
    gamma_distribution<double> distribution(a, 1.0 / b);
    return distribution(rand_gen);
  }
  double beta(double a, double b){
    double ga = gamma(a, 1.0);
    double gb = gamma(b, 1.0);
    return ga / (ga + gb);
  }
  double uniform(double min = 0.0, double max = 1.0){
    uniform_real_distribution<double> rand(min, max);
    return rand(rand_gen);
  }
}

int main(){
  int seed = 1234; // we can use the input from R
  randgen::set_seed(seed); // set seed

  for(int i=0; i<10; ++i){
    // Bernoulli
    cout << randgen::bernoulli(0.5) << " ";
    // Uniform
    cout << randgen::uniform(5.0, 10.0) << " ";
    // Gamma
    cout << randgen::gamma(1.0, 2.0) << " ";
    // Beta
    cout << randgen::beta(1.5, 2.5) << endl;
  }

}
