#!/bin/bash

# Update system
dnf update -y

# -----------------------------
# Install Git
# -----------------------------
dnf install -y git

# -----------------------------
# Install Docker
# -----------------------------
dnf install -y docker
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user

# -----------------------------
# Install Java 17 (Required for Jenkins)
# -----------------------------
dnf install -y java-17-amazon-corretto

# -----------------------------
# Add Jenkins Repository (RHEL compatible)
# -----------------------------
wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# -----------------------------
# Install Jenkins
# -----------------------------
dnf install -y jenkins

systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins
