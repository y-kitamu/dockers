#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
CUR_DIR=$(pwd)

USER_ID=$(id -u)
GROUP_ID=$(id -g)
USER=$(id -u ${USER_ID} -n)
DISP=${DISPLAY}

echo "USER_ID = ${USER_ID}, GROUP_ID = ${GROUP_ID}, USER = ${USER}, DISP = ${DISP}"

cd ${SCRIPT_DIR}
docker-compose build \
               --build-arg uid=${USER_ID} --build-arg gid=${GROUP_ID} --build-arg user=${USER} \
               --build-arg display=${DISP}
cd ${CUR_DIR}
