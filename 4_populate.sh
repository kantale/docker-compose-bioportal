#!/bin/bash

echo "Initializing..."
ssh root@localhost -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -p 2222 "cd /srv/ncbo/ncbo_cron && bundle install" &> /dev/null

ssh root@localhost -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -p 2222 "mkdir -p /srv/bioportal/reports/ && touch /srv/bioportal/reports/ontologies_reports.json || exit" &> /dev/null

echo "Processing ontologies..."
for ONTFILE in $(ls -1 data/bioportal/repository/*.ttl); do
	ACRONYM=$(basename $ONTFILE | cut -d'.' -f1)
	echo -e "\t$ACRONYM..." 
 	echo -e "\tCreating acronym and submitting ontology file..."
	curl -X POST -H "Content-Type: application/json" -d "{ \"acronym\": \"$ACRONYM\", \"name\": \"$ACRONYM\", \"administeredBy\": [\"admin\"]}"  http://localhost:8080/ontologies &>/dev/null

	curl -X POST -H "Content-Type: application/json" -d "{ \"hasOntologyLanguage\": \"OWL\", \"uploadFilePath\": \"/srv/bioportal/repository/$ACRONYM.ttl\", \"contact\": [{\"name\": \"Admin\", \"email\": \"admin@god.fr\"}],\"released\": \"2015-09-06\"}"  http://localhost:8080/ontologies/$ACRONYM/submissions &>/dev/null

	echo -e "\tProcessing file..."
	ssh root@localhost -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -p 2222 "cd /srv/ncbo/ncbo_cron && ruby -EUTF-8 ./bin/ncbo_ontology_process -o $ACRONYM" 2> /dev/null
done

echo "Generating dictionary..."
ssh root@localhost -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -p 2222 "cd /srv/ncbo/ncbo_cron && echo 'yes' | ruby -EUTF-8 ./bin/ncbo_ontology_annotate_generate_dictionary" 2>/dev/null

docker-compose restart bioportal-mgrep




