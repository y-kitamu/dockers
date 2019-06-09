FROM jupyter/scipy-notebook

USER root

ARG passwd
RUN echo "jovyan:${passwd}" | chpasswd

USER jovyan

# install nbextensions
RUN pip install jupyter_contrib_nbextensions
RUN jupyter contrib nbextension install --user

# install jupyter emacs keybindings
RUN pip install jupyter-emacskeys

# google spread sheet api
RUN pip install gspread oauth2client

USER root
RUN apt-get update && apt-get install iproute2 -y

USER jovyan # 最後に user を jovyan にしないとエラーになる
