# Seaborn

`import seaborn as sns`  
inlineの表示`%matplotlib inline`

インストール時に、`ValueError: unknown locale: UTF-8`と出たら、ターミナルで`export LC_ALL=ja_JP.UTF-8`と実行。

References:
* [matplotlib + seaborn — Pythonでグラフ描画 ](https://heavywatal.github.io/python/matplotlib.html)

Another option: [HoloViews](https://github.com/Shusei-E/Code_Tips/blob/master/Python/HoloViews.md)

# Table of Contents
1. [軸やラベルなどの設定](#軸やラベルなどの設定)
2. [サイズの調整](#サイズの調整)
3. [棒だけのhistogram](#棒だけのhistogram)
4. [折れ線グラフ](#折れ線グラフ)
5. [日本語フォント](#日本語フォント)
6. [点や線のスタイル](#点や線のスタイル)
7. [Scatterplot](#scatterplot)
   * [カテゴリごとの色](#カテゴリごとの色)
8. [直線を引く](#直線を引く)
9. [保存](#保存)


## 軸やラベルなどの設定
`.set()`でOK
```python
fig1 = sns.regplot(x=data_wTopicExt.ix[: ,"Topic"].values,  y=data_wTopicExt.ix[:, "Likes"].values, fit_reg=False)
fig1.set(xlabel='Category', ylabel='Likes', xlim=(-0.5, 10))
```

## サイズの調整
先頭に一行追加
```python
plt.subplots(figsize=(8, 8))
fig1 = sns.boxplot(x="Topic", y="Likes", data=data_wTopicExt[["Topic", "Likes"]])
```

## 棒だけのhistogram
```python
sns.distplot(result, hist=True, kde=False)
```

## 折れ線グラフ
```python
labels = [str(i) for i in range(32)]
fig1 = sns.pointplot(x="Date", y="Count", data=top1.sort_values(by="Date"))
fig1 = fig1.set_xticklabels(labels, rotation=0)
```

## 日本語フォント
[参考](http://qiita.com/keisuke-nakata/items/2309764d21438645f6b9)
```python
import matplotlib as mpl
print(mpl.matplotlib_fname())
```
として、`matplotlibrc`の存在するフォルダに`fonts`フォルダを、さらにその中に`ttf`フォルダを作り、適当な`.ttf`フォントを移動する。
```python
sns.set(font=['Meiryo']) 
```
とすることで指定可能。

## 点や線のスタイル
```python
fig1 = sns.pointplot(x="Date", y="Count", data=top.sort_values(by="Date"), hue="Word", markers=["o", "x"], linestyles=["-", "--"])
```
のように、`marker`と`linestyles`を入れる。両者とも、matplotlibの表記が可能([marker](http://matplotlib.org/api/markers_api.html), [linestyle](http://matplotlib.org/examples/lines_bars_and_markers/line_styles_reference.html))。

サイズの変更
* `pointplot`では`scale=0.8`のようにする。
* `regplot`では、`scatter_kws={'s':df['c']*100}`のように辞書で渡す。`scatter_kws`には`scatter_kws={'marker':'o', 'color':'indianred'}`のように、他の値を情報を渡すこともできるみた。

## Scatterplot
[Reference](http://seaborn.pydata.org/generated/seaborn.regplot.html)
```python
sns.regplot(x=x, y=y, fit_reg=False)
```

### カテゴリごとの色
```python
results = pd.DataFrame({'X':list(X), 'Z':[str(i) for i in Z], 'Y':[npr.normal(0,0.0002) for i in Z]})
results['Z'] = results['Z'].astype('category')
sns.lmplot('X', 'Y', data=results, hue='Z', fit_reg=False)
```
`X`がデータ、`Z`がカテゴリ、`Y`は少しPlotする位置をズラしている。


## 直線を引く
```python
import matplotlib.pyplot as plt
plt.plot([x1, x2], [y1, y2], linewidth=2, color='red')
```

## 保存
```python
f1 = sns.distplot(chain[self.show_num: , 0], hist=True, kde=False)
f1 = f1.get_figure()
f1.savefig("fig.pdf")
```
