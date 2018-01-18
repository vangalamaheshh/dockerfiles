#!/bin/bash

# start solr
cd /usr/local/bin/transmart/transmart-data
source vars && make -C /usr/local/bin/transmart/transmart-data/solr start >& /usr/local/bin/solr.log &

# data loading into oracle
cd /usr/local/bin/transmart/transmart-data
source vars && make -j4 oracle

wait
