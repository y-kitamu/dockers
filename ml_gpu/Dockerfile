FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu18.04

ARG user
RUN useradd -m ${user} &&\
    usermod -aG sudo ${user}

RUN apt-get update && apt-get upgrade -y &&\
    apt-get install python3-dev python3-pip -y

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - 
RUN apt-get install nodejs npm -y

RUN pip3 install jupyter
RUN pip3 install jupyterlab widgetsnbextension
RUN jupyter serverextension enable --py jupyterlab --sys-prefix

# jupyter extensions
RUN jupyter labextension install jupyterlab-emacskeys 
RUN jupyter labextension install @oriolmirosa/jupyterlab_materialdarker
RUN pip3 install --upgrade jupyterlab-git
RUN jupyter lab build

RUN apt-get update && apt-get upgrade -y && apt-get install sudo git -y
RUN apt-get install libsm6 libxext6 libxrender-dev -y

RUN pip3 install -U pip
# python data science, machine learning or deep learning libraries
RUN pip3 install numpy pandas matplotlib seaborn scikit-learn opencv-python
RUN pip3 install tensorflow tensorflow-gpu pandas-ml
RUN pip3 install tensorflow-hub tensorflow-datasets tensorflow-text
RUN pip3 install -q git+https://github.com/tensorflow/docs
RUN pip3 install pillow plotly
RUN pip3 install torch torchvision

# jupyter videostream library
RUN pip3 install ipywebrtc
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-webrtc

# for gui app
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install python3-tk -y

USER ${user}
