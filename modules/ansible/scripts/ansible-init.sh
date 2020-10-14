#!/bin/bash

sudo hostname ansible-control-node
sudo apt-get update 
sudo apt-get install -y python python-pip
sudo pip install ansible

sudo mkdir /etc/ansible
#sudo useradd ${ANSIBLE_USER} 
# sudo passwd ${ANSIBLE_PASSWORD}  
sudo useradd -p $(openssl passwd -1 "${ANSIBLE_PASSWORD}") "${ANSIBLE_USER}"

# sudo echo "${ANSIBLE_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

sudo su - ${ANSIBLE_USER}

# ssh-keygen
# ssh-copy-id ansadmin@<target-server>

# install docker 
apt-get remove -y docker docker-engine docker.io
apt install -y docker.io
groupadd docker
usermod -aG docker ${ANSIBLE_USER}
chmod 666 /var/run/docker.sock
systemctl start docker
systemctl enable docker
docker --version 


# apt-get install docker 
# service docker start 

# usermod -aG docker ansadmin

# ansible all -m ping 

# Replace line/ Remove and Insert line on /etc/ssh/sshd_config
#  PasswordAuthentication yes 
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sevice sshd reload
 
 
  
