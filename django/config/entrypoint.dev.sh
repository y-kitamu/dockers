#!/bin/bash
if [ ! -d ./${DJANGO_PROJECT_NAME} ]; then
    sudo -u ${DJANGO_USER} -s /bin/bash -c "django-admin startproject ${DJANGO_PROJECT_NAME} . && cp /home/${DJANGO_USER}/config/settings.py ./${DJANGO_PROJECT_NAME}/"
fi

python manage.py runserver 0:${DJANGO_PORT}
