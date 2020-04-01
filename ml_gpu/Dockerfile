FROM nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04

ENV DEBIAN_FRONTEND=noninteractive

ARG user
RUN useradd -m ${user} &&\
    usermod -aG sudo ${user}

RUN apt-get update && apt-get upgrade -y &&\
    apt-get install python3.8-dev python3-pip python3-tk -y

RUN apt-get update && apt-get upgrade -y &&\
    apt-get install sudo git nodejs npm curl libsm6 libxext6 libxrender-dev -y

RUN npm install n -g && n stable
RUN apt purge -y nodejs npm

# installl python libraries
ADD requirements.txt /tmp/requirements.txt
RUN pip3 install -U pip
RUN pip3 install -r /tmp/requirements.txt && rm -rf /tmp/requirements.txt

# jupyter lab
RUN jupyter serverextension enable --py jupyterlab --sys-prefix
# emacs keybind
RUN jupyter labextension install jupyterlab-emacskeys
# lsp
RUN jupyter labextension install @krassowski/jupyterlab-lsp  # for JupyterLab 2.x
RUN pip install python-language-server[all]
# variable inspector
RUN jupyter labextension install @lckr/jupyterlab_variableinspector
# GPU dashboard
RUN pip install jupyterlab-nvdashboard
RUN jupyter labextension install jupyterlab-nvdashboard

RUN jupyter lab build

USER ${user}
