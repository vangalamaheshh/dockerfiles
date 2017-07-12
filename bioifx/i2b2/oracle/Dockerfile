FROM mvangala/oracle-xe:11.2

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN set -ex \
  && mkdir -p /usr/local/bin/sql

WORKDIR /usr/local/bin/sql
 
COPY create_users.sql /usr/local/bin/sql/create_users.sql

RUN set -ex \
  && sqlplus system/${ORACLE_PWD}@//localhost:1521/XE @ create_users.sql

