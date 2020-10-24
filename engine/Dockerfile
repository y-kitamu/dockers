FROM cpp_engine_base

MAINTAINER y-kitamu ymyk6602@gmail.com

# docker-compose.yml args
ARG user

# add user
RUN useradd -ms /bin/bash ${user}
RUN usermod -aG sudo ${user}

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
ARG LLVM_VERSION=10
RUN apt-get update && apt-get install -y lsb-release software-properties-common && apt-get clean all
WORKDIR /opt
RUN wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh && ./llvm.sh ${LLVM_VERSION}

RUN rm -f /usr/bin/clang && ln -s /usr/lib/llvm-${LLVM_VERSION}/bin/clang /usr/bin/clang &&\
    rm -f /usr/bin/clang++ && ln -s /usr/lib/llvm-${LLVM_VERSION}/bin/clang++ /usr/bin/clang++ &&\
    rm -f /usr/bin/lldb && ln -s /usr/bin/lldb-${LLVM_VERSION} /usr/bin/lldb &&\
    rm -f /usr/bin/llvm-config && ln -s /usr/bin/llvm-config-${LLVM_VERSION} /usr/bin/llvm-config

# halide
WORKDIR /opt
RUN git clone https://github.com/halide/Halide.git Halide &&\
    cd Halide && mkdir build && cd build &&\
    export LLVM_CONFIG=/usr/bin/llvm-config &&\
    make -f ../Makefile -j 4 &&\
    cp -r include /usr/local/include/halide &&\
    ln -s /opt/Halide/build/bin/libHalide.so /usr/local/lib/libHalide.so

# boost
RUN apt-get update && apt-get upgrade -y && apt-get install -y libboost-all-dev

# install c++ profiler tools (gperftools, valgrind, kcachegrind)
RUN apt-get install -y google-perftools libgoogle-perftools-dev valgrind kcachegrind

# install zenity
RUN apt-get update && apt-get install -y zenity

# Google Test
WORKDIR /opt
RUN git clone https://github.com/google/googletest.git &&\
    cd googletest && mkdir build && cd build &&\
    cmake ../ && make -j4 && make install

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

# emacs settings
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y autoconf texinfo libgnutls28-dev libxml2-dev libgtk-3-dev libtiff-dev libgif-dev libpng-dev libxpm-dev libncurses5-dev libjansson-dev \
	&& git clone --depth=1 git://git.sv.gnu.org/emacs.git /emacs \
	&& cd /emacs && ./autogen.sh \
	&& ./configure --with-modules --with-json \
	&& make -j4 && make install

# lsp server
# c++ (ccls)
WORKDIR /opt
RUN apt-get install -y libllvm-${LLVM_VERSION}-ocaml-dev llvm-${LLVM_VERSION}-doc llvm-${LLVM_VERSION}-examples
RUN apt-get install -y  clang-tools-${LLVM_VERSION} clang-${LLVM_VERSION}-doc \
    libclang-${LLVM_VERSION}-dev clang-format-${LLVM_VERSION} python3-clang-${LLVM_VERSION}
RUN git clone --depth=1 --recursive https://github.com/MaskRay/ccls && cd ccls &&\
    cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang++ &&\
    cmake --build Release && ln -s /opt/ccls/Release/ccls /usr/local/bin/
# python (python language server)
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python3
RUN pip3 install jedi 'python-language-server[all]'
# Cmake
RUN pip3 install cmake-language-server
# NPM installed language servers
RUN apt-get install -y npm \
	&& npm i -g \
	bash-language-server \
	vscode-css-languageserver-bin \
	vscode-html-languageserver-bin \
	dockerfile-language-server-nodejs \
	typescript-language-server \
	typescript

# emacs required libraries
RUN apt-get update \
    && apt-get update -y\
    && apt-get install silversearcher-ag cmigemo -y
# dap-mode
# RUN pip3 install "ptvsd>=4.2"

# utility
RUN apt-get update && apt-get upgrade -y &&\
    apt-get install -y locate gnuplot openjdk-11-jre

# TODO: move to Dockerfile.gpu
# libtorch
WORKDIR /opt
RUN apt-get update && apt-get upgrade -y && apt-get install -y unzip
RUN wget https://download.pytorch.org/libtorch/nightly/cu102/libtorch-cxx11-abi-shared-with-deps-latest.zip && unzip libtorch-cxx11-abi-shared-with-deps-latest.zip
RUN cp -r libtorch/include/* /usr/local/include/ &&\
    cp -r libtorch/lib/* /usr/local/lib/ &&\
    cp -r libtorch/share/* /usr/local/share/ &&\
    ldconfig

WORKDIR /opt
ADD libs /opt/libs
RUN cd libs &&\
    dpkg -i libcudnn8_8.0.2.39-1+cuda10.2_amd64.deb &&\
    dpkg -i libcudnn8-dev_8.0.2.39-1+cuda10.2_amd64.deb &&\
    dpkg -i libcudnn8-doc_8.0.2.39-1+cuda10.2_amd64.deb

# display
ARG display
RUN echo "export DISPLAY=${display}" >> /etc/profile
