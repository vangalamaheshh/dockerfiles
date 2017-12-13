FROM centos:7

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN set -ex \
  && yum update -y \
  && yum install -y unzip wget postfix ntp

#----------------------------------------------------------#
#                                                          #
#                INSTALL JAVA JDK 8                        #
#                                                          #
#----------------------------------------------------------#
RUN set -ex \
  && mkdir /opt/java \
  && cd /opt/java \
  && wget --header "Cookie: oraclelicense=accept-securebackup-cookie" \
      http://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-x64.tar.gz \
  && tar -zxvf jdk-8u152-linux-x64.tar.gz

ENV JAVA_HOME /opt/java/jdk1.8.0_152
ENV JRE_HOME /opt/java/jdk1.8.0_152/jre
ENV PATH ${PATH}:${JAVA_HOME}/bin:${JRE_HOME}/bin

#-----------------------------------------------------------#
#                                                           #
#                 INSTALL TOMCAT                            #
#                                                           #
#-----------------------------------------------------------#
RUN set -ex \
  && mkdir -p /opt/shrine/tomcat \
  && cd /opt/shrine/tomcat \
  && wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.39/bin/apache-tomcat-8.0.39.tar.gz \
  && tar -zxvf apache-tomcat-8.0.39.tar.gz -C /opt/shrine/tomcat --strip-components=1 


#-----------------------------------------------------------#
#                                                           #
#            SHRINE WAR FILES & WEB CLIENT                  #
#                                                           #
#-----------------------------------------------------------#
ENV SHRINE_VERSION 1.22.8
ENV SHRINE_NEXUS_URL "https://repo.open.med.harvard.edu/nexus/content/groups/public/net/shrine"

RUN set -ex \
  && cd /opt/shrine/tomcat/webapps \
  && wget ${SHRINE_NEXUS_URL}/shrine-war/${SHRINE_VERSION}/shrine-war-${SHRINE_VERSION}.war -O shrine.war \
  && wget ${SHRINE_NEXUS_URL}/steward/${SHRINE_VERSION}/steward-${SHRINE_VERSION}.war -O steward.war \
  && wget ${SHRINE_NEXUS_URL}/shrine-proxy/${SHRINE_VERSION}/shrine-proxy-${SHRINE_VERSION}.war -O shrine-proxy.war \
  && wget ${SHRINE_NEXUS_URL}/shrine-webclient/${SHRINE_VERSION}/shrine-webclient-${SHRINE_VERSION}-dist.zip -O shrine-webclient.zip \
	&& wget ${SHRINE_NEXUS_URL}/dashboard-war/${SHRINE_VERSION}/dashboard-war-${SHRINE_VERSION}.war -O shrine-dashboard.war \
  && wget ${SHRINE_NEXUS_URL}/meta-war/${SHRINE_VERSION}/meta-war-${SHRINE_VERSION}.war -O shrine-meta.war \
  && unzip shrine-webclient.zip


#------------------------------------------------------------#
#                                                            #
#                COPY CONFIG FILES                           #
#                                                            #
#------------------------------------------------------------#
COPY conf/mysql-context.xml /opt/shrine/tomcat/conf/context.xml 
COPY conf/tomcat-server.xml /opt/shrine/tomcat/conf/server.xml 


#------------------------------------------------------------#
#                                                            #
#        DOWNLOAD MYSQL DRIVERS & DEMO DATA                  #
#                                                            #
#------------------------------------------------------------#
RUN set -ex \
  && mkdir -p /opt/shrine/tomcat/webapps/shrine/WEB-INF/lib \
  && wget http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.38/mysql-connector-java-5.1.38.jar \
      -O /opt/shrine/tomcat/webapps/shrine/WEB-INF/lib/mysql-connector-java-5.1.38-bin.jar

RUN set -ex \
  && mkdir -p /opt/shrine/demo-data \
  && cd /opt/shrine/demo-data \
  && SHRINE_DEMO_DATA="https://open.med.harvard.edu/svn/shrine-ontology/SHRINE_Demo_Downloads/trunk" \
  && wget ${SHRINE_DEMO_DATA}/AdapterMappings_i2b2_DemoData.csv -O AdapterMappings.csv \
  && wget ${SHRINE_DEMO_DATA/SCHEMES.sql \
  && wget ${SHRINE_DEMO_DATA}/ShrineDemo.sql

