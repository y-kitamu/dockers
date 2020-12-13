FROM ubuntu:latest AS go

# ref : https://github.com/emacs-lsp/lsp-docker/blob/master/lsp-docker-langservers/Dockerfile
MAINTAINER Y. Kitamura ymyk6602@gmail.com

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y wget \
	&& export LATEST_VERSION=`wget -qO- https://golang.org/dl | grep -oE go[0-9]+\.[0-9]+\.[0-9]+\.linux-amd64\.tar\.gz | head -n 1` \
	&& wget -c https://dl.google.com/go/$LATEST_VERSION \
	&& tar -xzf $LATEST_VERSION

FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
# General
RUN apt-get update \
	&& apt-get upgrade -y  \
	&& apt-get install -y git

# Go
COPY --from=go /go /go
ENV PATH "${PATH}:/go/bin:/root/go/bin"
RUN /go/bin/go get -u golang.org/x/tools/gopls

# NPM installed language servers
RUN apt-get install -y npm \
	&& npm i -g \
	bash-language-server \
	vscode-css-languageserver-bin \
	vscode-html-languageserver-bin \
	dockerfile-language-server-nodejs \
	typescript-language-server \
    typescript \
    vscode-json-languageserver \
    yaml-language-server
