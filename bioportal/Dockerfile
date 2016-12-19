FROM nginx
COPY nginx.conf /etc/nginx.conf
EXPOSE 8080:80
RUN mkdir /srv/ncbo/
COPY ncbo_cron /srv/ncbo/
COPY ontologies_api /srv/ncbo/
COPY ncbo_cron_init /srv/ncbo/
COPY unicorn /srv/ncbo/

RUN apt-get -y install rbenv

WORKDIR /srv/ncbo/

VOLUME ["/srv"]


