#!/bin/bash

CUR_DIR=$(pwd)
cd $(dirname $0)

docker build -f Dockerfile.python --tag python_lsp ./

cd ${CUR_DIR}
