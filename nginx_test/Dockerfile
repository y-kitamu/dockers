FROM nginx:latest

RUN apt-get update && apt-get upgrade -y && apt-get install apache2-utils -y

ARG USER
ARG PASSWORD


RUN htpasswd -bc /etc/nginx/htpasswd ${USER} ${PASSWORD}
