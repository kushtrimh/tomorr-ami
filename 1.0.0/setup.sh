#!/bin/bash

EXTERNAL_PROPS=$1
if [[ -z $EXTERNAL_PROPS ]];
then
    echo "S3 bucket URL for external properties is required"
    exit 1
fi

yum update -y
yum install -y shadow-utils tar gzip wget initscripts

# Install Java 17
mkdir /usr/java
wget https://download.java.net/java/GA/jdk17.0.1/2a2082e5a09d4267845be086888add4f/12/GPL/openjdk-17.0.1_linux-x64_bin.tar.gz
tar -xf openjdk-17.0.1_linux-x64_bin.tar.gz -C /usr/java
rm openjdk-17.0.1_linux-x64_bin.tar.gz

# Add user to handle code deployment
useradd codedeployer

cp profile.sh /etc/profile.d/tomorr.sh
echo "" >> /etc/profile.d/tomorr.sh
echo "export TOMORR_S3_EXTERNAL_PROPS=$1" >> /etc/profile.d/tomorr.sh

# Install the codedeploy agent
CODEDEPLOY_BIN="/opt/codedeploy-agent/bin/codedeploy-agent"
$CODEDEPLOY_BIN stop
yum erase -y codedeploy-agent

wget https://aws-codedeploy-eu-central-1.s3.eu-central-1.amazonaws.com/latest/install
chmod +x ./install
yum install -y ruby
./install auto
service codedeploy-agent status
rm ./install