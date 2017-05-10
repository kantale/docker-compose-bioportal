#!/bin/bash

# First delete all data to reset properly all containers
./0_purge_data_and_reset.sh

cp bioportal-mgrep/resources/dictionary.txt data/mgrep/dictionary.txt

docker-compose -f test.yml up --force-recreate
