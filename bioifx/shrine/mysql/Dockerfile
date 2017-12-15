FROM mysql:5.5

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

COPY demo-data /demo-data

RUN set -ex \
  && touch /prepare_db.sql \
  && echo "create database shrine_query_history;" >>/prepare_db.sql \
  && echo "use shrine_query_history;" >>/prepare_db.sql \
  && cat /demo-data/query_history.sql >>/prepare_db.sql \
  && cat /demo-data/create_broadcaster_audit_table.sql >>/prepare_db.sql \
  && echo "create database stewardDB;" >>/prepare_db.sql \
  && echo "use stewardDB;" >>/prepare_db.sql \
  && cat /demo-data/steward_db.sql >>/prepare_db.sql \
  && echo "create database qepAuditDB;" >>/prepare_db.sql \
  && echo "use qepAuditDB;" >>/prepare_db.sql \
  && cat /demo-data/qep.sql >>/prepare_db.sql \
  && echo "create database adapterAuditDB;" >>/prepare_db.sql \
  && echo "use adapterAuditDB;" >>/prepare_db.sql \
  && cat /demo-data/adapter.sql >>/prepare_db.sql

EXPOSE 3306

CMD ["mysqld"]
