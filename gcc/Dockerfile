FROM ubuntu:18.04

MAINTAINER y-kitamu ymyk6602@gmail.com

# c++
RUN apt-get update && apt-get install build-essential gcc libboost-dev -y
RUN apt-get install cmake ninja-build -y

# ssh (https://docs.docker.com/engine/examples/running_ssh_service/)
RUN apt-get update && apt-get install openssh-server -y
RUN mkdir /var/run/sshd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# add user
ARG user
ARG passwd

RUN useradd -ms /bin/bash ${user}
RUN usermod -aG sudo ${user}
RUN echo "${user}:${passwd}" | chpasswd

# utility
RUN apt-get install software-properties-common locate git -y

# emacs
RUN add-apt-repository ppa:kelleyk/emacs && apt-get update && apt-get install emacs26 -y

# display
RUN echo test
ARG display
RUN echo "export DISPLAY=${display}" >> /etc/profile
RUN echo ${display}
