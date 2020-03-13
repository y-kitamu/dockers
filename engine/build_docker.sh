#!/bin/bash
docker build -t cpp_engine\
       --build-arg user=${USER}\
       --build-arg display=${DISPLAY} .
