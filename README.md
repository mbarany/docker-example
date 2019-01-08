# Docker
Introduction to Docker example and notes

## What is docker?
- https://www.itzgeek.com/wp-content/uploads/2017/05/Build-Docker-Images-with-DockerFile.png
- https://images.idgesg.net/images/article/2017/06/virtualmachines-vs-containers-100727624-large.jpg


## Installation (Mac)
```bash
brew cask install docker
```


## Terminology
- docker file (Dockerfile)
- docker image (eg. `nginx:latest`)
- docker container
- docker volume
- docker network
- docker registry (dockerhub, ECR)
- docker-compose


## Image naming & tags
- mbarany/docker-example
- mbarany/docker-example:latest
- mbarany/docker-example:1.0
- ubuntu:18.04
- nginx:latest


## Dockerfile
Documentation: https://docs.docker.com/engine/reference/builder/#from

Dockerfile Example:
```Dockerfile
FROM ubuntu:18.04
COPY . /app
RUN make /app
CMD python /app/app.py
```


## Docker Registry
https://hub.docker.com/
- pull images
  ```bash
  docker pull nginx:latest
  ```
- push images
  ```bash
  docker push mbarany/docker-example:latest
  ```


## Library
https://hub.docker.com/u/library
- Ubuntu
- Postgres
- MySQL
- Redis
- Python
- Nginx


## run
```bash
docker run alpine /bin/sh
# The following subshell will run on the host (as expected)
docker run alpine echo "hi from alpine: $(uname -rs)"
docker run alpine sh -c 'echo "hi from alpine: $(uname -rs)" && echo "more stuff"'
docker run -it alpine /bin/sh
docker run -it --rm alpine
docker run -it --rm --name my-alpine alpine
```
- Use `--rm`
- Use `--name <container name>`


## Path to a Container
1. Create Dockerfile
1. Build Dockerfile and create Image
1. Start container with a given Image


## build
```bash
docker build -t mbarany/docker-example .
docker build -t mbarany/docker-example:latest .
docker build -f Dockerfile -t mbarany/docker-example:latest .
```


## exec
```bash
docker exec -it <container> /bin/sh
```


## logs
```bash
docker logs -f nginx
docker logs -f --tail 50 nginx
```


# Part 2


## port bindings
```bash
# Publish all
docker run --rm -d --name nginx -P nginx
# Publish list
docker run --rm -d --name nginx -p 80 nginx
docker run --rm -d --name nginx -p 9999:80 nginx
```


## volumes
```bash
# List volumes
docker volume ls
# Map volume
docker run --rm -it --name myapp -v "$(pwd)":/app alpine
# Make it read only
docker run --rm -it --name myapp -v "$(pwd)":/app:ro alpine
# Create a volume
docker volume create foobar
docker run --rm -it --name myapp -v foobar:/app/foobar alpine
```


## docker-compose
```yaml
version: '3.4'

services:
  app:
    build: .
    depends_on:
     - db
     - redis
    volumes:
      - ./:/app
    environment:
      FOOBAR: bar
    env_file:
      - .env

  db:
    image: postgres:10-alpine

  redis:
    image: redis:alpine
```
https://docs.docker.com/compose/compose-file/

`docker-compose up -d`


# Part 3


## docker-compose examples
View advanced examples of docker-compose.yml files


## networking
https://docs.docker.com/network/
- host
- bridge
- none
```bash
# List networks
docker network ls
# Create network
docker network create foo
# Delete network
docker network rm foo
```


## restart policy
https://docs.docker.com/compose/compose-file/compose-file-v2/#restart
https://docs.docker.com/compose/compose-file/#restart_policy


## Alpine
Tiny linux distro. Perfect for a docker container base
- `apk` Package manager


## Entrypoint VS CMD
https://stackoverflow.com/questions/21553353/what-is-the-difference-between-cmd-and-entrypoint-in-a-dockerfile/21564990#21564990


## docker inspect
```bash
docker inspect mbarany/docker-example
# brew install dive
dive mbarany/docker-example
```

## Scratch
This is where all docker images begin
https://hub.docker.com/_/scratch


## Other docker things
- https://github.com/veggiemonk/awesome-docker


# License
Copyright 2018 Michael Barany

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
