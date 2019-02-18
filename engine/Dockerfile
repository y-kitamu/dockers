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

# emacs
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:kelleyk/emacs && apt-get update && apt-get install emacs26 -y
RUN mkdir /home/${user}/backups

# utility
RUN apt-get install sudo locate git screen ngetty -y

# display
ARG display
RUN echo "export DISPLAY=${display}" >> /etc/profile

# add user
ARG user
ARG passwd

RUN useradd -ms /bin/bash ${user}
RUN usermod -aG sudo ${user}
RUN echo "${user}:${passwd}" | chpasswd

RUN apt-get install -y libx11-dev libxi-dev libgl1-mesa-dev libglu1-mesa-dev libxrandr-dev libxext-dev
# OpenGL

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y --no-install-recommends \
        libxau6 libxau6:i386 \
        libxdmcp6 libxdmcp6:i386 \
        libxcb1 libxcb1:i386 \
        libxext6 libxext6:i386 \
        libx11-6 libx11-6:i386 && \
    rm -rf /var/lib/apt/lists/*

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
        ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
        ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics,compat32,utility

# Required for non-glvnd setups.
ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# display
ARG display
RUN echo "export DISPLAY=${display}" >> /etc/profile

