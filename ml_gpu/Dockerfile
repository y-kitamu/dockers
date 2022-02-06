FROM tensorflow/tensorflow:latest-gpu

ENV DEBIAN_FRONTEND=noninteractive

# add user
ARG user
RUN useradd -m ${user} &&\
    usermod -aG sudo ${user}

# ssh (https://docs.docker.com/engine/examples/running_ssh_service/)
RUN apt-get update && apt-get upgrade -y && apt-get install openssh-server -y
RUN mkdir /var/run/sshd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN apt-get update && apt-get upgrade -y &&\
    apt-get install sudo git nodejs npm libsm6 libxext6 libxrender-dev libgl1-mesa-dev -y

# install latest node
RUN npm install n -g && n stable && apt purge -y nodejs npm

# jupyter lab
RUN python3 -m pip install --upgrade pip
RUN pip3 install\
    jupyterlab\
    jupyter-tensorboard\
    jupyter-lsp

RUN jupyter serverextension enable --py jupyterlab --sys-prefix
# jupyterlab lsp
RUN jupyter labextension install\
    @krassowski/jupyterlab-lsp\
    @lckr/jupyterlab_variableinspector\
    jupyterlab-nvdashboard\
    jupyterlab_tensorboard
# jupyterlab-emacskeys
WORKDIR /opt
RUN git clone https://github.com/kpe/jupyterlab-emacskeys.git &&\
    cd jupyterlab-emacskeys &&\
    npm install &&\
    npm run build &&\
    jupyter labextension link .

RUN jupyter lab build

# install pyright
RUN npm install -g pyright

# install poetry
USER ${user}
RUN curl -sSL https://install.python-poetry.org | python3 -

USER ${root}

ADD .style.yapf /home/${user}/

ARG display
RUN echo "export DISPLAY=${display}" >> /etc/profile

ENV DISPLAY=${display} \
    DEBIAN_FRONTEND=newt

ADD entrypoint.sh /tmp/

WORKDIR /
