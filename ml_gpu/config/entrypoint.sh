#!/bin/bash

set -eu

jupyter lab --ip='*' --port=8888 --no-browser --allow-root --NotebookApp.token='' --notebook-dir=/home/$1/work
