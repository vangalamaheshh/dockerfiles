FROM mvangala/base-shrine:latest

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

COPY conf/i2b2_config_data.js /opt/shrine/tomcat/webapps/shrine-webclient/i2b2_config_data.js
COPY conf/cell_config_data.js /opt/shrine/tomcat/webapps/shrine-webclient/js-i2b2/cells/SHRINE/cell_config_data.js

COPY conf/steward.conf /opt/shrine/tomcat/lib/steward.conf
COPY conf/steward.xml /opt/shrine/tomcat/conf/Catalina/localhost/steward.xml
