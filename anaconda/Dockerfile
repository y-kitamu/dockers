FROM continuumio/anaconda3

# install nodejs (required by labextension)
RUN apt-get update -y && apt-get upgrade -y
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - 
RUN apt-get install nodejs npm -y

RUN /opt/conda/bin/conda install jupyter -y --quiet
RUN /opt/conda/bin/jupyter serverextension enable --py jupyterlab

# install extensions
RUN /opt/conda/bin/jupyter labextension install jupyterlab-emacskeys
RUN /opt/conda/bin/jupyter labextension install @oriolmirosa/jupyterlab_materialdarker

# install other libraries
RUN /opt/conda/bin/conda install -c conda-forge pyprind -y

# add user
ARG user

RUN useradd -m ${user}
RUN usermod -aG sudo ${user}

USER ${user}
