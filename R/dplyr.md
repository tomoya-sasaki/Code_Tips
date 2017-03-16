# dplyr

## Table of Contents
1. [処理をして列を追加](#処理をして列を追加)
2. [select](#select)
	* [文字で](#文字で)
	* [条件付き列選択](#条件付き列選択)
3. [列名変更](#列名変更)
4. [複数列へ同じ処理を行う](#複数列へ同じ処理を行う)
5. [apply的処理](#apply的処理)
6. [Regression Simulation](#regression-simulation)
7. [記述統計](#記述統計)
8. [Environmentの変数を使う](#environmentの変数を使う)
9. [時間関連](#時間関連)

## 処理をして列を追加
```r
data %>%  group_by(year)  %>% mutate(med_age = median(age, na.rm=TRUE)) -> data
```

## select
### 文字で
```r
select_(.dots = c("educ",
	"A14:A29", "C_ach:C_pal", ~starts_with("G", ignore.case=F), # ACG
	"-G1_14_17", "-G1_26_30", "-G2_18_21", "-G2_26_30", "-G3_22_25","-G3_26_30",
	~starts_with("fthr_"), "-fthr_ed", "-fthr_edhi", # ctrls
	))
```

### 条件付き列選択
```r
temp <- data %>% 
    filter(age<31) %>%
    select_(.dots=c("id2", starts_with("hhii"), "abd_lgth_hh"))
```
なぜか上手く回らなかったので、こちらを: `temp[,grep('hhii|id2|abd_lgth_hh',names(temp))]` --> `.dots`とすればOK?

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
[Reference](http://ja.stackoverflow.com/q/32351/12704)  
ちなみに、下のコードでは`position_dodge`を負の値にすることで線分の並びを逆にすることができる。
```r
library(broom) # for tidy()
temp <- population %>%
  group_by(setid) %>%
  do(model1 = tidy(lm(score ~ age, data = .)),
     model2 = tidy(lm(score ~ age + gender, data = .))) %>%   ## Same as question
  gather(model_name, model, -setid) %>%  ## make it long format / gather(-setid, key=model_name, value=mode)??
  unnest() %>%  ## expand
  filter(term == "age") ## select a variable


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

## 記述統計
### Example 1
```r
sway %>% subset(found==1) %>% 
	select_("abd", "w_abs2", "abd_l", "abd_age", "exper", "viol_perp", "educ") %>%
	group_by(abd) %>%
	summarise_each(funs(mean = weighted.mean(., w=w_abs2, na.rm=T)), -matches("w_abs2")) %>%
	round(2) %>%
	select_("-abd") %>% 
	t %>%  # transpose
	`colnames<-`(c("NonAbducted", "Abducted")) %>% # or setNames()
	subset(select=c(2,1)) %>% # reorder columns
	`rownames<-`(c("Months abducted", "Age of abduction",
		"Index of violence experienced","Index of violence perpetrated",
		"Educational attainment")) %>%
	knitr::kable(caption = "記述統計")
	
|                                              | Abducted| NonAbducted|
|:---------------------------------------------|--------:|-----------:|
|Months abducted                               |     0.74|        0.00|
|Age of abduction                              |    15.34|         NaN|
|Index of violence experienced                 |     8.43|        6.95|
|Index of violence perpetrated                 |     1.51|        0.07|
|Educational attainment                        |     7.10|        7.62|
```

### Example 2
```r
sway %>% subset(found==1) %>% 
 select_("abd", "w_abs2", "abd_l", "abd_age", "exper", "viol_perp", "educ") %>%
 group_by(abd) %>%
 summarise_each(funs(mean = paste(weighted.mean(., w=w_abs2, na.rm=T)%>%round(2), " [",
                 sd=sd(., na.rm=T)%>%round(2), "]",
                 sep="")),-matches("w_abs2")) %>%
 select_("-abd") %>% t %>%
 `colnames<-`(c("NonAbducted", "Abducted")) %>% # or setNames()
 subset(select=c(2,1)) %>% # reorder columns
 `rownames<-`(c("Months abducted", "Age of abduction",
      "Index of violence experienced","Index of violence perpetrated",
      "Educational attainment")) %>%
 knitr::kable(caption = "記述統計 / 平均[標準偏差]")
 
 |                                              |Abducted          |NonAbducted       |
|:---------------------------------------------|:-----------------|:-----------------|
|Months abducted                               |0.74 [1.46]       |0 [0]             |
|Age of abduction                              |15.34 [4.86]      |NaN [NaN]         |
|Index of violence experienced                 |8.43 [5.77]       |6.95 [5.25]       |
|Index of violence perpetrated                 |1.51 [1.88]       |0.07 [0.26]       |
|Educational attainment                        |7.1 [2.79]        |7.62 [3.01]       |
```

## Environmentの変数を使う
Use `get()` function.
```r
df %>% filter(b == get("b")) # Note the "" around b
```


## 時間関連
### Timeの型にする
```r
### 2017-03-01 23:43:30 のような形
data %>% select_("StartDate", "EndDate") %>% slice(3:n()) %>%
    mutate_each(funs(as.POSIXct(.,"%Y-%m-%d %H:%M:%S", tz="UTC")))
```
