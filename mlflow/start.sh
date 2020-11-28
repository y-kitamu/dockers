#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

mkdir ~/.aws/
cp $AWS_CREDENTIALS ~/.aws/credentials

mlflow db upgrade $DB_URI

mlflow server \
    --backend-store-uri $DB_URI \
    --host 0.0.0.0 \
    --port 80 \
    --default-artifact-root s3://$AWS_S3_BUCKET
