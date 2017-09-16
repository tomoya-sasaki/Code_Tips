# Function

## Table of Contents
1. [Function as a pointer](#function-as-a-pointer)

## Function as a pointer
```cpp
#include <iostream>
#include <string>
#include <Eigen/dense>
using namespace std;
using namespace Eigen;

void calc(VectorXd (*calc_function)(VectorXd&), VectorXd &vec){
  (*calc_function)(vec);
}

VectorXd calc_times2(VectorXd &vec){
  vec = vec * 2.0;
  cout << vec.transpose() << endl;
  return vec;
}
 
class TestClass{
public:
  TestClass(){
    calc();
  }

  VectorXd calc(){
    VectorXd input_vec = VectorXd::LinSpaced(4,1,4);
    VectorXd (*fcalc2)(VectorXd&) = &calc_times2;
  
    VectorXd vec = calc_class(fcalc2, input_vec);
    return vec;
  }
  
  VectorXd calc_class(VectorXd (*calc_function)(VectorXd&), VectorXd &vec){
    VectorXd return_vec = (*calc_function)(vec);
    return return_vec;
  }

  static void print_sentence(string &str){
    cout<< str << endl;
  }
};

void execute(void (*get_func)(string&), string &st){
  (*get_func)(st);
}

int main(){
  // Use a function in a class 
  void (*fptr)(string&) = &TestClass::print_sentence;
  string sentence = "Test sentence";
  execute(fptr, sentence);

  // Create vector
  VectorXd input_vec = VectorXd::LinSpaced(4,1,4);

  // Use function outside the class
  VectorXd (*fcalc1)(VectorXd&) = &calc_times2;
  calc(fcalc1, input_vec);

  // Use function in class
  TestClass t;

  return 0;
}
```
