FROM ubuntu:16.04 

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

#------------------------------#
#                              #
#     INSTALL JAVA 8.0         #
#                              #
#------------------------------#
RUN set -ex \
  && apt-get update -y \
  && apt-get install -y curl \
  && apt-get install -y software-properties-common \
  && add-apt-repository ppa:webupd8team/java \
  && apt-get update -y \
  && echo yes | apt-get install -y oracle-java8-installer

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

CMD ["/usr/local/bin/wildfly/wildfly-10.0.0.Final/bin/standalone.sh", "-b", "0.0.0.0"]
	
