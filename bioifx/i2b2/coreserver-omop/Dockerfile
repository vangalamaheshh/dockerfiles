FROM jboss/wildfly:10.0.0.Final

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

#------------------------------------------#
#             PREREQUISITES                #
#------------------------------------------#
USER root

RUN set -ex \
  && yum install -y git

#------------------------------------------#
#                                          #
#    Alter JBOSS ports to 9090 and 9009    #
#                                          #
#------------------------------------------#
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
#USER jboss

WORKDIR /opt/jboss

ENV AXIS_VERSION "1.7.1"

RUN set -ex \
  && curl -O http://archive.apache.org/dist/axis/axis2/java/core/${AXIS_VERSION}/axis2-${AXIS_VERSION}-war.zip \
  && unzip axis2-${AXIS_VERSION}-war.zip axis2.war \
  && mkdir -p ${JBOSS_HOME}/standalone/deployments/i2b2.war \
  && unzip -d ${JBOSS_HOME}/standalone/deployments/i2b2.war axis2.war \
  && rm -f axis* \
  && touch ${JBOSS_HOME}/standalone/deployments/i2b2.war.dodeploy


#-------------------------------------------#
#                                           #
#          I2B2 Data Installation           #
#                                           #
#-------------------------------------------#
RUN set -ex \
  && mkdir -p /opt/jboss/i2b2

WORKDIR /opt/jboss/i2b2

RUN set -ex \
  && git clone https://github.com/i2b2/i2b2-core-server \
  && cd i2b2-core-server \
  && git checkout -b stable_one 6925c2602440d1d58768ace2da18ba62003e950e \
  && cd .. \
  && git clone https://github.com/i2b2/i2b2-data 

COPY config/data-repo/db.Crcdata.properties /opt/jboss/i2b2/i2b2-data/edu.harvard.i2b2.data/Release_1-7/NewInstall/Crcdata/db.properties
COPY config/hive/db.Hivedata.properties /opt/jboss/i2b2/i2b2-data/edu.harvard.i2b2.data/Release_1-7/NewInstall/Hivedata/db.properties
COPY config/im/db.Imdata.properties /opt/jboss/i2b2/i2b2-data/edu.harvard.i2b2.data/Release_1-7/NewInstall/Imdata/db.properties
COPY config/meta/db.Metadata.properties /opt/jboss/i2b2/i2b2-data/edu.harvard.i2b2.data/Release_1-7/NewInstall/Metadata/db.properties
COPY config/pm/db.Pmdata.properties /opt/jboss/i2b2/i2b2-data/edu.harvard.i2b2.data/Release_1-7/NewInstall/Pmdata/db.properties
COPY config/workplace/db.Workdata.properties /opt/jboss/i2b2/i2b2-data/edu.harvard.i2b2.data/Release_1-7/NewInstall/Workdata/db.properties


#--------------------------------------------#
#                                            #
#        I2B2 SERVER COMMON, PM, ONTOLOGY    #
#         CRC, WORKPLACE, FR & IM cells      #
#--------------------------------------------#
RUN set -ex \
  && sed -i "s|\(jboss\.home\)=.*|\1=${JBOSS_HOME}|g" /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.server-common/build.properties \
  && sed -i "s|\(jboss\.home\)=.*|\1=${JBOSS_HOME}|g" /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.pm/build.properties \
  && sed -i "s|\(jboss\.home\)=.*|\1=${JBOSS_HOME}|g" /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.ontology/build.properties \
  && sed -i "s|wildfly-10.0.0.Final|jboss/wildfly|g" /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.ontology/etc/spring/ontology_application_directory.properties \
  && sed -i "s|\(jboss\.home\)=.*|\1=${JBOSS_HOME}|g" /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.crc/build.properties \
  && sed -i "s|wildfly-10.0.0.Final|jboss/wildfly|g" /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.crc/etc/spring/crc_application_directory.properties \
  && sed -i "s|\(jboss\.home\)=.*|\1=${JBOSS_HOME}|g" /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.workplace/build.properties \
  && sed -i "s|wildfly-10.0.0.Final|jboss/wildfly|g" /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.workplace/etc/spring/workplace_application_directory.properties \
  && sed -i "s|\(jboss\.home\)=.*|\1=${JBOSS_HOME}|g" /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.fr/build.properties \
  && sed -i "s|wildfly-10.0.0.Final|jboss/wildfly|g" /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.fr/etc/spring/fr_application_directory.properties \
  && sed -i "s|\(jboss\.home\)=.*|\1=${JBOSS_HOME}|g" /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.im/build.properties \
  && sed -i "s|wildfly-10.0.0.Final|jboss/wildfly|g" /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.im/etc/spring/im_application_directory.properties

COPY config/pm/pm-ds.xml /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.pm/etc/jboss/pm-ds.xml
COPY config/ontology/ontology.properties  /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.ontology/etc/spring/ontology.properties
COPY config/ontology/ont-ds.xml /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.ontology/etc/jboss/ont-ds.xml
COPY config/data-repo/crc.loader.properties /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.crc/etc/spring/edu.harvard.i2b2.crc.loader.properties
COPY config/data-repo/CRCLoaderApplicationContext.xml /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.crc/etc/spring/CRCLoaderApplicationContext.xml
COPY config/data-repo/crc.properties /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.crc/etc/spring/crc.properties
COPY config/data-repo/crc-ds.xml /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.crc/etc/jboss/crc-ds.xml
COPY config/workplace/workplace.properties /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.workplace/etc/spring/workplace.properties
COPY config/workplace/work-ds.xml /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.workplace/etc/jboss/work-ds.xml
COPY config/file-repo/file-repo.properties /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.fr/etc/spring/edu.harvard.i2b2.fr.properties
COPY config/id-mgmt/id-mgmt.properties /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.im/etc/spring/im.properties
COPY config/id-mgmt/im-ds.xml /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.im/etc/jboss/im-ds.xml

#----------------------------------------------------#
#                                                    #
#                    OMOP SUPPORT                    #
#                                                    #
#----------------------------------------------------#
# Make sure you volume mount to  /opt/jboss/i2b2/i2b2-omop-data


#---------------       EXPORT PATH     --------------#
ENV PATH "${JAVA_HOME}/bin:${JBOSS_HOME}/bin:${ANT_HOME}/bin:$PATH"

#---------------      EXPOSE PORTS     --------------#
EXPOSE 9090
EXPOSE 9009


#---------------      COPY SCRIPTS     --------------#
COPY install_i2b2_cells.bash /opt/jboss/i2b2/install_i2b2_cells.bash
COPY cmd.bash /opt/jboss/cmd.bash



#----       RUN DATA INSTALLATION SCRIPT      --------#
#----       followed by Cells installation.   --------#
ENV LOAD_DATA "" # if true loads data into oracle
CMD ["/bin/bash", "/opt/jboss/cmd.bash"]

