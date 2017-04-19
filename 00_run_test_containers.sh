#!/bin/bash

# First delete all data to reset properly all containers
./0_purge_data_and_reset.sh

docker-compose -f test.yml up --force-recreate
