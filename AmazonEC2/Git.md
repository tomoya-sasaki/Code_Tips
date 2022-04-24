## Git

### Personal Access Token
It's the easiest to use [a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).
```terminal
$ git clone https://github.com/username/repo.git
Username: your_username
Password: your_token
```

### fetching remote branches
```terminal
$ git fetch
$ git branch -a
  * main
  remotes/origin/branchA
  remotes/origin/branchB
$ git checkout branchA  # switch to the remote branch
```
