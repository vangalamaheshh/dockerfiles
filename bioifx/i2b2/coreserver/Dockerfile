FROM jboss/wildfly:10.0.0.Final

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

#------------------------------------------#
#                                          #
#    Alter JBOSS ports to 9090 and 9009    #
#                                          #
#------------------------------------------#
USER root

RUN set -ex \
  && sed -i "s|\(http\.port\):8080|\1:9090|g" /opt/jboss/wildfly/standalone/configuration/standalone.xml \
  && sed -i "s|\(ajp\.port\):8009|\1:9009|g" /opt/jboss/wildfly/standalone/configuration/standalone.xml


#------------------------------------------#
#                                          #
#            Apache Ant 1.9.6              #
#                                          #
#------------------------------------------#
ENV APACHE_ANT_VERSION "apache-ant-1.9.6"

RUN set -ex \
  && mkdir -p /usr/local/bin/apache-ant

WORKDIR /usr/local/bin/apache-ant

RUN set -ex \
  && curl -O http://archive.apache.org/dist/ant/binaries/${APACHE_ANT_VERSION}-bin.tar.gz \
  && tar -zxvf apache-ant-1.9.6-bin.tar.gz

#JAVA_HOME is already defined
ENV JBOSS_HOME /opt/jboss/wildfly 
ENV ANT_HOME "/usr/local/bin/apache-ant/${APACHE_ANT_VERSION}"


#-------------------------------------------#
#                                           #
#              Apache Axis2 1.7.1           #
#                                           #
#-------------------------------------------#
USER jboss

WORKDIR /opt/jboss

ENV AXIS_VERSION "1.7.1"

RUN set -ex \
  && curl -O http://archive.apache.org/dist/axis/axis2/java/core/${AXIS_VERSION}/axis2-${AXIS_VERSION}-war.zip \
  && unzip axis2-${AXIS_VERSION}-war.zip axis2.war \
  && mkdir -p ${JBOSS_HOME}/standalone/deployments/i2b2.war \
  && unzip -d ${JBOSS_HOME}/standalone/deployments/i2b2.war axis2.war \
  && rm -f axis* \
  && touch ${JBOSS_HOME}/standalone/deployments/i2b2.war.dodeploy


#---------------       EXPORT PATH     --------------#
ENV PATH "${JAVA_HOME}/bin:${JBOSS_HOME}/bin:${ANT_HOME}/bin:$PATH"

#---------------      EXPOSE PORTS     --------------#
EXPOSE 9090
EXPOSE 9009




