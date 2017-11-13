# Docker container for NCBO 4-store
#
# VERSION 0.1

# Pull base image.
FROM debian

EXPOSE 8983:8983

MAINTAINER Vincent Emonet, vincent.emonet@gmail.com

# Install packages.
RUN apt-get update && \
            apt-get install -y git wget openjdk-8-jre-headless && \
    rm -rf /var/lib/apt/lists/*


RUN mkdir -p /opt/solr
# Install solr
RUN \
  cd /opt/solr && \
  wget http://archive.apache.org/dist/lucene/solr/4.10.4/solr-4.10.4.tgz && \
  tar -xzf solr-4.10.4.tgz && \
  cp -r /opt/solr/solr-4.10.4/example/* /opt/solr/ && \
  rm -rf /opt/solr/solr-4.10.4

# Define working directory.
WORKDIR /opt/solr

# Define default command.
CMD ["java", "-Dsolr.solr.home=solr", "-jar", "start.jar"]

# docker run -d -p 9000:9000 vemonet/bioportal-4store
