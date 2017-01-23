#!/bin/bash

if [ ! -f ~/.ssh/id_rsa.pub  ]; then
  ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ""
fi
cat ~/.ssh/id_rsa.pub > ./bioportal-api/authorized_keys

mkdir -p data/4store/
mkdir -p data/bioportal/repository/
mkdir -p data/bioportal/reports/
mkdir -p data/redis/goo/
mkdir -p data/redis/http/
mkdir -p data/redis/annotator/
mkdir -p data/ncbo_logs/
docker-compose build
