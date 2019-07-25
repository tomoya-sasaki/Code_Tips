#include <math.h>

double logsumexp (double x, double y, bool flg)
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

/*

Reference: http://d.hatena.ne.jp/echizen_tm/20100628/1277735444

flg は初期値の設定のために用いる。
Z = log(exp(a[0]) + exp(a[1]) + ...exp(a[n − 1])) を計算する時には、以下のようにすることができる。
```
double Z = 0.0;
for (int i = 0; i < n; ++i)
Z = logsumexp (Z, a[i], (i == 0))
```

*/

// For Eigen
double logsumexp_Eigen(VectorXd vec){
  double sum = 0.0;
  int index;

  for(size_t i=0; i<vec.size(); ++i){
    index = static_cast<int>(i);
    sum = logsumexp (sum, vec[index], (index == 0));
  }

  return sum;

}

double new_logsumexp_Eigen(VectorXd &vec, const int size){
	if(size == 1) return vec(0);

	double vmax = vec.maxCoeff();
	double sum = 0.0;

	for(int i=0; i<size; i++){
		sum += exp(vec(i) - vmax);
	}
  
	return vmax + log(sum);
}

/*
For Python

def my_logsumexp(x, y, flg):
    if flg:
        return y
    if x == y:
        return x + 0.69314718055
    
    vmin = min(x,y)
    vmax = max(x,y)
    
    if vmax > vmin + 50:
        return vmax
    else:
        return vmax + np.log( np.exp(vmin - vmax) + 1.0 )
    

def calc_logsumexp(vec):
    res = 0.0
    size = vec.shape[0]
    
    for index in range(size):
        res = my_logsumexp(res, vec[index], (index==0))
        
    return res


*/
