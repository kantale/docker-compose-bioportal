# Docker container for NCBO 4-store
#
# VERSION 0.1

# Pull base image.
FROM debian

MAINTAINER Vincent Emonet, vincent.emonet@gmail.com

# Install packages.
RUN apt-get update && \
    apt-get install -y git make automake gperf libtool flex bison \
            libssl-dev libraptor2-0 librasqal3 libraptor2-dev \
            librasqal3-dev ncurses-base libncurses5 \
            libncurses5-dev libreadline6-dev uuid-dev libglib2.0-dev && \
    rm -rf /var/lib/apt/lists/*



# Install 4store
RUN \
  cd /tmp && \
  git clone https://github.com/ncbo/4store.git && \
  cd 4store && \
  ./autogen.sh && \
  ./configure && \
  make && \
  make install

# Define working directory.
WORKDIR /data

RUN mkdir -p /srv/4store/data

VOLUME /srv/4store/data

COPY run-4store /usr/bin/

# Define default command.
CMD ["/usr/bin/run-4store"]

# docker run -d -p 9000:9000 vemonet/bioportal-4store
