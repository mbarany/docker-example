FROM alpine:latest

RUN apk add --no-cache bash

COPY . /app

WORKDIR /app

EXPOSE 80

ENV FOO bar
