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
ENV CRAN_MIRROR "http://cran.mirrors.hoobly.com"
COPY config/vars.sample /usr/local/bin/transmart/transmart-data/vars
COPY config/other_pkg.R /usr/local/bin/transmart/transmart-data/R/other_pkg.R
RUN /bin/bash -c 'source /usr/local/bin/transmart/transmart-data/vars \
  && sed -i "s|http.*|${CRAN_MIRROR}|g" /usr/local/bin/transmart/transmart-data/R/Makefile \
  && make -C /usr/local/bin/transmart/transmart-data/R install_packages \
  && echo "export PATH=/usr/local/bin/transmart/transmart-data/R/root/bin:$PATH" >/etc/profile.d/Rpath.sh \
  && source /etc/profile.d/Rpath.sh'

#-- INSTALL CONFIG
RUN /bin/bash -c 'source /usr/local/bin/transmart/transmart-data/vars \ 
  && make -C /usr/local/bin/transmart/transmart-data/config install \
  && mkdir -p /usr/share/tomcat7/.grails/transmartConfig/ \
  && cp ${HOME}/.grails/transmartConfig/*.groovy /usr/share/tomcat7/.grails/transmartConfig/'

#-- WAR FILES
RUN set -ex \
  && curl http://library.transmartfoundation.org/release/release16_2_0_artifacts/transmart.war --output /var/lib/tomcat7/webapps/transmart.war \
  && curl http://library.transmartfoundation.org/release/release16_2_0_artifacts/gwava.war --output /var/lib/tomcat7/webapps/gwava.war

#-----------------------------------------------#
#           TOMCAT BUG WORKAROUND               #
#-----------------------------------------------#
RUN set -ex \
  && sed -i "s|-Xmx128m|-Xms512m -Xmx2g|g" /etc/default/tomcat7

# Run SOLR
# Run database load
RUN echo "FForce load"
ENV JAVA_OPTS "-Duser.timezone=UTC"
ENV PATH $PATH:/root/.sdkman/candidates/groovy/current/bin:/root/.sdkman/candidates/grails/current/bin
COPY config/cmd.bash /usr/local/bin/cmd.bash
RUN set -ex \
  && chmod 775 /usr/local/bin/cmd.bash
EXPOSE 8080
CMD ["/bin/bash", "-c", "/usr/local/bin/cmd.bash"]
