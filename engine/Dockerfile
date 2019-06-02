FROM ubuntu:18.04

MAINTAINER y-kitamu ymyk6602@gmail.com

# docker-compose.yml args
ARG user
ARG passwd
ARG display

# add user
RUN useradd -ms /bin/bash ${user}
RUN usermod -aG sudo ${user}
RUN echo "${user}:${passwd}" | chpasswd

# display
RUN echo "export DISPLAY=${display}" >> /etc/profile

# ssh (https://docs.docker.com/engine/examples/running_ssh_service/)
RUN apt-get update && apt-get upgrade -y && apt-get install openssh-server -y
RUN mkdir /var/run/sshd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# gcc, g++, build-essential, git
RUN apt-get update &&\
    apt-get upgrade -y &&\
    apt-get install sudo gcc g++ build-essential git clang ninja-build -y

WORKDIR /opt

# build cmake
RUN git clone https://github.com/Kitware/CMake.git cmake &&\
    cd cmake &&\
    ./bootstrap &&\
    make && make install

# python set up 
RUN apt-get install python3-distutils -y &&\
    rm /usr/bin/python && ln -s /usr/bin/python3.6 /usr/bin/python &&\
    apt-get update && apt-get install curl -y &&\
    curl -kL https://bootstrap.pypa.io/get-pip.py | python 

# build opencv
RUN apt-get update &&\
    apt-get install libgtk-3-0 libgtk-3-dev libavcodec-dev libavformat-dev libswscale-dev -y &&\
    git clone https://github.com/opencv/opencv.git opencv && cd opencv &&\
    mkdir build && cd build &&\
    cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local .. &&\
    make -j4 && make install

# ceres
RUN apt-get install \
    libgoogle-glog-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev -y &&\
    git clone https://github.com/ceres-solver/ceres-solver.git &&\
    mkdir ceres-bin && cd ceres-bin &&\
    cmake ../ceres-solver && make -j3 && make install

WORKDIR /

# opengl 
RUN apt-get install libglu1-mesa-dev mesa-common-dev mesa-utils freeglut3-dev libglfw3-dev libglfw3 -y
