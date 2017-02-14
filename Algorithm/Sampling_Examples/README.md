# Various Ways of Sampling

## Questions
* MHでのBlock-wiseとComponent-wise
	* この考え方の違いでOKみたい
* 採択率かなり低いけど、値はなんとなく収束しているように見える
	* --> 各ステップで移動する距離が大きすぎた, `np.normal(0,0.1)` 程度にすべし
* Slice SamplingでITILAの3dとかにあたるものってすぐ評価できるのか --> `is_in_S`
* Slice SamplingのGaussianで、初期値が真の値と結構離れていると推定が進まないのは？ (サンプルサイズが増えると上手くいくので、情報不足？) 
	* --> 尤度式が間違っていた
* 本当は、`\sigma^2` はσにlogをとって動かさないといけないみたいだけれど、そうすると値が大きくずれてしまう...
