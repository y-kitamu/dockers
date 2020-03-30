FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu18.04

ARG user
RUN useradd -m ${user} &&\
    usermod -aG sudo ${user}

RUN apt-get update && apt-get upgrade -y &&\
    apt-get install python3-dev python3-pip -y

RUN apt-get update && apt-get upgrade -y && apt-get install sudo git -y
RUN apt-get install libsm6 libxext6 libxrender-dev -y

RUN pip3 install -U pip
# python data science, machine learning or deep learning libraries
RUN pip3 install numpy pandas matplotlib seaborn scikit-learn scikit-image opencv-python
RUN pip3 install tensorflow tensorflow-gpu pandas-ml
RUN pip3 install tensorflow-hub tensorflow-datasets tensorflow-text
RUN pip3 install -q git+https://github.com/tensorflow/docs
RUN pip3 install pillow plotly
RUN pip3 install torch torchvision

# for gui app
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install python3-tk -y

# jupyter
RUN apt install -y nodejs npm curl
RUN npm install n -g && n stable
RUN apt purge -y nodejs npm

RUN pip3 install jupyter
RUN pip3 install jupyterlab widgetsnbextension
RUN jupyter serverextension enable --py jupyterlab --sys-prefix

# jupyter extensions
RUN jupyter labextension install jupyterlab-emacskeys 
# RUN jupyter labextension install @oriolmirosa/jupyterlab_materialdarker
# lsp
RUN pip install jupyter-lsp
RUN jupyter labextension install @krassowski/jupyterlab-lsp  # for JupyterLab 2.x
RUN pip install python-language-server[all]

RUN jupyter lab build

USER ${user}
