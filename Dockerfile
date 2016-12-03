FROM node:6.9.1-alpine
MAINTAINER Chris Garrett (https://github.com/chris-garrett/docker-node)
LABEL description="Node image 6.9.1"

RUN apk --no-cache add --update \
  bash \
  vim \
  wget \
  curl

ARG DOCKERIZE_VERSION=v0.3.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN npm i -g pm2 && npm cache clean

RUN adduser -s /bin/bash -D sprout

COPY ./bash_aliases /home/sprout/.bashrc
COPY ./vimrc /home/sprout/.vimrc
RUN chown sprout:sprout /home/sprout/.bashrc /home/sprout/.vimrc \
  && ln -sf /usr/bin/vim /usr/bin/vi

USER sprout
