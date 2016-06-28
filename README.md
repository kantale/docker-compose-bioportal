
# A docker compose for BioPortal

## Run the containers

`docker-compose up -d`

## Stop the containers

`docker-compose down`


## Using

Docker version 1.11.2

* 4store (vemonet/bioportal-4store)
* mgrep (vemonet/bioportal-mgrep)
* solr (vemonet/bioportal-solr)
* redis (redis:3.0.7-alpine)

## Sample config file

A sample config file for ontologies_api and ncbo_cron is also available in `config.rb.sample`

It is using the `/srv/bioportal` directory to store ontologies and other data linked to the app (feel free to change it)
