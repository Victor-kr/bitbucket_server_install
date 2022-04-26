#!/bin/bash

install_git() {

  case "$(git --version 2>/dev/null)" in
  *git*2.27.0*)
    return
  esac
  
  DOWNLOAD_DIR=/tmp
  DOWNLOAD_URL=https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.27.0.tar.gz

  sudo apt install  -y --no-install-recommends libz-dev libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext cmake gcc build-essential
  sudo apt remove -y git
  
  cd ${DOWNLOAD_DIR} && \
  curl -o git.tar.gz ${DOWNLOAD_URL}&& \
  tar -zxf git.tar.gz && \
  cd git-* && \
  sudo make prefix=/usr/local/git all  && \
  sudo make prefix=/usr/local/git install  

  export PATH=$PATH:/usr/local/git/bin
  git --version
}

install_git
