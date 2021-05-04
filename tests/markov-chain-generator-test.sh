#!/bin/bash
#include lib
.  demos-test-lib.sh
export DEMO_PATH=../markov-chain-generator

export OUTPUT_LOG_FILE=1log.txt


###########################
### packaging the demo  ###
###########################
cd ${DEMO_PATH}
#mvn clean install package

###########################
### execute code sample ###
###########################

mvn exec:java --log-file ${OUTPUT_LOG_FILE}

#################################
### verify code sample output ###
#################################
check_text_in_log "0.3333     | hanging "
check_text_in_log "Generating model..."
check_text_in_log "|  0.7864     | shall       |"