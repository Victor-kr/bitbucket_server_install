#!/bin/bash

install_java() {
  case "$(java --version 2>/dev/null)" in
  *OpenJDK*11*)
    return
  esac

  DOWNLOAD_URL=https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz

  sudo apt remove -y git
  sudo apt install  -y --no-install-recommends wget

  # Download Java And Install
  sudo mkdir -p /opt/java && \
  sudo wget ${DOWNLOAD_URL} -O /opt/java/openjdk-11.0.2_linux-x64_bin.tar.gz && \
  cd /opt/java && \
  sudo tar -xzf openjdk-11.0.2_linux-x64_bin.tar.gz && \
  sudo rm -f openjdk-11.0.2_linux-x64_bin.tar.gz && \
  sudo ln -s jdk-11.0.2 jdk_11 && \
  sudo update-alternatives --install /usr/bin/java java /opt/java/jdk_11/bin/java 0

  export PATH=$PATH:/opt/java/jdk_11/bin
  java -version
}

sudo apt update

install_java
