# C / C++

### 配列の要素数を求めてループ
```cpp
for(int i=0; i<sizeof(pi)/sizeof(pi[0]); i++){ //配列の要素数を求めている 
	running_total += pi[i];
	pi_total[i] = running_total;
}
```

### Vimで関数の読み込み
headerを作ると面倒なので、`.cpp`を直に読みこむようにしていた。  
Terminalでするなら、
```terminal
clang++ -std=c++11 -stdlib=libc++  NP_Algorithm4.2.cpp ReadVector.cpp
```
