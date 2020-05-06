FROM osrf/ros2:nightly-rmw

MAINTAINER y-kitamu ymyk6602@gmail.com

ARG user

# add user
RUN useradd -ms /bin/bash ${user}
RUN usermod -aG sudo ${user}

# ssh (https://docs.docker.com/engine/examples/running_ssh_service/)
RUN apt-get update && apt-get upgrade -y && apt-get install openssh-server -y
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# display
ARG display
RUN echo "export DISPLAY=${display}" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
