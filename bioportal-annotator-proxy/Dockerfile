FROM openjdk:8-jdk

RUN cd / && \
wget http://mirrors.ircam.fr/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && \
tar -xzf apache-maven-3.3.9-bin.tar.gz \
&& rm apache-maven-3.3.9-bin.tar.gz


RUN cd / && export PATH=/apache-maven-3.3.9/bin:$PATH && \
git clone https://github.com/sifrproject/annotators.git && \
cd /annotators && \
git checkout docker && \ 
mkdir -p  sifr-bioportal-annotator-proxy/src/main/resources/ && \  
echo "annotatorURI=http://bioportal-api:8080/annotator \nsparqlEndpoint=http://bioportal-4store:9000/sparql/ \ncontext.language=FRENCH" > sifr-bioportal-annotator-proxy/src/main/resources/annotatorProxy.properties && \
mvn clean validate install; cd sifr-bioportal-annotation-model; mvn clean validate install; cd ../sifr-bioportal-annotator-scoring && mvn install && cd ../ && mvn install 

RUN wget http://mirrors.ircam.fr/pub/apache/tomcat/tomcat-6/v6.0.53/bin/apache-tomcat-6.0.53.tar.gz && \
tar -xzf apache-tomcat-6.0.53.tar.gz && \
rm apache-tomcat-6.0.53.tar.gz && \
cd apache-tomcat-6.0.53

RUN cp -r /annotators/sifr-bioportal-annotator-proxy/target/sifr-bioportal-annotator-proxy-0.1-SNAPSHOT.war /apache-tomcat-6.0.53/webapps/annotator.war

COPY server.xml /apache-tomcat-6.0.53/conf/

ENV CATALINA_HOME /apache-tomcat-6.0.53

WORKDIR /annotators/sifr-bioportal-annotator-proxy

EXPOSE 8081

CMD ["/apache-tomcat-6.0.53/bin/catalina.sh", "run"] 


