#!/bin/bash
 printf "\e[1m Initializing..."
ssh root@localhost -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -p 2222 "cd /srv/ncbo/ncbo_cron && bundle install" &> /dev/null
ssh root@localhost -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -p 2222 "mkdir -p /srv/bioportal/reports/ && touch /srv/bioportal/reports/ontologies_reports.json || exit" &> /dev/null
printf "\e[32m [OK]\e[0m"
