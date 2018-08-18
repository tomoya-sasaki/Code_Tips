# Python経由でTerminalを使う

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
