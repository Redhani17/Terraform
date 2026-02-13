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
# Install Java (Required for Jenkins)
# -----------------------------
amazon-linux-extras install java-openjdk11 -y

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
