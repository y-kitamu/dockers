FROM tensorflow/tensorflow:latest-devel-gpu

MAINTAINER Y.Kitamu <ymyk6602@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

# add user
ARG user
RUN useradd -ms /bin/bash ${user}
RUN usermod -aG sudo ${user}

# apt
RUN apt-get update && apt-get upgrade -y &&\
    apt-get install git curl gcc libssl1.0-dev nodejs-dev npm node-gyp sudo cmake build-essential openssh-server -y
# npm
RUN npm install n -g && n stable
RUN apt purge -y nodejs npm

# ssh (https://docs.docker.com/engine/examples/running_ssh_service/)
RUN mkdir /var/run/sshd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# python
USER root
RUN apt-get update && apt-get install -y python3.8-dev && python3.8 -m pip install --upgrade pip
RUN apt autoremove -y
# jupyter lab
RUN pip install jupyterlab

# lsp
RUN mkdir /home/${user}/opt
WORKDIR /home/${user}/opt
RUN git clone https://github.com/rust-analyzer/rust-analyzer.git &&\
    cd /home/${user}/opt/rust-analyzer && \
    rustup update && cargo xtask install --server
# jupyter lab lsp, pylsp
RUN pip install jupyterlab-lsp 'python-lsp-server[all]'

# rust
USER ${user}
SHELL ["/bin/bash", "-c"]
RUN cd /home/${user} &&\
    curl https://sh.rustup.rs -sSf > ./rust.sh &&\
    chmod +x ./rust.sh &&\
    ./rust.sh -y &&\
    rm -rf ./rust.sh &&\
    chmod +x /home/${user}/.cargo/env &&\
    source /home/${user}/.cargo/env &&\
    rustup update
ENV PATH /home/${user}/.cargo/bin:$PATH

# install newest cmake
ARG CMAKE_VER=3.22.0
WORKDIR /opt/
RUN wget https://github.com/Kitware/CMake/releases/download/v$CMAKE_VER-rc2/cmake-$CMAKE_VER-rc2.tar.gz\
    && tar -zxvf cmake-$CMAKE_VER-rc2.tar.gz\
    && rm cmake-$CMAKE_VER-rc2.tar.gz\
    && cd cmake-$CMAKE_VER-rc2\
    && cmake . \
    && make -j8\
    && make install

# rust jupyter
USER ${user}
RUN rustup component add rust-src
RUN cargo install evcxr_jupyter
RUN evcxr_jupyter --install

# jupyter lab extension
USER root
# jupyterlab-emacskeys
WORKDIR /home/${user}/opt
RUN git clone https://github.com/kpe/jupyterlab-emacskeys.git &&\
    cd jupyterlab-emacskeys &&\
    npm install &&\
    npm run build &&\
    jupyter labextension link .

USER root

RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf
