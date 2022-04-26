#!/bin/bash

install_bitbucket() { 
  LANG=en_US.UTF-8 
  LANGUAGE=en_US:en 
  LC_ALL=en_US.UTF-8
  SEARCH_ENABLED=true
  APPLICATION_MODE=default 
  APP_NAME=bitbucket
  
  RELEASE_VERSION=7.21.0
  RUN_USER=bitbucket 
  RUN_GROUP=bitbucket
  RUN_UID=2003
  RUN_GID=2003
  BITBUCKET_HOME=/var/atlassian/application-data/bitbucket
  BITBUCKET_INSTALL_DIR=/opt/atlassian/bitbucket
  DOWNLOAD_URL=https://product-downloads.atlassian.com/software/stash/downloads/atlassian-bitbucket-7.21.0.tar.gz 

  # Depnedency packages
  apt-get install -y --no-install-recommends tzdata ca-certificates fontconfig locales wget ufw && \
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
  locale-gen en_US.UTF-8   
  
  # GIT depnedency packages 
  sudo ufw allow 7990/tcp
  sudo ufw allow 7999/tcp

  # Preparing Home & Install Directory
  sudo rm -rf  ${BITBUCKET_INSTALL_DIR} && \
  sudo rm -rf ${BITBUCKET_HOME} && \
  sudo mkdir -p  ${BITBUCKET_INSTALL_DIR} && \
  sudo mkdir -p ${BITBUCKET_HOME}

  # Install Bitbucket 
  sudo wget ${DOWNLOAD_URL} -O ${BITBUCKET_INSTALL_DIR}/bitbucket.tar.gz && \
  cd ${BITBUCKET_INSTALL_DIR} && \
  sudo tar -xzf bitbucket.tar.gz && \
  sudo mv atlassian-bitbucket-${RELEASE_VERSION}/* ${BITBUCKET_INSTALL_DIR} && \
  sudo rm -rf  ${BITBUCKET_INSTALL_DIR}/atlassian-bitbucket-${RELEASE_VERSION}

  # Environments
  sudo sed -i s@"    BITBUCKET_HOME="@"    BITBUCKET_HOME=${BITBUCKET_HOME}"@g ${BITBUCKET_INSTALL_DIR}/bin/set-bitbucket-home.sh && \
  sudo sed -i s@"^# umask 0027"@"umask 0027"@g ${BITBUCKET_INSTALL_DIR}/bin/_start-webapp.sh
  sudo sed -i s@"^#JVM_SUPPORT_RECOMMENDED_ARGS="@"JVM_SUPPORT_RECOMMENDED_ARGS=-Dcluster.node.name=Node1"@g ${BITBUCKET_INSTALL_DIR}/bin/_start-webapp.sh
  sudo sed -i s@"    JVM_MINIMUM_MEMORY=512m"@"    JVM_MINIMUM_MEMORY=3g"@g ${BITBUCKET_INSTALL_DIR}/bin/_start-webapp.sh
  sudo sed -i s@"    JVM_MAXIMUM_MEMORY=1g"@"    JVM_MAXIMUM_MEMORY=3g"@g ${BITBUCKET_INSTALL_DIR}/bin/_start-webapp.sh

  # Permissions
  sudo groupadd --gid ${RUN_GID} ${RUN_GROUP} && \
  sudo useradd --uid ${RUN_UID} --gid ${RUN_GID} --home-dir ${BITBUCKET_HOME} --shell /bin/bash ${RUN_USER}
  sudo chmod -R "u=rwX,g=rX,o=rX" ${BITBUCKET_INSTALL_DIR}/ && \ 
  sudo chown -R ${RUN_USER}:${RUN_GROUP} ${BITBUCKET_INSTALL_DIR}/ && \
  sudo chown -R ${RUN_USER}:${RUN_GROUP} ${BITBUCKET_HOME} 
    
  # Start Bitbucket Server
  cd ${BITBUCKET_INSTALL_DIR}/bin && \
  sudo -u ${RUN_USER} -- ./start-bitbucket.sh 
}

#################################################################
#Main
#################################################################

sudo apt update

install_bitbucket
