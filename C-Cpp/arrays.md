# Arrays

## Table of Contents
1. [Arrays and brackets](#arrays-and-brackets)
2. [Dynamic array](#dynamic-array)
3. [Pass to a function](#pass-to-a-function)

## Arrays and brackets
まず、`int a[10];`に対して`a`と記述すると`&a[0]`と同じに解釈 (arrayの先頭要素へのポインタ)

配列の宣言時、`int a[10];`における、`[]`は配列の宣言の為の記号。

一方、`a[3]=0;`とすると、`a`は先の規則によって`a`の先頭要素へのポインタと解釈されて、これに`[]`をつけることでそこから4つ目の場所へのアクセスとなる(C++ではindexが0スタート)。だから`a[3]`と`*(a+3)`は等価。(`[]`による記述はポインタ一般について有効)

## Dynamic array
[Reference](http://stackoverflow.com/questions/3904304/3d-array-c-using-int-operator)   
最後に`()`をつけることで`0`にinitializeできる。     
[Use in function](https://github.com/Shusei-E/Online_Judge/blob/master/AOJ/Introduction/ITP1_10_D.DistanceII.cpp)

1D
```
const int MAX_SIZE=128;
int *arr1D = new int[MAX_SIZE];
```

2D (Row×Column)
```cpp
const int Row=20; // 1st Dimension
const int Column=20; // 2nd Dimension

int **arr2D = new int*[Row];  //create an array of int pointers (int*), that will point to 
                                //data as described in 1D array.
for(int i = 0;i < Row; i++){
  arr2D[i] = new int[Column]; 
}
// ... some codes ...
for(int i=0; i<Row; i++)
   delete [] arr2D[];
delete [] arr2D;
// -------
// If you want to insert the value at the same time,
double **array;
array = new double *[3];
for(int r = 0; r<3; r++){
  array[r] = new double[3];
  for(int c=0; c<3; c++){
    array[r][c] = 1.3;
  }
}
```

3D
```cpp
const int X=20;
const int Y=20;
const int Z=20;

int ***arr3D = new int**[X];
for(int i =0; i<X; i++){
  arr3D[i] = new int*[Y];
  for(int j =0; j<Y; j++){
    arr3D[i][j] = new int[Z];
    for(int k = 0; k<Z;k++){
      arr3D[i][j][k] = 0;
    }
  }
}

// free memory
for(int i = 0; i <X; i++){
  for(int j=0; j <Y; j++)
    delete[] arr3D[i][j];
  delete[] arr3D[i];
}
delete[] arr3D;
```

関数に読み込ませてやるときは、`vecsum(int n, int Data[n+1])`のように長さに関わるものを先にすることで上手くいった。

## Pass to a function
Pointer might be the best.
