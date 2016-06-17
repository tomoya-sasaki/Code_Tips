#Seaborn
`import seaborn as sns`  
inlineの表示`%matplotlib inline`

# Table of Contents
1. [軸やラベルなどの設定](#軸やラベルなどの設定)
2. [サイズの調整](#サイズの調整)
3. [棒だけのhistogram](#棒だけのhistogram)


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
