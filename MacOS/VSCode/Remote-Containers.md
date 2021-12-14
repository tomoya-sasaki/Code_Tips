# Remote-Containers

Dockerファイルの設定が入ったフォルダを用意

* Build: `docker build -t <tag> .` 
* Get IDs of the container: `docker ps -a`

Show all containers
* `docker ps -a`

When you update the source code, you need to remove the old container ([reference](https://docs.docker.com/get-started/03_updating_app/#update-the-source-code))
* Stop the container: `docker stop <the-container-id>`
* Once it's stopped, we can remove it `docker rm <the-container-id>`


Running the docker and use it on VSCode
* Make a container and launch it `docker run -d <name>`
* Launch a container `docker start <name>`
* `Shift + command + p` and select `Remote-containers: Attatch to runnning container`

