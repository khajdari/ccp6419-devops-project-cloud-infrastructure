#!/bin/bash
sudo apt-get -y update

# setup java environment
sudo apt-get -y install openjdk-8-jdk
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

# setup maven environment
sudo apt-get -y update
sudo apt-get -y install maven

# setup git environment
sudo apt-get -y update
sudo apt-get -y install git

# setup docker environment
sudo apt-get -y update
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get -y update
sudo apt-get -y install docker-ce

# setup jenkins environment
sudo wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo echo deb http://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt-get -y update
sudo apt-get -y --allow-unauthenticated install jenkins

# setup ssh availability
sudo sed -re 's/^(PasswordAuthentication)([[:space:]]+)no/\1\2yes/' -i.`date -I` /etc/ssh/sshd_config
sudo service sshd reload

# setup jenkins user
sudo usermod -aG sudo jenkins
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins

