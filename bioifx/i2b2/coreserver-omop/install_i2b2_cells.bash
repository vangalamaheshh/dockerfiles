#!/bin/bash

WORKDIR="/opt/jboss/i2b2/i2b2-data/edu.harvard.i2b2.data/Release_1-7/NewInstall"

for i2b2_cell in Crcdata Hivedata Imdata Metadata Pmdata Workdata; do
  echo "INFO: Installing $i2b2_cell" >&2
  cd ${WORKDIR}/${i2b2_cell}
  lc_cell_name=$(echo $i2b2_cell | tr '[:upper:]' '[:lower:]')
  # create tables
  ant -f data_build.xml create_${lc_cell_name}_tables_release_1-7
  if [ ${lc_cell_name} == "crcdata" ]; then
    # stored procedures
    ant -f data_build.xml create_procedures_release_1-7
    # load tables
    ant -f data_build.xml db_demodata_load_data
  else
    if [ ${lc_cell_name} == "pmdata" ]; then
      # create triggers
      ant -f data_build.xml create_triggers_release_1-7
    fi
    # load tables
    ant -f data_build.xml db_${lc_cell_name}_load_data
  fi
done

# OMOP data installation
OMOP_DIR="/opt/jboss/i2b2/i2b2-omop-data/sqlserver"
cd ${OMOP_DIR}/CRCdata
ant -f data_build.xml create_crcdata_tables
ant -f data_build.xml create_procedures
ant -f data_build.xml db_load_crc_data
ant -f data_build.xml create_omop_views
cd ${OMOP_DIR}/Metadata
ant -f data_build.xml create_omop_metadata_tables
ant -f data_build.xml db_metadata_load_data_omop
cd ${OMOP_DIR}/Workdata
ant -f data_build.xml create_workdata_tables
ant -f data_build.xml db_workdata_load
