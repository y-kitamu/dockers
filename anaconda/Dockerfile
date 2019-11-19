FROM continuumio/anaconda3

##### JupyterLab Settings #####

# install nodejs (required by labextension)
RUN apt-get update -y && apt-get upgrade -y
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - 
RUN apt-get install nodejs npm -y

RUN /opt/conda/bin/conda install jupyter -y --quiet
RUN /opt/conda/bin/jupyter serverextension enable --py jupyterlab

# install other python libraries
RUN /opt/conda/bin/conda install -c conda-forge pyprind -y
RUN /opt/conda/bin/conda install wtforms -y # for flask
RUN /opt/conda/bin/conda install Theano -y
RUN /opt/conda/bin/conda install statsmodels -y  # statistical model

RUN /opt/conda/bin/conda install cupy -y
RUN /opt/conda/bin/conda install chainer -y

RUN /opt/conda/bin/pip install opencv-python

RUN /opt/conda/bin/conda update jupyterlab -y

# install extensions
RUN /opt/conda/bin/jupyter labextension install jupyterlab-emacskeys
RUN /opt/conda/bin/jupyter labextension install @oriolmirosa/jupyterlab_materialdarker

##### Other Settings #####
RUN apt-get update -y && apt-get install sudo -y

# add user
ARG user
ARG password

RUN useradd -m ${user} &&\
    usermod -aG sudo ${user} &&\
    echo "${user}:${password}" | chpasswd

USER ${user}
