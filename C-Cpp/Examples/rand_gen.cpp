// namespace, random number generator

# include <iostream>
# include <random>
#include <chrono>
using namespace std;

namespace randgen{
  // Default random sapler
  mt19937::result_type seed = chrono::system_clock::now().time_since_epoch().count();
  auto uniform_0_1 = bind(uniform_real_distribution<double>(0,1), mt19937(seed));

  void set_seed(int &use_seed){
    seed = use_seed;
    uniform_0_1 = bind(uniform_real_distribution<double>(0,1), mt19937(seed));
  }
  double bernoulli(double &p){
    double r = uniform_0_1();
    if(r > p){
      return 0;
    }
    return 1;
  }
  double uniform(double min=0.0, double max=1.0){
    auto uniform = bind(uniform_real_distribution<double>(min,max), mt19937(seed));
    return uniform();
  }
  double gamma(double a, double b){
    auto gamma = bind(gamma_distribution<double>(a, 1.0 / b), mt19937(seed));
    return gamma();
  }
  double beta(double a, double b){
    double ga = gamma(a, 1.0);
    double gb = gamma(b, 1.0);
    return ga / (ga + gb);
  }

}

int main(){
  int seed = 50; // we can use the input from R
  randgen::set_seed(seed);

  double p = 0.2;
  for(int i=0; i<10; ++i){
    cout << randgen::bernoulli(p) << '\n';
  }

  // Uniform
  cout << randgen::uniform(5.0, 10.0) << endl;
  // Gamma
  cout << randgen::gamma(1.0, 2.0) << endl;
  // Beta
  cout << randgen::beta(1.5, 2.5) << endl;
}
