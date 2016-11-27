# dplyr

## Table of Contents
1. [処理をして列を追加](#処理をして列を追加)

## 処理をして列を追加
```r
data %>%  group_by(year)  %>% mutate(med_age = median(age, na.rm=TRUE)) -> data
```
