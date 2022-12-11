#!/bin/sh
mkdir -p /var/run/sshd
mkdir -p /root/.ssh/ 
mkdir -p /run/openrc
touch /run/openrc/softlevel
chmod 600 ~/.ssh
chmod 600 /etc/ssh/*
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
echo $SSH_KEY > /root/.ssh/authorized_keys
# Modify `sshd_config`
sed -ri 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
sed -ri 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -ri 's/#UsePAM yes/UsePAM no/' /etc/ssh/sshd_config
rc-service sshd start
# echo root:eistee | chpasswd
# Delete root password (set as empty)
passwd -d root
rc-status
/entrypoint.sh