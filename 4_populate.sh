#!/bin/bash

echo "Processing ontologies..."
for ONTFILE in $(ls -1 data/bioportal/repository/*.ttl); do
	ACRONYM=$(basename $ONTFILE | cut -d'.' -f1)
	echo -e "\t$ACRONYM :Creating acronym and submitting ontology file..."
	curl -X POST -H "Content-Type: application/json" -d "{ \"acronym\": \"$ACRONYM\", \"name\": \"$ACRONYM\", \"administeredBy\": [\"admin\"]}"  http://localhost:8080/ontologies &>/dev/null

	curl -X POST -H "Content-Type: application/json" -d "{ \"hasOntologyLanguage\": \"OWL\", \"uploadFilePath\": \"/srv/bioportal/repository/$ACRONYM.ttl\", \"contact\": [{\"name\": \"Admin\", \"email\": \"admin@god.fr\"}],\"released\": \"2015-09-06\"}"  http://localhost:8080/ontologies/$ACRONYM/submissions &>/dev/null

	#echo -e "\tProcessing file..."
	#ssh root@localhost -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -p 2222 "cd /srv/ncbo/ncbo_cron && ruby -EUTF-8 ./bin/ncbo_ontology_process -o $ACRONYM" 2> /dev/null
done

printf "The ontologies have been submitted, the queue will start processing within a minute... The full indexing process may take between mitues and hours depending on the number of ontologies and their size.\n"

printf "I will show you the scheduler logs (tail -f data/ncbo_logs/scheduler.log)\n Please keep the logs open until the process is finishsed. \n \e[92m You will see: \e[1m 'Finished ontology process queue check' \n \e[1m"

sleep 15

tail -f data/ncbo_logs/scheduler.log;

