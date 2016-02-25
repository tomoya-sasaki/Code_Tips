#Seaborn

# Table of Contents
1. [軸やラベルなどの設定](#軸やラベルなどの設定)
2. [サイズの調整](#サイズの調整)


### 軸やラベルなどの設定
`.set()`でOK
```
fig1 = sns.regplot(x=data_wTopicExt.ix[: ,"Topic"].values,  y=data_wTopicExt.ix[:, "Likes"].values, fit_reg=False)
fig1.set(xlabel='Category', ylabel='Likes', xlim=(-0.5, 10))
```

### サイズの調整
先頭に一行追加
```
plt.subplots(figsize=(8, 8))
fig1 = sns.boxplot(x="Topic", y="Likes", data=data_wTopicExt[["Topic", "Likes"]])
```
