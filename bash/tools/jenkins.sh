#!/bin/bash

## First step Verify if it's root user
# echo $EUI
if [ "$EUID" -ne 0 ]; then
  echo "this script must be execute as root"
  exit 1
else
  echo "continue with installation"
fi

echo "# $(date) Installation started"

echo "# $(date) Installing jenkins key"
wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

apt-get update -qq
echo "# $(date) Installing Java, Jenkins, etc."
apt-get install curl openjdk-17-jre ca-certificates lsb-release gnupg jenkins -y

echo "# $(date) Restart Jenkins"
systemctl restart jenkins

echo "# $(date) Installation complete!"
echo " Username: Admin"
echo " Password: $(cat /var/lib/jenkins/secrets/initialAdminPassword)"

