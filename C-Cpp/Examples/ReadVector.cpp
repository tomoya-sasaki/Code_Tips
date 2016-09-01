// You might be interested in this Gist
// https://gist.github.com/Shusei-E/f632c9a7b7e197cf50709915d210f7c8


#include <fstream>
#include <string>
#include <random>
#include <iomanip> // 小数点以下の出力


// Eigen
#include "Eigen/Dense" // UniではEigenの場所が違うので<ではなくてquoteにする

using namespace std;
using namespace Eigen;

#define MAXBUFSIZE  ((int) 1e6)

VectorXd readVector(const char *filename, int *num_observations){ // http://goo.gl/P0sED6
	int length=0;
	double buff[MAXBUFSIZE];

	// Read numbers into buffer
	ifstream infile;
	infile.open(filename);
	int temp_cols=0;
	while (! infile.eof()){
		string line;
		getline(infile, line);
		stringstream stream(line);
		stream >> buff[temp_cols++];
		
		if(temp_cols==0)
			continue;

		length++; // keep vector length

	} // close while ! infile.eof()

	infile.close();
	//rows--;

	// return vector
	VectorXd result(length);
	for(int i=0; i<length; i++){
		result[i] = buff[i];

		*num_observations = i+1; //Update Everytime
	} //close for(i)

	
	
	return result;
}
