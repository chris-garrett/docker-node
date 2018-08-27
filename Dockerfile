FROM node:10.9.0-alpine
MAINTAINER Chris Garrett (https://github.com/chris-garrett/docker-node)
LABEL description="Node image 10.9.0"

ARG DOCKERIZE_VERSION=v0.6.0
COPY ./bash_aliases /home/node/.bashrc
COPY ./vimrc /home/node/.vimrc

RUN apk --no-cache add -U \
    ca-certificates \
    openssl \
    bash \
    vim \
    wget \
    curl \
  && update-ca-certificates \
  && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && npm i -g pm2 \
  && chown node:node /home/node/.bashrc /home/node/.vimrc \
  && ln -sf /usr/bin/vim /usr/bin/vi

USER node
