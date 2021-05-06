#!/bin/bash
#include lib
.  demo-test-lib.sh
export OUTPUT_LOG_FILE=h2o_log.txt
cd ..

echo "h2o-breast-cancer-classification: starting tests"
export H2O_CANCER_PATH=h2o-breast-cancer-classification
cd ${H2O_CANCER_PATH}
mvn exec:java --log-file ${OUTPUT_LOG_FILE}
echo "h2o-breast-cancer-classification: verifying messages in log"
check_text_in_log "Start execution of job"
check_text_in_log "Read from CSV input file" 2
check_text_in_log "BENIGN              0.9997749358618557"
echo "h2o-breast-cancer-classification: log messages successfully verified"
cd ..