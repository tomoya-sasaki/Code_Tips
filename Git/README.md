# Git
How to use Git
* Websites for reference
  * [いまさら聞けないgitの使い方](http://qiita.com/mountcedar/items/682743c95fd3b8fc274b)
  * [初心者向けGithubへのPullRequest方法](http://qiita.com/samurairunner/items/7442521bce2d6ac9330b)
  * [Pull Request入門(複数人管理)](http://blog.qnyp.com/2013/05/28/pull-request-for-github-beginners/)
  * [git pull -rebase](http://kray.jp/blog/git-pull-rebase/) / [Git開発でmasterの内容を開発ブランチに反映させる方法](http://sota1235.com/blog/2015/03/19/git-rebase.html)
  * [Gitでやらかした時に使える19個の奥義](http://qiita.com/muran001/items/dea2bbbaea1260098051)

# Table of Contents
1. [How to clone](#how-to-clone)
2. [How to upload changes](#how-to-upload-changes)
3. [When someone updates the files](#when-someone-updates-the-files)
4. [gitignore](#gitignore)
5. [Branch](#use-branch)
6. [If you get an error](#if-you-get-an-error)
7. [Pull Request](#pull-request)
8. [Resolve Conflict](#resolve-conflict)
9. [When push is rejected](#when-push-is-rejected)
10. [Create a new repository from Terminal](#create-a-new-repository-from-terminal)
11. [Change Previous Committed Comment](#change-previous-committed-comment)
12. [Get a branch on GitHub](#get-a-branch-on-github)
13. [Get back to previous commits](#get-back-to-previous-commits]


## How to clone
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
($ git status)
$ git commit -m "your comments"
$ git push origin master
```
The last line is `$ git push https://github.com/xxxxx/Code_Tips.git master:master` or, you can use `git push origin your_branch_name(ex. master)` for the last line.  
To remove added files, use `git reset HEAD` for all and `git rm --cached *.*` for a file.

## When someone updates the files
```
$ git pull
```
`pull` should be done first in case codes are modified.　`pull` does `fetch` and `merge` at the same time (to know more about `fetch` --> [link](http://qiita.com/osamu1203/items/cb94ef9da02e1ec3e921)).

## gitignore
```
*.out
._*
/.gitignore
/.cache
_*.*
*.swp
.*.*
*-checkpoint.ipynb
.DS_Store
```

## Use Branch
### Initialize Branch
```terminal
$ git branch branchname
```
Check the branches you have:
```terminal
$ git branch
$ git checkout -b branch // Make a new branch and checkout
```

### Change branch and make push
Commit files before you checkout, otherwise updated files reamin.
```terminal
$ git add *
$ git commit -m "your comments"
$ git checkout master
```
Another option is use `git stash` before switch the branch. You can `git stash apply` to resume.

Commit and push:
```terminal
$ git add *
$ git commit -m "your comments"
$ git push origin branchname
```
### Delete branch
```terminal
$ git branch -d branchname
```

### Merge Branch
It is always better to do it on GitHub. Before merge, do not forget to update the merged branch.

#### Normal
```terminal
$ git commit -m "your comments"
$ git checkout master
$ git merge <branchname>
```
#### --no-ff option
```terminal
$ git checkout mergeTo
$ git merge --no-ff mergeFrom
```

#### You have changed both original and branched
Delete original modification and use version in the branch
```terminal
$ git checkout <branchname>
$ git rebase master
$ git checkout master
$ git merge <branchname>
```

## If you get an error
This can get you back before you try to merge something
```terminal
$ git reset --hard HEAD~
```

## Pull Request
```terminal
$ git branch  # check current branch
$ git checkout -b update-readme # create a branch for pull request
-- Do some modification using your favorite editor --
$ git add *
$ git commit -m "Update"
$ git push origin update-readme
```
From here, move to GitHub website. Push Compare & pull request button and send a Pull Request.


## Resolve Conflict
```terminal
git checkout --theirs .  # merge元を採用
git checkout --ours .    # 今のディレクトリのファイルを採用
```
Another example
```terminal 
# now at master
$ git branch
 * master
   branchA

# merge
$ git merge branchA

# xxx.R conflicts! I want to use xxx.R in branchA
$ git checkout --theirs xxx.R

# yyy.R conflicts! I want to use yyy.R in master
$ git checkout --ours yyy.R

# Commit
$ git add *
$ git commit -m "Resolved Conflict"
```

## When push is rejected
[Reference](https://www.softel.co.jp/blogs/tech/archives/3569)
```terminal
git fetch 
git rebase origin/master
```

## Create a new repository from Terminal
Follow the GitHub instruction. Do **NOT** create `README.md` at this point.  
After that, this code might be useful.
```terminal
git branch --set-upstream-to=origin/master master
```
I still recommend you to create repo on GitHub at first, and then clone it.

## Change Previous Committed Comment
```terminal
git commit --amend -m "New Comment"
```

## Get a branch on GitHub
Supporse your collague made a branch titled `branch-test` on GitHub and you want to check it on your computer.
```terminal
$ git checkout -b branch-test-local`
$ git pull origin branch-test`
```
If you pull the branch on `master`, it will be a mess!

## Get back to previous commits
Reset all files to previous commits:
```terminal
$ git reset --hard HEAD  #back to the most resent commit
```

Cancel the last `git reset`
```terminal
$ git reset --hard ORIG_HEAD
```
