FROM mvangala/oracle-xe:11.2

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN set -ex \
  && mkdir -p /usr/local/bin/sql

WORKDIR /usr/local/bin/sql
 
COPY create_users.sql /usr/local/bin/sql/create_users.sql

COPY run_sql.bash /usr/local/bin/sql/run_sql.bash

EXPOSE 1521
EXPOSE 8080

CMD ["/bin/bash", "/usr/local/bin/sql/run_sql.bash"]

