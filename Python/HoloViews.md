# HoloViews

## Table of Contents
1. [Jet colormap](#jet-colormap)
2. [Output size](#output-size)
3. [Options](#options)

## Jet colormap
```python
dict_spec = {'HeatMap':{'style':dict(cmap='jet')}}
hv.HeatMap(show(data_IDs)).opts(dict_spec)
```

## Output size
### On Jupyter
```
%%output size=150
```

## Options
In Jupyter,
```py
%%opts HeatMap [tools=['hover'] colorbar=True width=855 height=550 toolbar='above', fontsize={'title':10, 'xlabel':13, 'ylabel':13, 'ticks':12}]
```
