# pair

## Table of Contents
1. [Sort by Key and Value](#sort-by-key-and-value)

## Sort by Key and Value
```cpp
// Reference: http://www.geeksforgeeks.org/sorting-vector-of-pairs-in-c-set-1-sort-by-first-and-second/
#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;

void print_vec(vector<pair<string, int>> vect, size_t &n){
    // Printing the vector
    for (int i=0; i<n; i++){
        // "first" and "second" are used to access
        // 1st and 2nd element of pair respectively
        cout << vect[i].first << " "
             << vect[i].second << endl;
    }
}

bool sortbysec_descend(const pair<string,int> &a, const pair<string,int> &b){
  return (a.second > b.second);
}

bool sortbysec(const pair<string,int> &a, const pair<string,int> &b){
  return (a.second < b.second);
}

int main(){
    //declaring vector of pairs
    vector< pair <string,int> > vect;
 
    // initialising 1st and 2nd element of
    // pairs with vector elements
    vector<string> key = {"test", "is", "really", "important" };
    vector<int> value = {3, 1, 50, 20};
    size_t n = key.size();
 
    // Entering values in vector of pairs
    for (size_t i=0; i<n; i++)
        vect.push_back( make_pair(key[i], value[i]) );
 
    // Check inputs
    cout << "Original:" << endl;
    print_vec(vect, n);

    // Sort by the first element
    vector< pair <string,int> > vect_sort = vect;
    sort(vect_sort.begin(), vect_sort.end());
    cout << "\nSort by the 1st element:" << endl;
    print_vec(vect_sort, n);

    // Sort by the second element
    vector< pair <string,int> > vect_sort2 = vect;
    sort(vect_sort2.begin(), vect_sort2.end(), sortbysec);
    cout << "\nSort by the 2nd element:" << endl;
    print_vec(vect_sort2, n);

    // Sort by the second element, descending
    vector< pair <string,int> > vect_sort3 = vect;
    sort(vect_sort3.begin(), vect_sort3.end(), sortbysec_descend);
    cout << "\nSort by the 2nd element, descending:" << endl;
    print_vec(vect_sort3, n);
 
    return 0;
}

/*
Original:
test 3
is 1
really 50
important 20

Sort by the 1st element:
important 20
is 1
really 50
test 3

Sort by the 2nd element:
is 1
test 3
important 20
really 50

Sort by the 2nd element, descending:
really 50
important 20
test 3
is 1  
*/
```
