#!/bin/bash
if [ ! -d ./${DJANGO_PROJECT_NAME} ]; then
    sudo -u ${DJANGO_USER} -s /bin/bash -c "django-admin startproject ${DJANGO_PROJECT_NAME} . && cp /home/${DJANGO_USER}/config/settings.py ./${DJANGO_PROJECT_NAME}/"
fi

python manage.py collectstatic --noinput && python manage.py migrate && gunicorn ${DJANGO_PROJECT_NAME}.wsgi -b 0.0.0.0:${DJANGO_PORT}
