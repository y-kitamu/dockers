FROM httpd:latest

MAINTAINER Yusuke Kitamura

RUN sed -i\
    -e 's/^#(Include .*httpd.ssl.conf)/\1/"' \
    -e 's/^#(LoadModule ss'
