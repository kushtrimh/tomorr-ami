#!/bin/bash

# Set environment variables
export JAVA_HOME=/usr/java/jdk-17.0.1
export PATH=$PATH:/usr/java/jdk-17.0.1/bin

# Create needed directories
for dir_to_create in "/var/run/tomorr" "/var/log/tomorr" "/etc/tomorr/"; do
    if [ ! -d $dir_to_create ]; then
        mkdir $dir_to_create
        chown codedeployer $dir_to_create
    fi
done