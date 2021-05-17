FROM python:3.9.5

ENV DEBIAN_FRONTEND=noninteractive

ARG user
RUN useradd -m ${user} &&\
    usermod -aG sudo ${user}

# ssh (https://docs.docker.com/engine/examples/running_ssh_service/)
RUN apt-get update && apt-get upgrade -y && apt-get install openssh-server -y
RUN mkdir /var/run/sshd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN apt-get update && apt-get upgrade -y &&\
    apt-get install sudo git nodejs npm libsm6 libxext6 libxrender-dev libgl1-mesa-dev -y

RUN npm install n -g && n stable
RUN apt purge -y nodejs npm

RUN python3 -m pip install --upgrade pip
RUN pip install jupyterlab
RUN pip install cookiecutter

# name resolve for jplm
RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf
