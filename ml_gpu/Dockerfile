FROM tensorflow/tensorflow:nightly-gpu-py3-jupyter

ENV DEBIAN_FRONTEND=noninteractive

ARG user
RUN useradd -m ${user} &&\
    usermod -aG sudo ${user}

RUN apt-get update && apt-get upgrade -y &&\
    apt-get install sudo git nodejs npm libsm6 libxext6 libxrender-dev -y

RUN npm install n -g && n stable
RUN apt purge -y nodejs npm

# installl python libraries
ADD requirements.txt /tmp/requirements.txt
RUN pip3 install -U pip
RUN pip3 install -r /tmp/requirements.txt && rm -rf /tmp/requirements.txt

# jupyter lab
RUN pip3 install jupyterlab widgetsnbextension
RUN jupyter serverextension enable --py jupyterlab --sys-prefix
# lsp
RUN pip3 install jupyter-lsp
RUN jupyter labextension install @krassowski/jupyterlab-lsp  # for JupyterLab 2.x
RUN pip3 install python-language-server[all]
# variable inspector
RUN jupyter labextension install @lckr/jupyterlab_variableinspector
# GPU dashboard
# RUN pip3 install jupyterlab-nvdashboard
# RUN jupyter labextension install jupyterlab-nvdashboard
# tensorboard
RUN pip3 install jupyter-tensorboard
RUN jupyter labextension install jupyterlab_tensorboard
# emacs keybind
RUN jupyter labextension install jupyterlab-emacskeys

RUN jupyter lab build

WORKDIR /home/${user}/work
USER ${user}
#RUN jupyter tensorboard enable --user

# chrome driver
RUN curl https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update
RUN apt-get install google-chrome-stable -y
