FROM debian:testing
EXPOSE 9876:9876

RUN mkdir -p /srv/unitex/

WORKDIR /srv/unitex/

RUN apt-get update && \
apt-get install -y build-essential libboost-dev git cmake && \
rm -rf /var/lib/apt/lists/* && \
git clone https://github.com/zevio/recognizer.git && \
git clone https://github.com/UnitexGramLab/unitex-core.git && \
cd unitex-core/build/ && \
make LIBRARY=yes TRE_DIRECT_COMPILE=yes && \
make TRE_DIRECT_COMPILE=yes UNITEXTOOLLOGGERONLY=yes && \
cp ../bin/libunitex.so ../../recognizer/lib/ && \
cd ../../recognizer && \
cmake . && \
make -j4 

COPY run_unitex_blocking /srv/unitex/

VOLUME /srv/unitex/recognizer/data/French/Dela/

CMD ["/srv/unitex/run_unitex_blocking"]
