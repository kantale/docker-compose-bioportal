#!/bin/bash
docker-compose up -d --force-recreate
echo "Startup in progress, showing logs:"
timeout 90s docker-compose logs -f;
exit 0
