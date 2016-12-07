# dplyr

## Table of Contents
1. [処理をして列を追加](#処理をして列を追加)
2. [条件付き列選択](#条件付き列選択)
3. [列名変更](#列名変更)


## 処理をして列を追加
```r
data %>%  group_by(year)  %>% mutate(med_age = median(age, na.rm=TRUE)) -> data
```

## 条件付き列選択
```r
temp <- data %>% 
    filter(age<31) %>%
    select_("id2", starts_with("hhii"), "abd_lgth_hh")
```
なぜか上手く回らなかったので、こちらを: `temp[,grep('hhii|id2|abd_lgth_hh',names(temp))]`

## 列名変更
```r
rename(data, NEW = OLD)
```
