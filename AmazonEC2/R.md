# Use R on Amazon EC2

# RStudio
* Use AMI: http://www.louisaslett.com/RStudio_AMI/
* Open port 80 (HTTPS)
* Use Public DNS to access
* Default username and password: rstudio/rstudio
  * This is the same as Linux
  * If you want to change them, connect with ssh and adduser + passwd

PDFの図の日本語フォントがブラウザ上で見ると乱れているように見えるけど、ダウンロードすればOK

# R
```terminal
sudo yum install -y R
```
[Reference](https://aws.amazon.com/jp/blogs/big-data/running-r-on-aws/)
