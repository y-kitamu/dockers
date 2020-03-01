#!/bin/bash

if [ -f /home/${USER_NAME}/dotfiles/install.sh ]; then
    sudo -u ${USER_NAME} -sH /bin/bash -c "source /home/${USER_NAME}/dotfiles/install.sh"
fi
/usr/sbin/sshd -D
