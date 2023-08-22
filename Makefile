# ##############################################################################
# # File: Makefile                                                             #
# # Project: yapi-docker                                                       #
# # Created Date: 2023/08/22 16:59:37                                          #
# # Author: realjf                                                             #
# # -----                                                                      #
# # Last Modified: 2023/08/22 16:59:52                                         #
# # Modified By: realjf                                                        #
# # -----                                                                      #
# # Copyright (c) 2023                                                         #
# ##############################################################################


.PHONY: build_docker
build_docker:
	@docker build -f Dockerfile -t realjf/yapi:v1.12.0 .


.PHONY: push_docker
push_docker:
	@docker push realjf/yapi:v1.12.0


.PHONY: create_network
create_network:
	@docker network create nginx-proxy


.PHONY: up
up:
	@docker compose up -d


EMAIL ?= "admin@example.com" # 管理员邮箱
PORT ?= "3000" # 访问端口
DBPORT ?= "27017" # 数据库端口
DBSERVER ?= "yapi-mongo" # 数据库服务名称
DBNAME ?= "yapi"

.PHONY: config
config:
	@sed -i "s,3000,${PORT},g" config.json
	@sed -i "s,admin@example.com,${EMAIL},g" config.json
	@sed -i "s,yapi-mongo,${DBSERVER},g" config.json
	@sed -i "s,yapi,${DBNAME},g" config.json
	@sed -i "s,27017,${DBPORT},g" config.json
