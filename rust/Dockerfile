FROM rust

# add user
ARG user
RUN useradd -ms /bin/bash ${user}
RUN usermod -aG sudo ${user}

# ssh (https://docs.docker.com/engine/examples/running_ssh_service/)
RUN apt-get update && apt-get upgrade -y && apt-get install openssh-server -y
RUN mkdir /var/run/sshd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN apt-get update && apt-get upgrade -y && apt-get install git

USER ${user}
RUN cd /home/${user} &&\
    git clone https://github.com/y-kitamu/dotfiles.git &&\
    /home/${user}/dotfiles/install.sh

USER root
