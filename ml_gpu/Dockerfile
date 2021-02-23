FROM tensorflow/tensorflow:latest-gpu

ENV DEBIAN_FRONTEND=noninteractive

ARG user
RUN useradd -m ${user} &&\
    usermod -aG sudo ${user}

RUN apt-get update && apt-get upgrade -y &&\
    apt-get install sudo git nodejs npm libsm6 libxext6 libxrender-dev libgl1-mesa-dev -y

RUN npm install n -g && n stable
RUN apt purge -y nodejs npm

# jupyter lab
RUN python3 -m pip install --upgrade pip
RUN pip3 install jupyterlab==2.2.0 widgetsnbextension
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

ADD .style.yapf /home/${user}/

# RUN rm /usr/local/cuda && ln -s /usr/local/cuda-10.2 /usr/local/cuda
# make sure to install latest tensorflow
RUN pip3 install --upgrade pip && pip3 install tensorflow-gpu

#
# bugfix
RUN sed -i \
    -e '/log = logging.getLogger(__name__)/alog.setLevel(logging.ERROR)' \
    `python -c "import site; print (site.getsitepackages()[0])"`/pyls_jsonrpc/streams.py
RUN sed -i \
    -e '/log = logging.getLogger(__name__)/alog.setLevel(logging.ERROR)' \
    `python -c "import site; print (site.getsitepackages()[0])"`/pyls_jsonrpc/endpoint.py

# install pyright
RUN npm install pyright -g

# installl python libraries
ADD requirements.txt /tmp/requirements.txt
RUN pip3 install -U pip
RUN pip3 install -r /tmp/requirements.txt && rm -rf /tmp/requirements.txt

RUN pip3 install git+https://github.com/y-kitamu/mython

WORKDIR /home/${user}/work
USER ${user}
#RUN jupyter tensorboard enable --user
