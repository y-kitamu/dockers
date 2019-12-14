#!/bin/bash

CMDNAME=`basename $0`
export DOCKER_DIR=`dirname $0`

while getopts hn: OPT
do
    case $OPT in
        "n" ) FLG_N="TRUE" ; export SOURCE_FILE="${OPTARG}" ;;
         *  ) ;;
    esac
done

if [ "${FLG_N}" == "TRUE" ]; then
    export USER_NAME=`id -un`
    export GROUP_NAME=`id -gn`
    docker-compose up
    unset SOURCE_FILE
    unset USER_NAME
    unset GROUP_NAME
else
    cat << EOF
Description:
     Run tex generating docker.
Usage:
    ./$0 -n <tex souce filename>
EOF
fi

unset DOCKER_DIR
