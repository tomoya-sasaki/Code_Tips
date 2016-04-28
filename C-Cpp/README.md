# C / C++

### 配列の要素数を求めてループ
```cpp
for(int i=0; i<sizeof(pi)/sizeof(pi[0]); i++){ //配列の要素数を求めている 
	running_total += pi[i];
	pi_total[i] = running_total;
}
```
