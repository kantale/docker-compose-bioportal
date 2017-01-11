FROM ruby:2.2.5
EXPOSE 8080

RUN mkdir /srv/ncbo/

RUN cd /srv/ncbo && git clone https://github.com/sifrproject/ontologies_api.git && git clone https://github.com/sifrproject/ncbo_cron.git

RUN cd /srv/ncbo/ontologies_api/ && bundle install

RUN cd /srv/ncbo/ncbo_cron/ && bundle install 

RUN gem install rails

COPY ncbo_cron_init /srv/ncbo/

RUN apt-get update && apt-get -y install nginx-full openjdk-7-jre-headless raptor2-utils

# Copy config files
COPY nginx.conf /etc/nginx/nginx.conf
#COPY config-ontologies-api.rb /srv/ncbo/ontologies_api/config/config.rb
COPY config-ncbo-cron.rb /srv/ncbo/ncbo_cron/config/config.rb
COPY config-ontologies-api.rb /srv/ncbo/ontologies_api/config/environments/production.rb
COPY unicorn.rb /srv/ncbo/ontologies_api/config/unicorn.rb
COPY french_stop_words.txt /srv/ncbo/ncbo_cron/config/french_stop_words.txt
COPY english_stop_words.txt /srv/ncbo/ncbo_cron/config/english_stop_words.txt
COPY unicorn /srv/ncbo/
COPY run_all /srv/ncbo/
COPY admin_user_init /srv/ncbo/
COPY user_config_script /srv/ncbo

WORKDIR /srv/ncbo/

# Define default command.
CMD ["/srv/ncbo/run_all"]

