#!/bin/sh
echo "start generate pdf from ${SOURCE_FILE}"

latexmk -C ${SOURCE_FILE} && latexmk ${SOURCE_FILE} && latexmk -c ${SOURCE_FILE}

chown ${USER_NAME}:${GROUP_NAME} ${SOURCE_FILE%.*}*
