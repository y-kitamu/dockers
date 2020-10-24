#!/bin/bash

# TODO : (future) docker-compose で書きなおす (現状だと --gpus がdocker-compose 未対応)

source_dir=$(cd $(dirname $0); pwd)
image_name="cpp_engine"
container_name="cpp_engine"
hostname="cpp-engine"
user=`id -n -u`

container_id=`docker ps -a --filter name=${container_name} --format "{{.ID}}"`
if [ -n "${container_id}" ]; then
    docker stop ${container_id}
    docker rm ${container_id}
    unset container_id
fi

has_gpu=`lspci | grep -i nvidia`

OPTS=""
if [ -n "${has_gpu}" ]; then
    OPTS="${OPTS} --gpus all"
fi

docker run -t -i --cap-add SYS_PTRACE --security-opt "seccomp=unconfined" \
       -p 33330:22 --name ${container_name} --hostname ${hostname} ${OPTS} \
       -v /tmp/.X11-unix:/tmp/.X11-unix  \
       -v /etc/localtime:/etc/localtime  \
       -v /etc/passwd:/etc/passwd \
       -v /etc/shadow:/etc/shadow \
       -v /etc/group:/etc/group \
       -v ~/work:/home/${USER}/work \
       -v ~/dataset:/home/${USER}/dataset \
       -v ~/AndroidStudioProjects:/home/${USER}/AndroidStudioProjects \
       -v ~/Android:/home/${USER}/Android \
       -v ~/dotfiles:/home/${USER}/dotfiles \
       -v ${source_dir}/config:/home/${USER}/config \
       -v ~/.gitconfig:/home/${USER}/.gitconfig\
       -e DISPLAY=${DISPLAY} \
       -e USER_NAME=${USER} \
       -d --restart=always ${container_name} /home/${user}/config/entrypoint.sh
