#Seaborn
`import seaborn as sns`  
inlineの表示`%matplotlib inline`

インストール時に、`ValueError: unknown locale: UTF-8`と出たら、ターミナルで`export LC_ALL=ja_JP.UTF-8`と実行。

# Table of Contents
1. [軸やラベルなどの設定](#軸やラベルなどの設定)
2. [サイズの調整](#サイズの調整)
3. [棒だけのhistogram](#棒だけのhistogram)
4. [折れ線グラフ](#折れ線グラフ)


### 軸やラベルなどの設定
`.set()`でOK
```python
fig1 = sns.regplot(x=data_wTopicExt.ix[: ,"Topic"].values,  y=data_wTopicExt.ix[:, "Likes"].values, fit_reg=False)
fig1.set(xlabel='Category', ylabel='Likes', xlim=(-0.5, 10))
```

### サイズの調整
先頭に一行追加
```python
plt.subplots(figsize=(8, 8))
fig1 = sns.boxplot(x="Topic", y="Likes", data=data_wTopicExt[["Topic", "Likes"]])
```

### 棒だけのhistogram
```python
sns.distplot(result, hist=True, kde=False)
```

### 折れ線グラフ
```python
labels = [str(i) for i in range(32)]
fig1 = sns.pointplot(x="Date", y="Count", data=top1.sort_values(by="Date"))
fig1 = fig1.set_xticklabels(labels, rotation=0)
```
