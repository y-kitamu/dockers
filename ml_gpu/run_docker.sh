#!/bin/bash

source_dir=$(cd $(dirname $0); pwd)
container_name="ml_gpu_jupyter_1"

if [ "`docker container ls -a | grep ${container_name}`" ]; then
    docker stop ${container_name}
    docker rm ${container_name}
fi

docker run -t -i -p 4000:8888 --name ${container_name} --gpus all \
       -v ${source_dir}/config:/home/`id -n -u`/config/ \
       -v ${source_dir}/config/.jupyter:/home/`id -n -u`/.jupyter \
       -v /home/`id -n -u`/work:/home/`id -n -u`/work \
       -v /home/`id -n -u`/.bashrc:/home/`id -n -u`/.bashrc \
       -v /etc/passwd:/etc/passwd \
       -v /etc/group:/etc/group \
       -e USER_ID=`id -u` -e GROUP_ID=`id -g` \
       -e USER=`id -n -u` -e GROUP=`id -n -g` \
       -e DISPLAY=${DISPLAY} \
       -d --restart=always ml_gpu_jupyter /home/`id -n -u`/config/entrypoint.sh
