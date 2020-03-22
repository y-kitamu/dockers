#!/bin/bash
has_gpu=`lspci | grep -i nvidia`

if [ -n "${has_gpu}" ]; then
    docker build -t cpp_engine -f ./Dockerfile\
           --build-arg user=${USER}\
           --build-arg display=${DISPLAY} .
else
    docker build -t cpp_engine -f ./Dockerfile.no_gpu \
           --build-arg user=${USER}\
           --build-arg display=${DISPLAY} .
fi
