FROM node:6.9.1-alpine
MAINTAINER Chris Garrett (https://github.com/chris-garrett/docker-node)
LABEL description="Node image 6.9.1"

RUN apk --no-cache add -U ca-certificates openssl && update-ca-certificates
RUN apk --no-cache add -U \
  bash \
  vim \
  wget \
  curl

ARG DOCKERIZE_VERSION=v0.3.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN npm i -g pm2 && npm cache clean

COPY ./bash_aliases /home/node/.bashrc
COPY ./vimrc /home/node/.vimrc
RUN chown node:node /home/node/.bashrc /home/node/.vimrc \
  && ln -sf /usr/bin/vim /usr/bin/vi

USER node
