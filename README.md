<h2 align="center">Docker for YApi</h2>
<p align="center">一键部署YApi</p>

<p align="center">
<a href="https://travis-ci.org/jinfeijie/yapi"><img src="https://travis-ci.org/jinfeijie/yapi.svg?branch=master" alt="Build Status"></a>
<a href="https://cloud.docker.com/u/mrjin/repository/docker/mrjin/yapi"><img src="https://img.shields.io/docker/automated/mrjin/yapi.svg?style=flat-square" alt=""></a>
<a href="https://github.com/jinfeijie/yapi"><img src="https://img.shields.io/github/license/jinfeijie/yapi.svg?style=flat-square" alt="License"></a>
</p>

## ⚠️注意

⚠️注意：本仓库目前只支持安装，暂不支持升级，请知晓。如需升级请备份mongoDB内的数据。

## 使用

默认密码是：`ymfe.org`，安装成功后进入后台修改

## 可修改变量

| 环境变量       | 默认值         | 建议         |
| ------------- |:-------------:|:-----------:|
| VERSION | 1.12.0  | *强烈建议升级*   |
| HOME | /home | 可修改 |
| PORT | 3000  | 可修改 |
| ADMIN_EMAIL | <admin@example.com>  | 建议修改 |
| DB_SERVER | mongo(127.0.0.1)  | 不建议修改 |
| DB_NAME | yapi  | 不建议修改 |
| DB_PORT | 27017 | 不建议修改|
| VENDORS | ${HOME}/vendors | 不建议修改  |

## 获取本镜像

🚘获取本镜像：`docker pull realjf/yapi:latest`

## docker-compose 部署

```
version: '3.8'
services:
  yapi:
    image: realjf/yapi:v1.12.0
    # build: ./
    container_name: yapi
    environment:
      - VERSION=1.12.0
      - HOME=/home
      - PORT=3000
      - ADMIN_EMAIL=admin@example.com
      - DB_SERVER=yapi-mongo
      - DB_NAME=yapi
      - DB_PORT=27017
    restart: always
    ports:
      - 3000:3000
    volumes:
      - ~/data/yapi/log:/home/log # log dir
    depends_on:
      - yapi-mongo
    entrypoint: "bash /wait-for-it.sh yapi-mongo:27017 -- entrypoint.sh"
    networks:
      - proxy
  yapi-mongo:
    image: mongo
    container_name: yapi-mongo
    restart: always
    environment:
      - TZ=Asia/Shanghai
      - MONGO_INITDB_ROOT_USERNAME=admin
      - MONGO_INITDB_ROOT_PASSWORD=ji239f7&yh@
      - MONGO_INITDB_DATABASE=yapi
    ports:
      - 27017:27017
    volumes:
      - /data/yapi/mongodb:/data/db #db dir
    networks:
      - proxy
networks:
  proxy:
    external: true
    name: nginx-proxy
```

## Nginx 配置

```
server {
    listen     80;
 @@ -91,8 +101,8 @@ server {

1. 修改`docker-compose.yml`文件里面相关参数

2. 创建network：`make create_network`

3. 启动服务：`make up`

✨欢迎 Star && Fork
