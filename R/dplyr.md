# dplyr

## Table of Contents
1. [処理をして列を追加](#処理をして列を追加)
2. [条件付き列選択](#条件付き列選択)
3. [列名変更](#列名変更)
4. [複数列へ同じ処理を行う](#複数列へ同じ処理を行う)
5. [apply的処理](#apply的処理)
6. [Regression Simulation](#regression-simulation)


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
	if(x==1) return("female") # if you return a number, make sure as.double() !!
}

population <- population %>% 
	rowwise() %>%
	mutate(gender_name=fun_AgeCohorts(gender))
```

## Regression Simulation
```r
temp <- population %>%
  group_by(setid) %>%
  do(model1 = tidy(lm(score ~ age, data = .)),
     model2 = tidy(lm(score ~ age + gender, data = .))) %>%   ## Same as question
  gather(model_name, model, -setid) %>%                        ## make it long format
  unnest() %>%                                                 ## gather
  filter(term == "age")                                        ## select a variable


  ## same as the website linked in the question (some parts are skipped)
interval1 <- -qnorm((1-0.9)/2)

ggplot(temp, aes(colour = as.factor(setid))) +
  geom_hline(yintercept = 0, colour = gray(1/2), lty = 2) +
  geom_linerange(aes(x = model_name, ymin = estimate - std.error*interval1,
                     ymax = estimate + std.error*interval1),
                 lwd = 1, position = position_dodge(width = 1/2)) +
  coord_flip()
```
<img src="figures/dplyr_simulation.png" width="400">
