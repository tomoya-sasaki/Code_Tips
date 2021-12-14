# Remote-Containers

Dockerファイルの設定が入ったフォルダを用意

## Build

* Build: `docker build -t <tag> .` 


## Show all containers
* `docker ps -a`


## Running the docker container
* Make a container and launch it
  * `docker -it --rm -name <name-of-the-container> <name-of-the-image>`: `--rm` deletes the container automatically (probably use this for VSCode?) 
  * `docker run -d <name>`
* Launch a container `docker start <name>`
* `Shift + command + p` and select `Remote-containers: Attatch to runnning container`


## Stop and Update
When you update the source code, you need to remove the old container ([reference](https://docs.docker.com/get-started/03_updating_app/#update-the-source-code))
* Stop the container: `docker stop <the-container-id>`
* Once it's stopped, we can remove it `docker rm <the-container-id>`
* Stop and remove `docker rm -f <the-container-id>


## VSCode
* After `run`, you can see the container in the side bar (Remote Explorer)
* Select `Attach to Container`

## Stop container
* Stop docker run by `<CTRL + C>`
* `docker ps` -> `docker kill <id>`


## Pull container
* `docker pull jupyter/scipy-notebook` (open Docker Desktop first)


References:
* [M1 Mac で Python環境 (Docker + VSCode編)](https://zenn.dev/ochamikan/articles/24465ac14a9e24)
