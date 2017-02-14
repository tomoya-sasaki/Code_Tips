# Various Ways of Sampling

## Questions
* MHでのBlock-wiseとComponent-wise
* 採択率かなり低いけど、値はなんとなく収束しているように見える
* GibbsでrhoはUpdateされてる？
* Slice SamplingでITILAの3dとかにあたるものってすぐ評価できるのか --> `is_in_S`
* Slice SamplingのGaussianで、初期値が真の値と結構離れていると推定が進まないのは？ (サンプルサイズが増えると上手くいくので、情報不足？) 
	* --> 尤度式が間違っていた
