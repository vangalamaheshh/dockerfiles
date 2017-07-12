#!/bin/bash

# Sleep for 5 min - the time it takes for the oracle to initiate database connections.

sleep 600

if [ -z ${ORACLE_PWD} ]; then
  echo "Env. Variable ORACLE_PWD is a required argument. Exiting ... !"
  exit 1
fi

sqlplus system/${ORACLE_PWD}@//localhost:1521/XE @ /usr/local/bin/sql/create_users.sql
