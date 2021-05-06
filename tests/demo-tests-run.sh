#!/bin/bash
#include lib
.  demo-test-lib.sh
export DEMO_PATH=../road-traffic-predictor
export RT_RECOGNITION_PATH=realtime-image-recognition

export

export OUTPUT_LOG_FILE=log.txt

echo "Staring automated testing of jet demos"
echo "Packaging all demo projects"
cd ..
#mvn clean install package
echo "All artifacts have been successfully built"

echo "realtime-image-recognition: starting tests"
cd ${RT_RECOGNITION_PATH}/target
timeout 20s java -jar realtime-image-recognition-4.3-jar-with-dependencies.jar ../likevgg_cifar10 > ${OUTPUT_LOG_FILE}
echo "realtime-image-recognition: verifying messages in log"
check_text_in_log "execution graph in DOT format"
check_text_in_log "Building execution plan for job"
check_text_in_log "Executing job"
echo "realtime-image-recognition: log messages successfully verified"
cd ..

echo "markov-chain-generator: starting tests"
export MARKOV_CHAIN_PATH=../markov-chain-generator
cd ${MARKOV_CHAIN_PATH}
mvn exec:java --log-file ${OUTPUT_LOG_FILE}
echo "markov-chain-generator: verifying messages in log"
check_text_in_log "0.3333     | hanging "
check_text_in_log "Generating model..."
check_text_in_log "|  0.7864     | shall       |"
echo "markov-chain-generator: log messages successfully verified"
cd ..

echo "road-traffic-predictor: starting tests"
export TRAFFIC_PREDICTOR_PATH=road-traffic-predictor
cd ${TRAFFIC_PREDICTOR_PATH}
mvn clean install package
mvn exec:java --log-file ${OUTPUT_LOG_FILE}
echo "road-traffic-predictor: verifying messages in log"
check_text_in_log "Start executing job"
check_text_in_log "digraph DAG"
check_text_in_log "completed successfully"
echo "road-traffic-predictor: log messages successfully verified"
cd ..

echo "tensorflow: starting tests"
export TENSORFLOW_PATH=tensorflow
cd ${TENSORFLOW_PATH}
mvn compile exec:java -Dexec.mainClass=InProcessClassification -Dexec.args="data" > ${OUTPUT_LOG_FILE}
echo "tensorflow: verifying messages in log"
check_text_in_log "Start execution of job"
check_text_in_log "had both good and bad parts"
check_text_in_log "is 0.48"
echo "tensorflow: log messages successfully verified"
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