FROM ubuntu:latest

MAINTAINER Y.Kitamu <ymyk6602@gmail.com>

# add user
ARG user
RUN useradd -ms /bin/bash ${user}
RUN usermod -aG sudo ${user}

# ssh (https://docs.docker.com/engine/examples/running_ssh_service/)
RUN apt-get update && apt-get upgrade -y && apt-get install openssh-server -y
RUN mkdir /var/run/sshd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config


RUN apt-get update && apt-get upgrade -y && apt-get install git curl gcc -y

USER ${user}
SHELL ["/bin/bash", "-c"]
RUN cd /home/${user} &&\
    curl https://sh.rustup.rs -sSf > ./rust.sh &&\
    chmod +x ./rust.sh &&\
    ./rust.sh -y &&\
    rm -rf ./rust.sh &&\
    chmod +x /home/${user}/.cargo/env && source /home/${user}/.cargo/env \
    rustup update
ENV PATH /home/${user}/.cargo/bin:$PATH

# lsp
RUN mkdir /home/${user}/opt
WORKDIR /home/${user}/opt
RUN git clone https://github.com/rust-analyzer/rust-analyzer.git &&\
    cd /home/${user}/opt/rust-analyzer && \
    rustup update && cargo xtask install --server

USER root
