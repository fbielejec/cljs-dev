#!/bin/bash

TAG=$(git log -1 --pretty=%h)

docker build -t nodrama/cljs-dev:$TAG .

docker tag nodrama/cljs-dev:$TAG nodrama/cljs-dev:latest

docker login
docker push nodrama/cljs-dev
