#!/bin/bash

source_dir=$(cd $(dirname $0); pwd)
container_name="ml_gpu_jupyter_1"
user=`id -n -u`

if [ "`docker container ls -a | grep ${container_name}`" ]; then
    docker stop ${container_name}
    docker rm ${container_name}
fi

docker run -t -i -p 4000:8888 -p 6006:6006 -p 6007:6007 --name ${container_name} --gpus all \
       -v ${source_dir}/config:/home/${user}/config/ \
       -v ${source_dir}/config/.jupyter:/home/${user}/.jupyter \
       -v /home/${user}/work:/home/${user}/work \
       -v /home/${user}/dataset:/home/${user}/dataset \
       -v /home/${user}/.bashrc:/home/${user}/.bashrc \
       -v /etc/passwd:/etc/passwd \
       -v /etc/shadow:/etc/shadow \
       -v /etc/group:/etc/group \
       -e DISPLAY=${DISPLAY} \
       -d --restart=always ml_gpu_jupyter /home/${user}/config/entrypoint.sh
