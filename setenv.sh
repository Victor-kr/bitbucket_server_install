#!/bin/bash 

sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
echo "umask 027" | sudo tee -a /etc/profile  
echo "JAVA_HOME=/opt/java/jdk_11" | sudo tee -a /etc/environment
echo "JRE_HOME=/opt/java/jdk_11" | sudo tee -a /etc/environment
echo "PATH=$PATH:/opt/java/jdk_11/bin:/usr/local/git/bin" | sudo tee -a /etc/environment
