FROM nvidia/cudagl:11.4.2-devel

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

# utilities
RUN apt-get update && apt-get install -y \
    sudo\
    libnss3\
    libatk1.0-dev\
    libatk-bridge2.0-dev\
    libcups2\
    libdrm2\
    libgtk-3-0\
    libgbm1\
    libasound2\
    libgtkextra-dev\
    libgconf2-dev\
    libxtst-dev\
    libxss1\
    libcanberra-gtk*\
    nodejs\
    npm\
    build-essential\
    mesa-utils\
    curl\
    git\
    python3-dev\
    python3-venv\
    python3-pip

# update npm
RUN npm install n -g && n stable && apt purge -y nodejs npm

# lsp
RUN npm install i -g \
    vscode-html-languageserver-bin\
    typescript-language-server\
    typescript\
    javascript-typescript-langserver\
    vscode-css-languageserver-bin\
    pyright

# heroku
RUN curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

# python settings
WORKDIR /tmp
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN pip install uvicorn fastapi

RUN usermod -aG sudo ${user}

ARG display
RUN echo "export DISPLAY=${display}" >> /etc/profile &&\
    echo "export DBUS_SYSTEM_BUS_ADDRESS='unix:path=/var/run/dbus/system_bus_socket'" >> /etc/profile  &&\
    echo "export DBUS_SESSION_BUS_ADDRESS='unix:path=/var/run/dbus/system_bus_socket'" >> /etc/profile

ENV DISPLAY=${display} \
    DEBIAN_FRONTEND=newt

WORKDIR /
