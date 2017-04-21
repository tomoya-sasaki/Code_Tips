# Profiling

## PyCallGraph

### Usage
```terminal
$ pycallgraph graphviz  -- main.py
```

### Options
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
