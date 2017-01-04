# Chapter 8

## 8.1 Introduction to the Hierarchical Model

### 8.1.2 Visualization of the Normal Regression
<img src="sec8.1.png" width="580">

## 8.2 Hierarchical Models with Several Hierarchies
Figure in p.133:<br>
<img src="sec8.2.png" width="620"><br>
a (coefficient): category 3 has bigger average, smaller variance

## 8.4 Logistic Hierarchical Model
<img src="sec8.4.png" width="620">

## Exercise
### (1)
The figure is different from the textbook's figure. I generated `y_pred` in the Stan code, but textbook generates predicted values after the estimation. This is why textbook can successfully generates values across X's range.  
My try:  
<img src="Ex1.png" width="570">
Textbook answer:
<img src="fig-ex1.png" width="570">

### (2)
<img src="Ex2.png" width="570"><br>
Calculated expected values inside the Stan code, which is different from the textbook (I believe this is more computationally efficient).

### (3)
<img src="Ex3.png" width="570"><br>

### (4)
<img src="Ex4.png" width="640"><br>
