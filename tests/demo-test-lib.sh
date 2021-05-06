#!/bin/bash

function check_text_in_log {
    EXPECTED_TEXT=$1
    EXPECTED_COUNT=${2:-1}
    echo "Checking log for '${EXPECTED_TEXT}'"
    EXPECTED_TEXT_COUNT=$(grep "${EXPECTED_TEXT}" ${OUTPUT_LOG_FILE} | wc -l)
    if [ ${EXPECTED_TEXT_COUNT} -ne ${EXPECTED_COUNT} ]; then
        echo "Unexpected count of '${EXPECTED_TEXT}' has not been found in output log. Expected: ${EXPECTED_COUNT} was: ${EXPECTED_TEXT_COUNT}";
        exit 1
    fi
}