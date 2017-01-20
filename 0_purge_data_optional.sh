#!/bin/bash

sudo rm -fr data/bioportal/repository/*
sudo rm -fr data/4store/*
sudo rm -fr data/redis/goo/*
sudo rm -fr data/redis/http/*
sudo rm -fr data/redis/annotator/*
sudo rm -fr data/solr/core1/data
sudo rm -fr data/solr/core2/data
sudo bash -c 'echo -e "1000\tNULL" > data/mgrep/dictionary.txt'
