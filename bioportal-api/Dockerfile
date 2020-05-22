FROM ruby:2.3.3
#FROM ruby:latest

EXPOSE 8080

RUN mkdir /srv/ncbo/
RUN mkdir -p /srv/bioportal/reports
RUN mkdir -p /srv/bioportal/repository

RUN cd /srv/ncbo && \
gem install bundler:1.14.6 && \
git clone https://github.com/sifrproject/ontologies_api.git && \
git clone https://github.com/sifrproject/ncbo_cron.git && \
cd /srv/ncbo/ontologies_api/ && git checkout  lirmm &&  sed -i "s/ logger (1.2.8)/logger (1.3.0)/" Gemfile.lock && BUNDLE_SPECIFIC_PLATFORM=true bundle install --jobs=1 && \
cd /srv/ncbo/ncbo_cron/ && git checkout lirmm && git checkout  lirmm &&  sed -i "s/ logger (1.2.8)/logger (1.3.0)/" Gemfile.lock && BUNDLE_SPECIFIC_PLATFORM=true bundle install --jobs=1

#RUN gem install rails

COPY ncbo_cron_init /srv/ncbo/
COPY key.txt /

#RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
#echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
#apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1397BC53640DB551 && \
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AA8E81B4331F7F50 && \
#apt-key add /key.txt && \
#apt-get update && \
#echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
#echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
#apt-get install  -y software-properties-common && \
#add-apt-repository ppa:openjdk-r/ppa && \
#apt-get update && \
#apt-get -y install oracle-java8-installer raptor2-utils


RUN apt-get update && apt-get -y install raptor2-utils

RUN apt-get install -y default-jdk

# OPENJDK8 FROM SOURCE
COPY makefile.patch /
COPY adjust-mflags.patch /

RUN apt-get update && \
apt-get install -y cpio unzip zip libX11-dev libxext-dev libxrender-dev libxtst-dev libxt-dev libcups2-dev libasound2-dev && \
hg clone http://hg.openjdk.java.net/jdk8/jdk8 openjdk8 && \
cd openjdk8 && \
bash get_source.sh && \
bash ./configure && \ 
patch hotspot/make/linux/Makefile /makefile.patch  && \
patch hotspot/make/linux/makefiles/adjust-mflags.sh /adjust-mflags.patch && \
make all && \
make install 




#RUN apt-get update && \
#apt-get install  -y software-properties-common && \
#add-apt-repository ppa:webupd8team/java && \
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AA8E81B4331F7F50 && \
#apt-get update && \
#apt-get install -y oracle-java8-installer

#apt-get install -y openjdk-8-jdk


#RUN apt-get update && \
#apt-get install  -y software-properties-common && \
#apt install -t jessie-backports  openjdk-8-jre-headless ca-certificates-java && \
#add-apt-repository ppa:openjdk-r/ppa && \
#echo "deb [check-valid-until=no] http://cdn-fastly.deb.debian.org/debian jessie main" > /etc/apt/sources.list.d/jessie.list && \
#echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list && \
#sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list && \
#apt-get -o Acquire::Check-Valid-Until=false update && \
#apt install -t jessie-backports openjdk-8-jre-headless ca-certificates-java 

#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AA8E81B4331F7F50 && \
#echo deb http://http.debian.net/debian jessie-backports main >> /etc/apt/sources.list && \
#apt-get update && \
#apt-get install -y openjdk-8-jdk



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

WORKDIR /srv/ncbo/

# Define default command.
CMD ["/srv/ncbo/run_all"]

