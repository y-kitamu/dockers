FROM ubuntu:latest

LABEL maintainer="Y.Kitamu <ymyk6602@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

# NPM installed language servers
RUN apt-get update &&\
    apt-get upgrade -y &&\
    apt-get install -y npm python3 python3-pip &&\
    rm -rf /var/lib/apt/lists/*

RUN npm i -g \
	bash-language-server \
	vscode-css-languageserver-bin \
	vscode-html-languageserver-bin \
	dockerfile-language-server-nodejs \
	typescript-language-server \
    typescript \
    vscode-json-languageserver \
    yaml-language-server

RUN pip3 install cmake-language-server
