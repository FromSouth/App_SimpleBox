#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne "0" ]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

# Update and install SSH server (if not already installed)
apt-get update
apt-get install -y openssh-server

# Game Management Setting
# Add a new user `gm` with password `gm` and add him to the root group
useradd -m gm -s /bin/bash && echo "gm:gm" | chpasswd
usermod -aG sudo gm

# User Setting
# Add a new user `allen`, create `user.txt` in his home directory, set his password, and enable SSH access
useradd -m allen -s /bin/bash && echo "allen:password" | chpasswd
echo "user's flag" > /home/allen/user.txt
chown allen:allen /home/allen/user.txt

# Ensure SSH service is enabled and running
systemctl enable ssh
systemctl start ssh

# Modify SSH config to allow password authentication, if necessary
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart ssh

# Privilege Escalation Setting
# In root's home directory, create `root.txt` and grant sudoers the ability to execute cp command as root without password
echo "root's flag" > /root/root.txt
echo "ALL ALL=(ALL) NOPASSWD: /bin/cp" >> /etc/sudoers
