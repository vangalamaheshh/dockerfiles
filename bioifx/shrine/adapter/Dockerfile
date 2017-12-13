FROM mvangala/base-shrine:latest

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

#------------------------------------------------------------#
#                                                            #
#        DOWNLOAD MYSQL DRIVERS & DEMO DATA                  #
#                                                            #
#------------------------------------------------------------#
ENV SHRINE_DEMO_URL "https://open.med.harvard.edu/svn/shrine-ontology/SHRINE_Demo_Downloads/trunk"

RUN set -ex \
  && mkdir -p /opt/shrine/tomcat/webapps/shrine/WEB-INF/lib \
  && wget http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.38/mysql-connector-java-5.1.38.jar \
      -O /opt/shrine/tomcat/webapps/shrine/WEB-INF/lib/mysql-connector-java-5.1.38-bin.jar

RUN set -ex \
  && cd /opt/shrine/tomcat/lib \
  && wget ${SHRINE_DEMO_URL}/AdapterMappings_i2b2_DemoData.csv -O AdapterMappings.csv \
  && wget ${SHRINE_DEMO_URL}/AdapterMappings_i2b2_DemoData.xml -O AdapterMappings.xml \
  && wget ${SHRINE_DEMO_URL}/SCHEMES.sql \
  && wget ${SHRINE_DEMO_URL}/ShrineDemo.sql

