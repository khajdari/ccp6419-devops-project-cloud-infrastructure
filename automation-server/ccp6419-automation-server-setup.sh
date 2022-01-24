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

# setup azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
sudo apt-get update
sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg
curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-get update
sudo apt-get install azure-cli

# setup jenkins environment
sudo wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo echo deb http://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt-get -y update
sudo apt-get -y --allow-unauthenticated install jenkins

# setup docker environment
sudo apt-get -y update
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get -y update
sudo apt-get -y install docker-ce

# setup terraform environment
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

# setup ssh availability
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo systemctl restart sshd
sudo service sshd reload

# setup jenkins user
sudo adduser --quiet --disabled-password --shell /bin/bash --home /home/cicdadmin --gecos "User" cicdadmin
echo "cicdadmin:cicdadmin" | sudo chpasswd
sudo usermod -aG sudo cicdadmin
sudo usermod -aG docker cicdadmin

sudo usermod -aG sudo jenkins
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins

