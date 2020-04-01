#!/bin/bash

set -eu

#tensorboard --logdir /home/`id -n -u`/logs

jupyter lab --ip='*' --port=8888 --no-browser --allow-root --NotebookApp.token='' --notebook-dir=/home/`id -n -u`/work
