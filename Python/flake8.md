# Flake8

## Table of Contents
1. [Avoid a long line](#avoid-a-long-line)

## Avoid a long line
```py
>>> text1 = ("my"
...          " text")
>>> text1
'my text'

>>> text2 = ("my",
...          " text")
>>> text2
('my', ' text')

>>> text3 = ("use "
...          + text1)
>>> text3
'use my text'
```
