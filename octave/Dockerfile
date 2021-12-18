FROM gnuoctave/octave:6.4.0

ENV DEBIAN_FRONTEND=noninteractive

USER root
# add user
ARG user
ARG uid
ARG gid
RUN groupadd --gid ${gid} ${user} && useradd -m --uid ${uid} --gid ${gid} ${user}

# ssh (https://docs.docker.com/engine/examples/running_ssh_service/)
RUN apt-get update && apt-get upgrade -y && apt-get install openssh-server -y
RUN mkdir /var/run/sshd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

WORKDIR /
