FROM openjdk:8-jdk

RUN cd / && \
wget http://mirrors.ircam.fr/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && \
tar -xzf apache-maven-3.3.9-bin.tar.gz \
&& rm apache-maven-3.3.9-bin.tar.gz


RUN cd / && export PATH=/apache-maven-3.3.9/bin:$PATH && \
git clone https://github.com/sifrproject/annotators.git && \
cd /annotators && git checkout issues_14_16 && \ 
echo "annotatorURI=http://bioportal-api:8080/annotator?" > sifr-bioportal-annotator-proxy/src/main/resources/annotatorProxy.properties && \
mvn clean install

RUN wget http://mirrors.ircam.fr/pub/apache/tomcat/tomcat-6/v6.0.48/bin/apache-tomcat-6.0.48.tar.gz && \
tar -xzf apache-tomcat-6.0.48.tar.gz && \
rm apache-tomcat-6.0.48.tar.gz && \
cd apache-tomcat-6.0.48

RUN cp -r /annotators/sifr-bioportal-annotator-proxy/target/sifr-bioportal-annotator-proxy-0.1-SNAPSHOT.war /apache-tomcat-6.0.48/webapps/annotator.war

COPY server.xml /apache-tomcat-6.0.48/conf/

ENV CATALINA_HOME /apache-tomcat-6.0.48

WORKDIR /annotators/sifr-bioportal-annotator-proxy

EXPOSE 8081

CMD ["/apache-tomcat-6.0.48/bin/catalina.sh", "run"] 


