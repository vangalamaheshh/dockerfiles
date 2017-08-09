#!/bin/bash

/bin/bash /opt/jboss/i2b2/install_i2b2_cells.bash
cd /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.server-common
ant clean dist deploy jboss_pre_deployment_setup
cd /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.pm
ant -f master_build.xml clean build-all deploy
cd /opt/jboss/i2b2/i2b2-core-server/edu.harvard.i2b2.ontology
ant -f master_build.xml clean build-all deploy
${JBOSS_HOME}/bin/standalone.sh -b 0.0.0.0

wait
