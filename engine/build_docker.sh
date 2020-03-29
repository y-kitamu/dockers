#!/bin/bash
has_gpu=`lspci | grep -i nvidia`

if [ -n "${has_gpu}" ]; then
    docker build -t cpp_engine_base -f ./Dockerfile.gpu .
else
    docker build -t cpp_engine_base -f ./Dockerfile.no_gpu .
fi

docker build -t cpp_engine -f ./Dockerfile\
    --build-arg user=${USER}\
    --build-arg display=${DISPLAY} .
