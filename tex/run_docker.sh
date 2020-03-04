#!/bin/bash

CMDNAME=`basename $0`
export DOCKER_DIR=`dirname $0`

while getopts hs: OPT
do
    case $OPT in
        "s" ) FLG_S="TRUE" ; export SOURCE_FILE="${OPTARG}" ;;
         *  ) ;;
    esac
done

if [ "${FLG_S}" == "TRUE" ]; then
    export USER_NAME=`id -un`
    export GROUP_NAME=`id -gn`
    docker-compose -f ${DOCKER_DIR}/docker-compose.yml up
    unset SOURCE_FILE
    unset USER_NAME
    unset GROUP_NAME
else
    cat << EOF
Description:
     Run tex generating docker.
Usage:
    ./$0 -s <tex souce filename>
EOF
fi

unset DOCKER_DIR
