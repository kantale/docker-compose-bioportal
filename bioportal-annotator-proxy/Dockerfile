FROM openjdk:8-jdk

RUN cd / && \
wget http://mirrors.ircam.fr/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && \
tar -xzf apache-maven-3.3.9-bin.tar.gz \
&& rm apache-maven-3.3.9-bin.tar.gz


RUN cd / && export PATH=/apache-maven-3.3.9/bin:$PATH && \
git clone https://github.com/sifrproject/annotators.git && \
cd /annotators && \ 
mkdir -p  sifr-bioportal-annotator-proxy/src/main/resources/ && \  
echo -e "annotatorURI=http://bioportal-api:8080/annotator \nsparqlEndpoint=http://bioportal-4store:9000/sparql/ \ncontext.language=FRENCH \nserver.encoding = utf8" > sifr-bioportal-annotator-proxy/src/main/resources/annotatorProxy.properties && \
mvn clean validate install; cd sifr-bioportal-annotation-model; mvn clean validate install; cd ../sifr-bioportal-annotator-scoring && mvn install && cd ../ && mvn install 

###RUN apt-get update && apt-get -y install dialog openjdk-8-source tomcat8 

RUN apt-get update && apt-get -y install dialog
RUN apt-get install -y default-jdk

ENV TOMCAT_VERSION 8.0.53

## Add tomcat
RUN wget --no-cookies https://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tgz && \
tar xzvf /tmp/tomcat.tgz -C /var/lib && \
mv /var/lib/apache-tomcat-${TOMCAT_VERSION} /var/lib/tomcat && \
rm /tmp/tomcat.tgz && \
rm -rf /var/lib/tomcat/webapps/examples && \
rm -rf /var/lib/tomcat/webapps/docs && \
rm -rf /var/lib/tomcat/webapps/ROOT

ENV CATALINA_HOME /var/lib/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin


RUN mkdir -p /var/lib/tomcat8/webapps/annotator && cp -r /annotators/sifr-bioportal-annotator-proxy/target/annotator.war /var/lib/tomcat8/webapps/annotator/annotator.war  && cd /var/lib/tomcat8/webapps/annotator/ && unzip annotator.war
 
#COPY server.xml /etc/tomcat8/
COPY server.xml /var/lib/tomcat/conf/
COPY start.sh /usr/bin/

WORKDIR /annotators/sifr-bioportal-annotator-proxy

EXPOSE 8081

CMD ["/bin/bash" ,"/usr/bin/start.sh"] 


