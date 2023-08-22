# ##############################################################################
# # File: Dockerfile                                                           #
# # Project: yapi-docker                                                       #
# # Created Date: 2023/08/22 17:00:17                                          #
# # Author: realjf                                                             #
# # -----                                                                      #
# # Last Modified: 2023/08/22 17:06:59                                         #
# # Modified By: realjf                                                        #
# # -----                                                                      #
# # Copyright (c) 2023                                                         #
# ##############################################################################

FROM node:12.22.11-stretch
LABEL maintainer=realjf<admin@example.com>
ENV VERSION 	1.12.0
ENV HOME        "/home"
ENV PORT        3000
ENV ADMIN_EMAIL "admin@example.com"
ENV DB_SERVER 	"yapi-mongo"
ENV DB_NAME 	"yapi"
ENV DB_PORT 	27017


COPY config.json ${HOME}
COPY wait-for-it.sh /

RUN npm config set registry https://registry.npm.taobao.org && \
    npm install -g yapi-cli && \
    npm cache clean --force

EXPOSE ${PORT}
ENTRYPOINT ["entrypoint.sh"]
