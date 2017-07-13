#!/bin/bash

${JBOSS_HOME}/bin/standalone.sh -b 0.0.0.0 &
bash /opt/jboss/i2b2/install_i2b2_cells.bash &

wait
