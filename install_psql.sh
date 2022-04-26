#!/bin/bash

install_postgresql() {
  sudo apt-get --purge -y remove postgresql\*
  sudo apt install  -y --no-install-recommends  ufw wget
  sudo ufw allow 5432/tcp
  
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/postgresql-pgdg.list  > /dev/null
  sudo apt-get update
  sudo apt install -y --no-install-recommends postgresql-11
  
  sudo -u postgres -- psql --command "CREATE ROLE gituser WITH LOGIN PASSWORD 'gitpass' VALID UNTIL 'infinity';" && \
  sudo -u postgres -- psql --command "CREATE DATABASE gitdb WITH ENCODING='UTF8' OWNER=gituser CONNECTION LIMIT=-1;" && \
  sudo -u postgres -- psql --command "GRANT ALL PRIVILEGES ON DATABASE gitdb TO gituser;"

  sudo -u postgres -- sed -i s/"#listen_addresses = 'localhost'"/"listen_addresses = '*'"/g /etc/postgresql/11/main/postgresql.conf
  sudo -u postgres -- sed -i s/"local   all             all                                     peer"/"local   all             all                                     trust"/g /etc/postgresql/11/main/pg_hba.conf 
  
  sudo /etc/init.d/postgresql restart
}

install_postgresql 
