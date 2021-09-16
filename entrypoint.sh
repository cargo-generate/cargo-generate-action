#!/bin/bash

if [ -z "${INPUT_TEMPLATE}" ]; then
    TEMPLATE="."
else
    TEMPLATE=${INPUT_TEMPLATE}
fi

if [ -z "${INPUT_BRANCH}" ]; then
    BRANCH=""
else
    BRANCH="--branch ${INPUT_BRANCH}"
fi

if [ -z "${INPUT_TEMPLATE_VALUES_FILE}" ]; then
    TEMPLATE_VALUES_FILE=""
else
    TEMPLATE_VALUES_FILE="--template-values-file ${INPUT_TEMPLATE_VALUES_FILE}"
fi

# USER variable MUST be set
if [ -z "${USER}" ]; then
    export USER="root"
fi

set -o xtrace
cargo-generate generate\
    --silent\
    ${BRANCH}\
    ${SUBFOLDER}\
    ${TEMPLATE_VALUES_FILE}\
    ${INPUT_OTHER[@]}\
    --git ${TEMPLATE}\
    --name ${INPUT_NAME}\
    ${INPUT_SUBFOLDER}
