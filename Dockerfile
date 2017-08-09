FROM node:8.2.1-alpine
MAINTAINER Chris Garrett (https://github.com/chris-garrett/docker-node)
LABEL description="Node image 8.2.1"

ARG DOCKERIZE_VERSION=v0.5.0
COPY ./bash_aliases /home/node/.bashrc
COPY ./vimrc /home/node/.vimrc

RUN apk --no-cache add -U \
    ca-certificates \
    openssl \
  && update-ca-certificates \

  && apk --no-cache add -U \
    bash \
    vim \
    wget \
    curl \

  && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \

  && npm i -g pm2 \

  && chown node:node /home/node/.bashrc /home/node/.vimrc \
  && ln -sf /usr/bin/vim /usr/bin/vi

USER node
