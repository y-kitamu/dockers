FROM ubuntu:18.04

MAINTAINER y-kitamu ymyk6602@gmail.com

# c++
RUN apt-get update && apt-get install build-essential -y
RUN apt-get update && apt-get install gcc libboost-dev cmake ninja-build -y

# ssh (https://docs.docker.com/engine/examples/running_ssh_service/)
RUN apt-get update && apt-get install openssh-server -y
RUN mkdir /var/run/sshd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# emacs
RUN apt-get install software-properties-common -y
# RUN add-apt-repository ppa:kelleyk/emacs && apt-get update && apt-get install emacs26 -y
RUN mkdir /home/${user}/backups

# utility
RUN apt-get update && apt-get install sudo locate git screen -y

# display
ARG display
RUN echo "export DISPLAY=${display}" >> /etc/profile

# add user
ARG user
ARG passwd

RUN useradd -ms /bin/bash ${user}
RUN usermod -aG sudo ${user}
RUN echo "${user}:${passwd}" | chpasswd

# opengl
# うまく行かない??
RUN apt-get install -y mesa-utils libx11-dev libxi-dev libgl1-mesa-dev libglu1-mesa-dev libxrandr-dev libxext-dev libxinerama-dev libxcursor-dev libvulkan-dev

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},display

# install GLX-Gears
RUN apt update && apt install -y --no-install-recommends mesa-utils x11-apps && rm -rf /var/lib/apt/lists/*


RUN apt-get update && apt-get install -y build-essential cmake git wget unzip yasm pkg-config libswscale-dev \
    libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libavformat-dev libpq-dev && rm -rf /var/lib/apt/lists/*

# python3
RUN apt-get update && apt-get install -y python3-pip python3-dev && cd /usr/local/bin && ln -s /usr/bin/python3 python \
    && pip3 install --upgrade pip

RUN pip install numpy

WORKDIR /
ENV OPENCV_VERSION="4.0.1"
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip && unzip ${OPENCV_VERSION}.zip \
    && mkdir /opencv-${OPENCV_VERSION}/cmake_binary  && cd /opencv-${OPENCV_VERSION}/cmake_binary \
    && cmake -DBUILD_TIFF=ON \
    -DBUILD_opencv_java=OFF \
    -DWITH_CUDA=OFF \
    -DWITH_OPENGL=ON \
    -DWITH_OPENCL=ON \
    -DWITH_IPP=ON \
    -DWITH_TBB=ON \
    -DWITH_EIGEN=ON \
    -DWITH_V4L=ON \
    -DBUILD_TESTS=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DCMAKE_INSTALL_PREFIX=$(python -c "import sys; print(sys.prefix)") \
    -DPYTHON_EXECUTABLE=$(which python) \
    -DPYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
    -DPYTHON_PACKAGES_PATH=$(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
    .. \
    && make install && rm /${OPENCV_VERSION}.zip && rm -r /opencv-${OPENCV_VERSION}

# RUN ln -s /usr/local/python/cv2/python-3.7/cv2.cpython-37m-x86_64-linux-gnu.so /usr/local/lib/python3.7/site-packages/cv2.so

