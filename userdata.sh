#!/bin/bash

# Update system
yum update -y

# -----------------------------
# Install Git
# -----------------------------
yum install -y git

# -----------------------------
# Install Docker
# -----------------------------
yum install -y docker
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# -----------------------------
# Install Java 17 (Required for Jenkins)
# -----------------------------
yum install -y java-17-openjdk

# Set JAVA_HOME automatically
JAVA_PATH=$(dirname $(dirname $(readlink -f $(which java))))
echo "JAVA_HOME=$JAVA_PATH" >> /etc/environment

# -----------------------------
# Install Jenkins
# -----------------------------
wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

yum install -y jenkins

systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins
