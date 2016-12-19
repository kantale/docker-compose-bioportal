FROM nginx
COPY nginx.conf /etc/nginx.conf
EXPOSE 8080:80

RUN mkdir /srv/ncbo/
RUN apt-get update
RUN apt-get install -y git
RUN cd /srv/ncbo && git clone https://github.com/sifrproject/ontologies_api.git && git clone https://github.com/sifrproject/ncbo_cron.git

COPY ncbo_cron_init /srv/ncbo/
COPY unicorn /srv/ncbo/

RUN apt-get -y install rbenv

WORKDIR /srv/ncbo/

VOLUME ["/srv"]


