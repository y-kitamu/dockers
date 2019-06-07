FROM jupyter/scipy-notebook

USER root
USER jovyan

# install nbextensions
RUN pip install jupyter_contrib_nbextensions
RUN jupyter contrib nbextension install --user

# install jupyter emacs keybindings
RUN pip install jupyter-emacskeys

# google spread sheet api
RUN pip install gspread oauth2client

