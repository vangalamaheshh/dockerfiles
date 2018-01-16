FROM ubuntu:14.04

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

#----------------------------------------------#
#                                              #
#   Working directory set to /usr/local/bin    #
#                                              #
#----------------------------------------------#
WORKDIR /usr/local/bin

#----------------------------------------------#
#                                              #
#        INSTALL SYSTEM DEPENDENCIES           #
#                                              #
#----------------------------------------------#
RUN set -ex \
  && apt-get -y update \
  && apt-get install -y make curl ant maven vim tomcat7

#----------------------------------------------#
#                                              #
#      INSTALL TRANSMART DEPENDENCIES          #
#                                              #
#----------------------------------------------#
#-- SETUP
RUN set -ex \
  && mkdir /usr/local/bin/transmart \
  && cd /usr/local/bin/transmart \
  && curl http://library.transmartfoundation.org/release/release16_2_0_artifacts/transmart-data-release-16.2.zip -o transmart-data-release-16.2.zip \
  && unzip transmart-data-release-16.2.zip \
  && mv transmart-data-release-16.2 transmart-data \
  && cd transmart-data \
  && make -C env ubuntu_deps_root \
  && make -C env ubuntu_deps_regular \
  && rm env/groovy

#-- INSTALL GRAILS & GROOVY
RUN /bin/bash -c 'curl -s "https://get.sdkman.io" | bash \
  && source "/root/.sdkman/bin/sdkman-init.sh" \
  && sdk install grails 2.3.11 \
  && sdk install groovy 2.4.5'

#-- INSTALL R-3.2.1
RUN /bin/bash -c 'mkdir -p /usr/local/bin/R \
  && cd /usr/local/bin/R \
  && curl -O https://cran.r-project.org/src/base/R-3/R-3.2.1.tar.gz R-3.2.1.tar.gz \
  && tar -zxvf R-3.2.1.tar.gz \
  && cd R-3.2.1 \
  && ./configure --prefix=/usr/local/bin/R \
  && make \
  && make install'

ENV PATH $PATH:/usr/local/bin/R/bin
ENV CRAN_MIRROR "http://cran.mirrors.hoobly.com"

#-- INSTALL R Packages
RUN set -ex \
  && Rscript /usr/local/bin/transmart/transmart-data/R/cran_pkg.R

#-----------------------------------------------#
#           TOMCAT BUG WORKAROUND               #
#-----------------------------------------------#
RUN set -ex \
  && sed -i "s/-Xmx128m/-Xms512m -Xmx2g/g" /etc/default/tomcat7


