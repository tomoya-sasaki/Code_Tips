# Various Ways of Sampling
**There might be bugs, or theoretical misunderstandings!!**
* `Metropolis-Hastings-Gaussian1D`: should be fine
* `Metropolis-Hastings-Gaussian`: no prior, no log sigma
* `Metropolis-Hastings-Linear-WithoutSD`: should be fine / with prioir
* `Metropolis-Hastings-Linear-bOnly`: should be fine / with prior
* `Metropolis-Hastings-Linear`: no prior, no log sigma
* `Gibbs-Gaussian`: should be fine
* `Slice-Sampling-SimpleDiscrete`: just a simple example

## Questions
* MHでのBlock-wiseとComponent-wise
	* この考え方の違いでOKみたい
* 採択率かなり低いけど、値はなんとなく収束しているように見える
	* --> 各ステップで移動する距離が大きすぎた, `np.normal(0,0.1)` 程度にすべし
* Slice SamplingでITILAの3dとかにあたるものってすぐ評価できるのか --> `is_in_S`
* Slice SamplingのGaussianで、初期値が真の値と結構離れていると推定が進まないのは？ (サンプルサイズが増えると上手くいくので、情報不足？) 
	* --> 尤度式が間違っていた
* 本当は、`\sigma^2` はσにlogをとって動かさないといけないみたいだけれど、そうすると値が大きくずれてしまう...
* 線形モデルでの`b`のバラツキ
	* --> 図からもわかるように、傾き`a`に比べて、切片`b`は色々な値を取っているので、バラつくのがむしろ自然
