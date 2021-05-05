#!/bin/bash
#include lib
.  demos-test-lib.sh
export DEMO_PATH=../road-traffic-predictor

export OUTPUT_LOG_FILE=log.txt


###########################
### packaging the demo  ###
###########################
cd ${DEMO_PATH}
mvn clean install package

###########################
### execute code sample ###
###########################

mvn exec:java --log-file ${OUTPUT_LOG_FILE}

#################################
### verify code sample output ###
#################################
check_text_in_log "Start executing job"
check_text_in_log "digraph DAG"
check_text_in_log "completed successfully"