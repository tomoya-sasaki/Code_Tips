<h1>Pandas</h1>

# Table of Contents
1. [データフレームを初期化した後に登録](#データフレームを初期化した後に登録)
2. [再インデックス](#再インデックス)
3. [時系列インデックスをつけてソートする](#時系列インデックスをつけてソートする)
4. [columnの入れ替え](#columnの入れ替え)
5. [条件付き抽出](#条件付き抽出)
6. [ランダムに行を取り出す](#ランダムに行を取り出す)
7. [ファイルの書き出し](#ファイルの書き出し)
8. [要素の取り出し](#要素の取り出し)
9. [列の追加](#列の追加)
10. [一部列名の変更](#一部列名の変更)
11. [データフレームのmerge](#データフレームのmerge)
12. [列のdatatypeを変える](#列のdatatypeを変える)
13. [重複の削除](#重複の削除)
14. [ある列の中で、特定の文字列を含む行だけを抜き出す](#ある列の中で特定の文字列を含む行だけを抜き出す)
15. <a href="http://stackoverflow.com/questions/35966051/changing-data-frame-style-in-pandas" target="_blank">データフレームの変形</a>
16. [(上と関連して)LongからWideへ](https://github.com/Shusei-E/Code_Tips/blob/master/Python/Pandas.md#longからwideへ)
17. [Excel形式で保存](#excel形式で保存)


### データフレームを初期化した後に登録
```python
results_df = pd.DataFrame()
results_df = results_df.append(pd.DataFrame({
   "ID": [user for i in range(len(tweet_list))],       
   "Date": [date.strftime('%Y-%m-%d') for i in range(len(tweet_list))],
   "Time": tweet_time_list,
   "Tweet": tweet_list,
   "Type": tweet_type_list},
   columns = ['ID', 'Date', 'Time', 'Tweet', 'Type']))
```

### 再インデックス
単純に上から番号を振るだけでよければ、<br>
`dataframe.reindex(range(len(df))) # re-index`
番号順だけで良いのに、indexがあるばっかりに面倒なことも。そのときは、とりあえず文字列を被らないように振っておいて、 reindexを繰り返すしかないのかも<br><br>

`user_tweet_df.index = [i for i in range(len(user_tweet_df))]`<br>
としないと上手く行かないこともあった。<br>
追記: これは、`df.reset_index(drop=True)`と同じことみたい。

### 時系列インデックスをつけてソートする
cf. 言語処理100本ノック No.18<br>
```python
time = pd.Series(df[3]) # dataframeの3列目が時系列
df.sort(3, ascending=True)
```
### columnの入れ替え
```python
col = MC_df.columns.tolist()
col = col[-1:] + col[:-1] # 一番最後を最初に持ってくる
MC_df = MC_df[col]
```

### 条件付き抽出
`pos`という列の値が動詞のものの、`surface`列を取り出す。(言語処理100本ノック No.31)
```
verb_surface = MC_df.ix[MC_df["pos"]=="動詞", "surface"]
```

複数条件で選択する場合は
`MC_df[(MC_df["pos"]=="名詞") & (MC_df["pos1"]=="サ変接続")]` <br>
これは、.ixで指定しても同じみたい
<br>
数値だけを考えているなら、`query`を使えばシンプルに書ける<br>
また、単純に複数列を取り出したいのならリストを使って、`data[["x1", "x2"]]`などでOK。

### ランダムに行を取り出す
```python
sampler = np.random.permutation(len(cleaned_df3))
sampled = cleaned_df3.take(sampler[:1500])
```

### ファイルの書き出し
csvで書き出したとき、encodingを指定しないとutf-8になってExcelで開いた時に日本語が文字化けしてしまう(Mac環境)。Shift-JISの拡張のcp932が良いのかな。
```
sample_df.to_csv("sample.csv",  encoding ='cp932', index=False)
```

### 要素の取り出し
`state_df.ix[state_df["state"]==state, "State"]`
とすると、
```python
50    North Carolina
Name: State, dtype: object
```
が返ってきて、これを`str()`したとしても、欲しい`"North Crolina"`だけが手に入らない。
そこで、<br>
`str(state_df.ix[state_df["state"]==state, "State"].values[0])`<br>
とする。

### 列の追加
```python
new_col = pd.DataFrame(["not" for i in range(len(user_df))])
new_col.columns =["status_download"] #列名は結合後にもそのまま使われる

#pandas.concatは結合するもの同士のインデックスが同じ構造でないと上手くできない
new_col.index = [i for i in range(len(user_df))]
user_df = pd.concat([user_df, new_col], axis=1)
```

### 一部列名の変更
`df_temp.rename(columns={df_temp.columns[0]: 'A_code'}, inplace=True)`<br>
行も変えるなら、<br>
`df.rename(columns={'A': 'a'}, index={'ONE': 'one'}, inplace=True)`<br>
とすればOK。<br>
`inplace=False`（デフォルト）にすると新しいDataFrameを返し、元のデータは変更されない。`inplace=True`にすると元のデータが変更される。

### データフレームのmerge
<a href="http://sinhrks.hatenablog.com/entry/2015/01/28/073327" target="_blank">ここ</a>に詳しい。
デフォルトでは2つのDataFrameにkeyがないと結合後に残らないので、howオプションで細かく指定する。<br>
`pd.merge(left, right, on='key', how="left")`<br>
複数のkeyを使う場合には、`on=["Key1", "Key2"]`とリストで渡す。
* `inner`: 既定。両方のデータに含まれるキーだけを残す。
* `left`: ひとつめのデータのキーをすべて残す。
* `right`: ふたつめのデータのキーをすべて残す。
* `outer`: すべてのキーを残す。

### 列のdatatypeを変える
seabornなどでplotする際に必要になることがある
```python
data_wTopicExt[['Likes', 'RT', 'Topic']] = data_wTopicExt[['Likes', 'RT', 'Topic']].astype(float)
```

### 重複の削除
```python
df = df.drop_duplicates(["Municipality_code", "District_code"])
```

### ある列の中で、特定の文字列を含む行だけを抜き出す
以下の例は、`merged_df`というデータフレームの`SHI_NAME`列の値が市川市になっているデータにおいて、`CHOZA_NAME`列の値に「大野町」を含むデータを抜き出している。
```python
# ある名前を含むかどうかの論理判定
row_select = pd.Series(merged_df[(merged_df["SHI_NAME"] == "市川市")]["CHOAZA_NAME"]).str.contains("大野町")
# 論理配列を使って列選択
merged_df[(merged_df["SHI_NAME"] == "市川市")].ix[np.array(row_select), :]
```
列名の部分一致は<a href="http://qiita.com/hik0107/items/d991cc44c2d1778bb82e#%E3%83%87%E3%83%BC%E3%82%BF%E3%82%92%E3%81%84%E3%81%98%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%88%E3%81%86" target="_blank">こちら</a>が参考になる。

### LongからWideへ
`pivot_table`を使うのが一番良さそう

cf. https://codedump.io/share/FJA2PUE30eqf/1/long-to-wide-data-pandas  
cf. http://stackoverflow.com/questions/35966051/changing-data-frame-style-in-pandas
```
print df
  Old_City  New_City_Code New_City_Name Old_City_Code
0        a            101             A           001
1        b            101             A           002
2        c            102             B           003
3        d            103             C           004
4        e            103             C           005
5        f            103             C           006

#create columns names for pivoting
df['cols'] = (df.groupby(['New_City_Name', 'New_City_Code']).cumcount() + 1).astype(str)

print df  
  Old_City  New_City_Code New_City_Name Old_City_Code cols
0        a            101             A           001    1
1        b            101             A           002    2
2        c            102             B           003    1
3        d            103             C           004    1
4        e            103             C           005    2
5        f            103             C           006    3    

df = pd.pivot_table(df, 
                    index=['New_City_Name', 'New_City_Code'], 
                    columns=['cols'], 
                    values=['Old_City','Old_City_Code'], 
                    aggfunc='first')

#remove multiindex in columns
df.columns = [''.join(col) for col in df.columns.values]
#replace NaN to '', reset index
df = df.fillna('').reset_index()
```


### Excel形式で保存
```python
import openpyxl
panel = pd.read_csv("File.csv", encoding ='cp932')
panel.to_excel("File.xlsx","sheet1")
```
