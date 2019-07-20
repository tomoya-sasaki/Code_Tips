# Basics

## Table of Contents
1. [Variables](#variables)
2. [Types](#types)
3. [Distributions](#distributions)
4. [Plots](#plots)

## Variables
```julia
exp.(A)  # elementwise operation
```

## Types
```julia
typeof(variable)  # check the type
```


## Distributions
```julia
using Compat, Random, Distributions
num_cov = 3;
num_doc = 25;

X = rand(Normal(0.0, 1.0), num_doc, num_cov)  # 25 by 3 array
```


## Plots
[Reference 1](http://docs.juliaplots.org/latest/tutorial/)

