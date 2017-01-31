# dplyr

## Table of Contents
1. [処理をして列を追加](#処理をして列を追加)
2. [条件付き列選択](#条件付き列選択)
3. [列名変更](#列名変更)
4. [複数列へ同じ処理を行う](#複数列へ同じ処理を行う)
5. [apply的処理](#apply的処理)


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

## 複数列へ同じ処理を行う
```r
> iris %>% mutate_each(funs(h = ./2), -Species) # Species以外の全ての値を半分に
> iris %>% group_by(Species) %>% summarise_each(funs(mean, sd)) # Speciesでグループ化して各列の平均と標準偏差
```

## apply的処理
```r
fun_AgeCohorts <- function(x){
	if(x==0) return("male")
	if(x==1) return("female")
}

population <- population %>% 
	rowwise() %>%
	mutate(gender_name=fun_AgeCohorts(gender))
```
