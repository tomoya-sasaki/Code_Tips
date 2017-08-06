# matplotlib
Another option: [HoloViews](http://holoviews.org/index.html)

## Table of Contents
1. [Place legend out of the plot](#place-legend-out-of-the-plot)

## Place legend out of the plot
[Reference 1](http://symfoware.blog68.fc2.com/blog-entry-1418.html), [Reference 2](http://stackoverflow.com/questions/4700614/how-to-put-the-legend-out-of-the-plot)
```python
from matplotlib.font_manager import FontProperties
fontP = FontProperties(size=12)

plt.legend(topic_labels, prop=fontP, bbox_to_anchor=(1.05, 1), loc='upper left', borderaxespad=0)
pylab.subplots_adjust(right=0.7) # adjist margin
```
