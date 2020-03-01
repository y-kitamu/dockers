FROM ubuntu:18.04

MAINTAINER y-kitamu ymyk6602@gmail.com

# docker-compose.yml args
ARG user
ARG display

# add user
RUN useradd -ms /bin/bash ${user}
RUN usermod -aG sudo ${user}

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
    apt-get install sudo gcc g++ build-essential git ninja-build openssl libssl-dev -y

WORKDIR /opt

# build cmake
RUN git clone https://github.com/Kitware/CMake.git cmake &&\
    cd cmake &&\
    ./bootstrap &&\
    make && make install

# python set up 
RUN apt-get install python3-distutils -y &&\
    rm -rf /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python &&\
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

# clang & llvm : https://apt.llvm.org
RUN apt-get update && apt-get install -y lsb-release software-properties-common && apt-get clean all
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)" &&\
    rm -f /usr/bin/clang && ln -s /usr/lib/llvm-9/bin/clang /usr/bin/clang &&\
    rm -f /usr/bin/clang++ && ln -s /usr/lib/llvm-9/bin/clang++ /usr/bin/clang++

# halide
WORKDIR /opt
RUN git clone https://github.com/halide/Halide.git Halide &&\
    cd Halide && mkdir build && cd build &&\
    export LLVM_CONFIG=/usr/bin/llvm-config-9 &&\
    make -f ../Makefile -j 4 &&\
    cp -r include /usr/local/include/halide &&\
    ln -s /opt/Halide/build/bin/libHalide.so /usr/local/lib/libHalide.so

# boost
RUN apt-get install -y libboost-all-dev

# install c++ profiler tools (gperftools, valgrind, kcachegrind)
RUN apt-get install -y google-perftools libgoogle-perftools-dev valgrind kcachegrind

# install zenity
RUN apt-get update && apt-get install -y zenity

# global(GTAGS), Pygments
RUN apt-get install ctags python-pygments libncurses-dev -y
WORKDIR /opt
RUN wget http://tamacom.com/global/global-6.6.3.tar.gz &&\
    tar -zxvf global-6.6.3.tar.gz &&\
    cd global-6.6.3 &&\
    ./configure &&\
    make &&\
    make install &&\
    cp /usr/local/share/gtags/gtags.conf /etc/
# RUN pip install Pygments

# emacs
# WORKDIR /opt
# RUN apt-get update && apt-get upgrade -y &&\
#     apt-get install -y\
#     libgtk-3-dev libtiff-dev libgif-dev libpng-dev libxpm-dev libncurses5-dev libgnutls28-dev
# RUN wget http://ftp.jaist.ac.jp/pub/GNU/emacs/emacs-26.3.tar.gz && tar -xzvf emacs-26.3.tar.gz &&\
#     cd emacs-26.3 && ./configure && make && make install
RUN add-apt-repository ppa:kelleyk/emacs
RUN apt-get update && apt-get install emacs26 -y
RUN apt-get update && apt-get install locate -y
