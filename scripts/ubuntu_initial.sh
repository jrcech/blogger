#!/usr/bin/env bash

user="skripter"
dummy_password="some-secure-password"
password="real-password"

useradd -p $dummy_password $user
echo $user:$password | chpasswd
usermod -aG sudo $user

ufw allow 'OpenSSH'
ufw enable

rsync --archive --chown=$user:$user ~/.ssh /home/$user

apt update
apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install -y docker-ce
usermod -aG docker $user
su - $user
