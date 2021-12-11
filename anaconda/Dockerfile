FROM continuumio/anaconda3

# add user
ARG user
ARG password

RUN useradd -m ${user} &&\
    usermod -aG sudo ${user} &&\
    echo "${user}:${password}" | chpasswd

##### JupyterLab Settings #####

# install nodejs (required by labextension)
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install nodejs npm -y
# update npm
RUN npm install n -g && n stable && apt purge -y nodejs npm

RUN /opt/conda/bin/conda install jupyter -y --quiet
RUN /opt/conda/bin/jupyter serverextension enable --py jupyterlab

# install other python libraries
RUN /opt/conda/bin/conda install -c conda-forge pyprind -y
RUN /opt/conda/bin/conda install wtforms -y # for flask
RUN /opt/conda/bin/conda install Theano -y
RUN /opt/conda/bin/conda install statsmodels -y  # statistical model

RUN /opt/conda/bin/pip install cupy
RUN /opt/conda/bin/pip install chainer

RUN /opt/conda/bin/pip install opencv-python
RUN /opt/conda/bin/pip install chainercv

RUN /opt/conda/bin/pip install tensorflow

ADD libs /opt/libs
WORKDIR /opt/libs

RUN cd cocoapi/PythonAPI && make && make install

WORKDIR /

RUN /opt/conda/bin/conda update jupyterlab -y

# install extensions
RUN /opt/conda/bin/jupyter labextension install jupyterlab-emacskeys
RUN /opt/conda/bin/jupyter labextension install @oriolmirosa/jupyterlab_materialdarker

##### Other Settings #####
RUN apt-get update -y && apt-get install sudo -y

USER ${user}
