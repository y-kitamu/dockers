#!/bin/bash

if [ -f /home/${USER_NAME}/dotfiles/install.sh ]; then
    sudo -u ${USER_NAME} -sH /bin/bash -c "source /home/${USER_NAME}/dotfiles/install.sh"
fi
unset USER_NAME

source "/opt/ros/$ROS_DISTRO/setup.bash"

/usr/sbin/sshd -D
