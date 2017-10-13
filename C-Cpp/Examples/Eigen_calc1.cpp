#include <Eigen/dense>
#include <iostream>

using namespace std;
using namespace Eigen;


int main(){
    VectorXd input_vec = VectorXd::LinSpaced(4,1,4);
    MatrixXd input_mat = MatrixXd::Identity(3,3);

    cout << "Vector:\n" << input_vec.transpose() << "\n" << endl;

    cout << input_vec + input_vec << "\n" << endl;
    cout << input_vec.array() + 2 << "\n" <<  endl;
    // cout << input_vec + 2 << "\n" <<  endl; // error

    cout << input_vec.array() * input_vec.array() << endl;
    cout << endl;

    cout << "Matrix:\n" << input_mat << "\n" << endl;

    cout << input_mat + input_mat << "\n" << endl;
    cout << input_mat.array() + 2.0 << "\n" << endl;
    cout << input_mat.array().exp()  << "\n" << endl;

    return 0;
}
