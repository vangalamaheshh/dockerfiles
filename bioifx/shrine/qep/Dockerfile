FROM mvangala/base-shrine:1.22.8

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

COPY conf/shrine.conf /opt/shrine/tomcat/lib/shrine.conf
COPY conf/tomcat-server.xml /opt/shrine/tomcat/conf/server.xml 

#------------------------------------------------------------#
#                                                            #
#                 GENERATE KEYSTORE                          #
#                                                            #
#------------------------------------------------------------#
#COPY conf/keytool.sh ${JAVA_HOME}/bin/qep-keytool.sh
#RUN set -ex \
#  && cd ${JAVA_HOME}/bin \
#  && bash qep-keytool.sh \
#  && cp shrine.keystore /opt/shrine/shrine.keystore
