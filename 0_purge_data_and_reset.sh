#!/bin/bash

rm -fr data/bioportal/repository/*
rm -fr data/4store/*
rm -fr data/redis/goo/*
rm -fr data/redis/http/*
rm -fr data/redis/annotator/*
rm -fr data/solr/term_search_core1/data
rm -fr data/solr/term_search_core2/data
rm -fr data/solr/prop_search_core1/data
rm -fr data/solr/prop_search_core2/data
rm -fr data/ncbo_logs/*

bash -c 'echo -e "1000\tNULL" > data/mgrep/dictionary.txt'
