# logging
  
## Table of Contents
1. [Basic Usage](#basic-usage)
  
  
## Basic Usage
```python
import logging

def main():
  logging.basicConfig(format='%(asctime)s:%(levelname)s:%(message)s', level=logging.DEBUG)
  logging.debug('Log1/Debug')
  logging.info('Log2/Info')
  logging.warning('Log3/Warning')

if __name__ == '__main__':
    main()
```
Output:
```terminal
2016-11-25 15:25:16,999:DEBUG:Log1/Debug
2016-11-25 15:25:16,999:INFO:Log2/Info
2016-11-25 15:25:17,000:WARNING:Log3/Warning
```

|  フォーマット 	|           概要          	|
|:-------------:	|:-----------------------:	|
| %(asctime)s   	| 実行時刻                	|
| %(filename)s  	| ファイル名              	|
| %(funcName)s  	| 関数名                  	|
| %(levelname)s 	| DEBUG、INFO等のレベル名 	|
| %(lineno)d    	| 行番号                  	|
| %(name)s      	| 呼びだしたログの定義名  	|
| %(module)s    	| モジュール名            	|
| %(message)s   	| ログメッセージ          	|
| %(process)d   	| プロセスID              	|
| %(thread)d    	| スレッドID              	|
