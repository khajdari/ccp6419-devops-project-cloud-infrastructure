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
sudo curl -L https://github.com/docker/compose/releases/download/v2.2.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# setup ssh availability
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo systemctl restart sshd
sudo service sshd reload

# setup pipeline user
sudo adduser --quiet --disabled-password --shell /bin/bash --home /home/cicdadmin --gecos "User" cicdadmin
echo "cicdadmin:cicdadmin" | sudo chpasswd
sudo usermod -aG sudo cicdadmin
sudo usermod -aG docker cicdadmin

