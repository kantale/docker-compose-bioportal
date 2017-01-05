FROM openjdk:8-jdk

RUN cd / && \
wget http://mirrors.ircam.fr/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && \
tar -xzf apache-maven-3.3.9-bin.tar.gz \
&& rm apache-maven-3.3.9-bin.tar.gz


RUN cd  /  && export PATH=/apache-maven-3.3.9/bin:$PATH && \
git clone https://github.com/sifrproject/annotators.git && \
cd annotators &&\
git checkout issues_14_16  &&\
mvn validate && mvn clean install && \
cd sifr-bioportal-annotator-proxy && \
./build_for_docker.sh

WORKDIR /annotators/sifr-bioportal-annotator-proxy

EXPOSE 8081

CMD ["/apache-maven-3.3.9/bin/mvn", "-Djetty.http.port=8081", "jetty:run"] 


