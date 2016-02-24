# Git
How to use Git
* Websites for reference
  * [いまさら聞けないgitの使い方](http://qiita.com/mountcedar/items/682743c95fd3b8fc274b)

# Table of Contents
1. [How to clone](#how-to-clone)
2. [How to upload changes](#how-to-upload-changes)
3. [When someone updates the files](#when-someone-updates-the-files)


### How to clone
What you will do first is to `clone` files from the existing repository.<br>
To do so,
```
$ cd /Users/Backup/GitHubData  # Where to clone
$ git clone https://github.com/xxxxx/Code_Tips.git
Cloning into 'Code_Tips'...
remote: Counting objects: 126, done.
remote: Compressing objects: 100% (98/98), done.
remote: Total 126 (delta 40), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (126/126), 12.99 KiB | 0 bytes/s, done.
Resolving deltas: 100% (40/40), done.
Checking connectivity... done.
$ cd /Users/Backup/GitHubData/Code_Tips # Move to cloned folder
$ git init
```
## How to upload changes
After you make changes,
```
$ git add *
$ git commit -m "your comments"
$ git push https://github.com/xxxxx/Code_Tips.git master:master
```
or, you can use `git push origin your_branch_name(ex. master)` for the last line.

## When someone updates the files
```
$ git pull
```
`pull` should be done first in case codes are modified.
