FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu18.04

ARG user
ARG password
RUN useradd -m ${user} &&\
    usermod -aG sudo ${user} &&\
    echo "${user}:${password}" | chpasswd

RUN apt-get update && apt-get upgrade -y &&\
    apt-get install python3-dev python3-pip -y

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - 
RUN apt-get install nodejs npm -y

RUN pip3 install jupyter
RUN pip3 install jupyterlab widgetsnbextension
RUN jupyter serverextension enable --py jupyterlab --sys-prefix

RUN jupyter labextension install jupyterlab-emacskeys
RUN jupyter labextension install @oriolmirosa/jupyterlab_materialdarker

RUN pip3 install -U pip
RUN pip3 install numpy pandas matplotlib seaborn scikit-learn opencv-python
RUN pip3 install tensorflow tensorflow-gpu pandas-ml
RUN pip3 install tensorflow-hub tensorflow-datasets

RUN apt-get update && apt-get upgrade -y && apt-get install sudo git -y
RUN pip3 install -q git+https://github.com/tensorflow/docs

RUN pip3 install pillow

USER ${user}

