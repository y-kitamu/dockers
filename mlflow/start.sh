#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [ ! -e ${HOME}/.aws ]; then
    mkdir ${HOME}/.aws/
fi
cp $AWS_CREDENTIALS ${HOME}/.aws/credentials

mlflow db upgrade $DB_URI

mlflow server \
    --backend-store-uri $DB_URI \
    --host 0.0.0.0 \
    --port 80 \
    --default-artifact-root s3://$AWS_S3_BUCKET
