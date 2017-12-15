FROM openjdk:8-jdk
EXPOSE 55555:55555

RUN cd / && \
wget http://mirrors.ircam.fr/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && \
tar -xzf apache-maven-3.3.9-bin.tar.gz \
&& rm apache-maven-3.3.9-bin.tar.gz


RUN export PATH=/apache-maven-3.3.9/bin:$PATH && \
    cd / && \
    git clone https://github.com/twktheainur/BPClinicalRecognizer bpclinrec && \
    cd bpclinrec && \
    mvn clean install

RUN mkdir -p /bpclinrec/dictionary



COPY run_blocking /bpclinrec

VOLUME /bpclinrec/dictionary

CMD ["/bpclinrec/run_blocking"]
