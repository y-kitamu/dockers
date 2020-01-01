FROM python:3.7

ARG USER
ARG PASSWD
ARG USER_ID
ARG GROUP_ID

RUN apt-get update && apt-get upgrade -y
RUN apt-get install sudo -y

RUN useradd -ms /bin/bash -u ${USER_ID} ${USER}
RUN groupmod -g ${GROUP_ID} ${USER}
RUN usermod -aG sudo ${USER}
RUN echo "${USER}:${PASSWD}" | chpasswd

ARG APP_PATH

COPY requirements.base.txt ${APP_PATH}/
RUN pip install --no-cache-dir -r ${APP_PATH}/requirements.base.txt

WORKDIR ${APP_PATH}
# USER ${USER}

