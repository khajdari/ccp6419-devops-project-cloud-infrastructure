#!/bin/bash
sudo apt-get -y update

# setup java environment
sudo apt-get -y install openjdk-8-jdk
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

# setup docker environment
sudo apt-get -y update
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get -y update
sudo apt-get -y install docker-ce

# setup ssh availability
sudo sed -re 's/^(PasswordAuthentication)([[:space:]]+)no/\1\2yes/' -i.`date -I` /etc/ssh/sshd_config
sudo service sshd reload

# setup pipeline user
sudo adduser --quiet --disabled-password --shell /bin/bash --home /home/dockeradmin --gecos "User" dockeradmin
echo "dockeradmin:dockeradmin" | sudo chpasswd
sudo usermod -aG sudo dockeradmin
sudo usermod -aG docker dockeradmin

