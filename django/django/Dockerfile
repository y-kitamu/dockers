FROM python:3.7

ARG USER

RUN apt-get update && apt-get upgrade -y
RUN apt-get install sudo -y

RUN useradd -m ${USER}
RUN usermod -aG sudo ${USER}

ARG APP_PATH

COPY requirements.base.txt ${APP_PATH}/
RUN pip install --no-cache-dir -r ${APP_PATH}/requirements.base.txt

WORKDIR ${APP_PATH}
# USER ${USER}
