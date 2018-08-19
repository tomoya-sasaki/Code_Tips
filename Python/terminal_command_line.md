# Python経由でCommand Lineを使う

## Run terminal commands

```python
import subprocess
LDA_Folder = "/Users/GibbsLDA++-0.2/src/lda"
Data_Folder = "/Users//My_Project/LDA_GibbsLDA/LDA_sentence.txt"
cmd = "%s -est -alpha 0.5 -beta 0.1 -ntopics 20 -niters 500 -savestep 500 -twords 20 -dfile %s" % (LDA_Folder, Data_Folder )
subprocess.call( cmd.strip().split(" ")  )
```

For details, check [this](http://takuya-1st.hatenablog.jp/entry/2014/08/23/022031) website.

`subprocess.run()` gives you an actual output.
```py
subprocess.run(["git", "status"])
```

### Execute python file and show it's output
```py
def run_python(filename):
    # https://stackoverflow.com/q/51918012/2978524
    kwargs = dict(bufsize=0,  # No buffering.
                  stdout=subprocess.PIPE,
                  stderr=subprocess.STDOUT,
                  universal_newlines=True)
    args = [sys.executable, filename]

    with subprocess.Popen(args, **kwargs).stdout as output:
        for line in output:
            print(line, end='')  # Process the output
```

## Get command line arguments
```py
import argparse
parser = argparse.ArgumentParser()
parser.add_argument("--mode", default="a", help="select mode (p: Python only, s: Sphinx only)")
args = parser.parse_args()

if args.mode:
  if args.mode == "p":
    print("Python mode")
```
