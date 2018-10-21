# Profiling

## Progress bar
```python
from tqdm import tqdm
import time

add = 0
for i in tqdm(range(100)):
    add += i
```

## cProfile

### Usage
時間で並び替え
```terminal
python -m cProfile -s time main.py
```
Save outputs:
```terminal
python -m cProfile -s time main.py > profile.txt 2>&1
```

### with Cython
Add this line in the top of Cython file.
```
# cython: profile=True
```

## PyCallGraph

### Usage
```terminal
$ pycallgraph graphviz  -- main.py
$ pycallgraph -v --stdlib --include "django.core.*" graphviz -- ./manage.py syncdb --noinput 
   # only trace the core Django modules
```

### Options
* `--i`
  * 出力するノードを限定指定
  * ワイルドカードも使用可能
  * `--i sysconfig*`なら、sysconfigで始まるラベルのノードだけ出力
* `--e`
  * 出力するノードを除外指定
* `--max-depth`
  * 出力する階層を限定


```terminal
$ pycallgraph --help

usage: pycallgraph [options] OUTPUT_TYPE [output_options] -- SCRIPT.py [ARG ...]

Python Call Graph profiles a Python script and generates a call graph
visualization.

positional arguments:
  {graphviz,gephi}      OUTPUT_TYPE
    graphviz            Graphviz generation
    gephi               Gephi GDF generation

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Display informative messages while running
  -d, --debug           Display debugging messages while running
  -t, --threaded        Process traces asyncronously (Experimental)
  -ng, --no-groups      Do not group functions by module
  -s, --stdlib          Include standard library functions in the trace
  -m, --memory          (Experimental) Track memory usage

filtering:
  -i INCLUDE, --include INCLUDE
                        Wildcard pattern of modules to include in the output.
                        You can have multiple include arguments.
  -e EXCLUDE, --exclude EXCLUDE
                        Wildcard pattern of modules to exclude in the output.
                        You can have multiple exclude arguments.
  --include-pycallgraph
                        Do not automatically filter out pycallgraph
  --max-depth MAX_DEPTH
                        Maximum stack depth to trace
 ```
