# Docker

Dockerファイルの設定が入ったフォルダを用意

## Build

* Build: `docker build -t <tag> .` 

## Images
* `docker images`

## Containers
* Launched: `docker ps`
* Show all: `docker ps -a`


## Running the docker container
* Launch Docker Desktop
* Make a container and launch it: `docker run --name <name-of-the-container> -it -v ~/Dropbox:/myfile <name-of-the-image> /bin/zsh` (or `/bin/bash`)
* Launch a container (you already have a container, you can see it with `docker ps -a`): `docker start -i <name-of-the-image>`

### VSCode
* After `run`, you can see the container in the side bar (Remote Explorer)
* Select `Attach to Container`
* In the new window, select `open folder`, if you mounted a folder, you can select the folder (probably delete `/root/` and type `/myfile`)
* If you want to use local extensions, go `EXTENSIONS` menu and install extensions to the container


## Stop and Update
When you update the source code, you need to remove the old container ([reference](https://docs.docker.com/get-started/03_updating_app/#update-the-source-code))
* Stop the container: `docker stop <the-container-id>`
* Once it's stopped, we can remove it `docker rm <the-container-id>`
* Stop and remove `docker rm -f <the-container-id>`


## Stop container
* Stop docker run by `<CTRL + C>`
* `docker ps` -> `docker kill <id>`


## Pull container
* `docker pull jupyter/scipy-notebook` (open Docker Desktop first)


References:
* [M1 Mac で Python環境 (Docker + VSCode編)](https://zenn.dev/ochamikan/articles/24465ac14a9e24)
