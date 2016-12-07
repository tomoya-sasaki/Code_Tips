# dplyr

## Table of Contents
1. [処理をして列を追加](#処理をして列を追加)
2. [条件付き列選択](#条件付き列選択)


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
