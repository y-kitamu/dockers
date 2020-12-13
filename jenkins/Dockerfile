FROM jenkins/jenkins:lts

ENV DEBIAN_FRONTEND noninteractive

USER root

RUN apt-get update -y \
    && apt-get -y install sshpass \
    && curl -fL -o docker.tgz "https://download.docker.com/linux/static/test/x86_64/docker-20.10.0-rc2.tgz" \
    && tar --strip-components=1 -xvzf docker.tgz -C /usr/bin \
    && rm docker.tgz

ARG DOCKER_GROUP_ID
RUN groupadd -g ${DOCKER_GROUP_ID} docker \
    && gpasswd -a jenkins docker

USER jenkins
