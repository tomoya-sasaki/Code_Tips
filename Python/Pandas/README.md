<h1>Pandas</h1>

# Table of Contents
1. [データフレームを初期化した後に登録](#データフレームを初期化した後に登録)
2. [再インデックス](#再インデックス)
3. [Third Example](#Third Example)

###Third Example

###データフレームを初期化した後に登録
```
results_df = pd.DataFrame()
results_df = results_df.append(pd.DataFrame({
   "ID": [user for i in range(len(tweet_list))],       
   "Date": [date.strftime('%Y-%m-%d') for i in range(len(tweet_list))],
   "Time": tweet_time_list,
   "Tweet": tweet_list,
   "Type": tweet_type_list},
   columns = ['ID', 'Date', 'Time', 'Tweet', 'Type']))
```

###再インデックス
単純に上から番号を振るだけでよければ、<br>
`dataframe.reindex(range(len(df))) # re-index`
番号順だけで良いのに、indexがあるばっかりに面倒なことも。そのときは、とりあえず文字列を被らないように振っておいて、 reindexを繰り返すしかないのかも<br><br>

`user_tweet_df.index = [i for i in range(len(user_tweet_df))]`<br>
としないと上手く行かないこともあった
