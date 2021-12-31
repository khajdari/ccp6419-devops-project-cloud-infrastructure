#!/bin/bash
sudo apt-get -y update
sudo apt-get -y upgrade

# setup java environment
sudo apt-get -y install openjdk-8-jdk
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

# setup ansible environment
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get -y update
sudo apt-get -y install ansible

# setup ssh availability
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo systemctl restart sshd
sudo service sshd reload
sudo yes '' | ssh-keygen -N '' > /dev/null\

# setup pipeline user
sudo adduser --quiet --disabled-password --shell /bin/bash --home /home/cicdadmin --gecos "User" cicdadmin
echo "cicdadmin:cicdadmin" | sudo chpasswd
sudo usermod -aG sudo cicdadmin

#setup anisble hosts
sudo chown cicdadmin:cicdadmin /etc
sudo chown cicdadmin:cicdadmin /etc/ansible
sudo chown cicdadmin:cicdadmin /etc/ansible/hosts

