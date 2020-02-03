#!/bin/bash
docker build -t ml_gpu_jupyter \
       --build-arg user=${USER} .
