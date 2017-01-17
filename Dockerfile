FROM dduportal/docker-compose:latest
MAINTAINER andon@tchechmedjiev.eu


RUN mkdir /bioportal

COPY bioportal-services /bioportal/
COPY data /bioportal


RUN apt-get update -q && apt-get install -q --no-install-recommends openssh-client 
    cd /bioportal/bioportal-services && \
    ./build.sh 

EXPOSE 8081

VOLUME /var/run/docker.sock:/var/run/docker.sock



WORKDIR /bioportal/bioportal-services/
