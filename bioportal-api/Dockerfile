FROM ruby:2.2.5
EXPOSE 8080

RUN mkdir /srv/ncbo/
RUN mkdir -p /srv/bioportal/reports
RUN mkdir -p /srv/bioportal/repository

RUN cd /srv/ncbo && \
git clone https://github.com/sifrproject/ontologies_api.git && \
git clone https://github.com/sifrproject/ncbo_cron.git && \
cd /srv/ncbo/ontologies_api/ && git checkout sifr && bundle install && \
cd /srv/ncbo/ncbo_cron/ && git checkout sifr && bundle install && \
service ssh start

#RUN gem install rails

COPY ncbo_cron_init /srv/ncbo/

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && apt-get update && \
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
apt-get -y install oracle-java8-installer raptor2-utils

# Copy config files
#COPY nginx.conf /etc/nginx/nginx.conf
#COPY config-ontologies-api.rb /srv/ncbo/ontologies_api/config/config.rb
COPY config-ncbo-cron.rb /srv/ncbo/ncbo_cron/config/config.rb
COPY config-ontologies-api.rb /srv/ncbo/ontologies_api/config/environments/production.rb
COPY unicorn.rb /srv/ncbo/ontologies_api/config/unicorn.rb
COPY french_stop_words.txt /srv/ncbo/ncbo_cron/config/french_stop_words.txt
COPY english_stop_words.txt /srv/ncbo/ncbo_cron/config/english_stop_words.txt
COPY unicorn /srv/ncbo/
COPY run_all /srv/ncbo/

RUN mkdir /root/.ssh/
COPY authorized_keys /root/.ssh/

WORKDIR /srv/ncbo/

# Define default command.
CMD ["/srv/ncbo/run_all"]

