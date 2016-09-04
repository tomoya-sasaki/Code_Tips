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
