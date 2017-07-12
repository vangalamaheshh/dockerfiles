FROM ubuntu:16.04 

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

#------------------------------#
#                              #
#     INSTALL JAVA 8.0         #
#                              #
#------------------------------#
RUN set -ex \
  && apt-get update -y \
  && apt-get install -y build-essential libxml2-dev libcurl4-openssl-dev curl unzip git \
  && apt-get install -y software-properties-common vim \
  && add-apt-repository ppa:webupd8team/java \
  && apt-get update -y \
  && echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections \
  && apt-get install -y oracle-java8-installer

ENV JAVA_HOME "/usr/lib/jvm/java-8-oracle"

#-------------------------------#
#                               #
#   JBOSS WILDFLY 10.0.0.Final  #
#                               #
#-------------------------------#
ENV WILDFLY_VERSION 10.0.0.Final
ENV WILDFLY_SHA1 c0dd7552c5207b0d116a9c25eb94d10b4f375549 
ENV JBOSS_HOME /usr/local/bin/wildfly/wildfly-$WILDFLY_VERSION
ENV LAUNCH_JBOSS_IN_BACKGROUND true

RUN set -ex \
  && mkdir -p /usr/local/bin/wildfly

WORKDIR /usr/local/bin/wildfly

RUN set -ex \
  && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
  && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
  && tar -zxvf wildfly-$WILDFLY_VERSION.tar.gz

EXPOSE 8080
EXPOSE 8009

# CMD ["/usr/local/bin/wildfly/wildfly-10.0.0.Final/bin/standalone.sh", "-b", "0.0.0.0"]

#--------------------------------#
#                                #
#       Apache Ant 1.9.6         #
#                                #
#--------------------------------#
ENV APACHE_ANT_VERSION "apache-ant-1.9.6"
ENV ANT_HOME "/usr/local/bin/apache-ant/${APACHE_ANT_VERSION}"

RUN set -ex \
  && mkdir -p /usr/local/bin/apache-ant

WORKDIR /usr/local/bin/apache-ant

RUN set -ex \
  && curl -O http://archive.apache.org/dist/ant/binaries/${APACHE_ANT_VERSION}-bin.tar.gz \
  && tar -zxvf apache-ant-1.9.6-bin.tar.gz

#--------------------------------#
#                                #
#      Apache Axis2 1.7.1        #
#                                #
#--------------------------------#
ENV AXIS_VERSION "1.7.1"

RUN set -ex \
  && mkdir -p /usr/local/bin/axis2

WORKDIR /usr/local/bin/axis2

RUN set -ex \
  && curl -O http://archive.apache.org/dist/axis/axis2/java/core/${AXIS_VERSION}/axis2-${AXIS_VERSION}-war.zip \
  && unzip axis2-${AXIS_VERSION}-war.zip

WORKDIR ${JBOSS_HOME}/standalone/deployments

RUN set -ex \
  && mkdir -p i2b2.war \
  && touch i2b2.war.dodeploy \
  && cp /usr/local/bin/axis2/axis2.war ./axis2.zip \
  && unzip -d ./i2b2.war ./axis2.zip \
  && rm ./axis2.zip

ENV PATH "${JAVA_HOME}/bin:${JBOSS_HOME}/bin:${ANT_HOME}/bin:$PATH"


#--------------------------------#
#                                #
#    Install PHP and PHP-CURL    #
#                                #
#--------------------------------#
RUN set -ex \
  && mkdir -p /usr/local/bin/php

WORKDIR /usr/local/bin/php

RUN set -ex \
  && wget -O php.tar.gz http://php.net/get/php-7.1.7.tar.gz/from/this/mirror \
  && tar -zxvf php.tar.gz \
  && cd php-7.1.7 \
  && ./configure --prefix=/usr/local/bin/php --with-curl \
  && make \
  && make install

ENV PATH "/usr/local/bin/php/bin:${PATH}"


#--------------------------------#
#                                #
#          I2B2 code             #
#                                #
#--------------------------------#
RUN set -ex \
  && mkdir -p /usr/local/bin/i2b2

WORKDIR /usr/local/bin/i2b2

RUN set -ex \
  && git clone https://github.com/i2b2/i2b2-core-server \
  && git clone https://github.com/i2b2/i2b2-webclient \
  && git clone https://github.com/i2b2/i2b2-data \
  && git clone https://github.com/i2b2/i2b2-workbench 

COPY db.Crcdata.properties /usr/local/bin/i2b2/i2b2-data/edu.harvard.i2b2.data/Release_1-7/NewInstall/Crcdata/db.properties
COPY db.Hivedata.properties /usr/local/bin/i2b2/i2b2-data/edu.harvard.i2b2.data/Release_1-7/NewInstall/Hivedata/db.properties
COPY db.Imdata.properties /usr/local/bin/i2b2/i2b2-data/edu.harvard.i2b2.data/Release_1-7/NewInstall/Imdata/db.properties
COPY db.Metadata.properties /usr/local/bin/i2b2/i2b2-data/edu.harvard.i2b2.data/Release_1-7/NewInstall/Metadata/db.properties
COPY db.Pmdata.properties /usr/local/bin/i2b2/i2b2-data/edu.harvard.i2b2.data/Release_1-7/NewInstall/Pmdata/db.properties
COPY db.Workdata.properties /usr/local/bin/i2b2/i2b2-data/edu.harvard.i2b2.data/Release_1-7/NewInstall/Workdata/db.properties

COPY install_i2b2_cells.bash /usr/local/bin/i2b2/install_i2b2_cells.bash


#---------------------------------#
#                                 #
#  I2B2-Common-Server Install     #
#                                 #
#---------------------------------#
WORKDIR /usr/local/bin/i2b2/i2b2-core-server/edu.harvard.i2b2.server-common

COPY i2b2-server-common.build.properties build.properties

RUN set -ex \
  && ant clean dist deploy jboss_pre_deployment_setup

