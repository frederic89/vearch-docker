#!/bin/bash
docker pull yunzhuqing/vearch:0.3

docker network create -d bridge --subnet 172.40.0.0/16 vearch

docker run -d --name mearch-master -e TZ=Asia/Shanghai -it -v $PWD/config.toml:/vearch/config.toml --network vearch --ip 172.40.1.4 -p 8817:8817 yunzhuqing/vearch:0.3 master

docker run -d --name mearch-router -e TZ=Asia/Shanghai -it -v $PWD/config.toml:/vearch/config.toml --network vearch --ip 172.40.1.5 -p 9901:9001 yunzhuqing/vearch:0.3 router

docker run -d --name mearch-ps -e TZ=Asia/Shanghai -it -v $PWD/config.toml:/vearch/config.toml --network vearch --ip 172.40.1.6 -p 9981:8081 yunzhuqing/vearch:0.3 ps