#!/bin/bash
rm -rf data/var/run/*
rm -rf data/ncbo_logs/*
docker-compose up -d --force-recreate
#echo "Startup in progress (120s timeout before populate), showing logs:"
#timeout 120s docker-compose logs -f;
echo "sleeping 30 seconds.."
sleep 30
echo "done sleeping"

admin/purge-4store
admin/create-user

echo "Forcing annotatior dictionary generation, this will take a while..."
admin/init-ncbo-cron
admin/populate
admin/regenerate-dictionary


exit 0
