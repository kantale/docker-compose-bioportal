
# A docker compose for BioPortal API and the Annotator Proxy

## Services provided
This docker compose launches all the services necessary to run ontologies-api and ncbo_cron:
  - redis-goo, redis-annotator, redis-http
  - solr
  - mgrep (accessible on local host port 55555)
  - 4store (accessible on local host post 9000)
  - bioportal-api (runs nginx/ontologies-api/ncbo_cron/sshd, ontologies_api accessible on the host through port 8080, sshd is accessible on the host port 2222 and is used by the administration scripts provided) 
  - bioportal-annotator-proxy (accessible on the host machine on port 8081)

The docker files of each of the services above confingures them properly to all run together and bind all the persistant data in the `data/`.

##Deployment and initial set-up

The first step in deploying this docker compose is to clone this repository:
```
  git clone 
```

Subsequently, administration scripts are provided so set-up the environment, start the services and populate the triple store, caches and dictionary with ontologies. They are numbered in the order in which they should be run the first time you set-up.
### 0_purge_data_optional.sh (Optional)
 Erases all the persistant data in order to reset everything. This step is unnecessary when you fist setup the docker compose.

### 1_prepare_data.sh

This script allows you to retrieve all the ontologies you need from NCBO bioportal (English) or LIRMM (French) for the ontologies with no licence restrictions. 

The script takes three arguments:
  - The first argument is the portal from which to fetch the ontologies (lirmm or ncbo).
  - The second argument is your api-key from the selected portal (you must create an account for free on the portal to obtain the api-key). 
  - The last argument is the list of ontology acronyms to retrieve from the selected portal (you may find the list of ontologies on the portal). 

If the process is interrupted, you can run the script again, it will not redownload ontologies that were already downloaded before. The ontologies downloaded are saved in the `data/bioportal/repository/` directory, if you mistakingly included an ontology you do not need, you may delete it directly from this directory. 

Alternatively, instead of running this script you may manually put the ontologies in the `data/bioportal/repository/` directory if you already have them with the name ACRONYM.ttl, where ACRONYM is the acronym of each ontology.
 
### 2_build_containers.sh 
This script will check if you have an ssh key, generate one if need be and add it to the authorized keys for the bioportal-api container. Subsequently, it will run `docker-compose build` to build all the containers prior to running them.

### 3_start_containers.sh
This script will run `docker-compose up -d --force-recreate` to start all the containers and services. This is required before being able to populate the databases. 

### 4_populate.sh 
This script will populate the different services with the ontologies in `data/bioportal/repository`. This step is very time and ressource consuming. Although it does not block, it sets off the full parsing, loading, indexing, caching and dictionary generation in the background. This process may take several hours to complete depending on the number and size of the ontologies selected. You may want to monitor the CPU activity of the dockerd process to determine when the population process is over. 

### 5_stop_containers.sh
Once the intexing process is over, you may use this script to stop the containers, it merely runs `docker-compose down`.

### Day to day operations
Once the appliance is populated, you can directly use `docker-compose up -d --force-recreate` to start the services and `docker-compose down` to stop the services. 

If you subsequently add ontologies in `data/bioportal/repository`, they will automatically be indexed in time by ncbo_cron process in the bioportal-api container. 

If you wish to start from scratch, you may use the `0_purge_data_optional.sh` script to purge all the data and then repeat the initial setup-process by running scripts from 1 to 5 as extplained above.

## Requirements and dependencies on the host machine

Use the latest version of Docker on a linux host with an up to date kernel (prefarably the latest stable release of the upstream branch). 

Warning: The native version of docker for MacOS contains active bugs that cause the docker deamon to hang-up during the indexation process. If you wish to use this docker-compose on a MacOS host, you may want to use docker-toolkit and docker-machine to create a virtualized docker environemnt. Alternatively you may install docker in a virtual machine and deploy docker compose inside the virtual machine. The same may be true on a Windows machine with the native windows version of docker. 

### Utilities required for the deployment process
The depolyment and set-up process requires a number of basic utilities to run:
  - curl 
  - wget
  - jq (a json parser) 
  - ssh (client)


curl is required by `1_prepare_data.sh` and `4_populate.sh`.

ssh is required for `4_populate.sh`.

wget and jq are only required for `1_prepare_data`. 
