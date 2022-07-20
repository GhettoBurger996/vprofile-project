#!/bin/bash

# update and install necessary packages
sudo yum update -y
sudo yum install epel-release -y

# download and install postgres
sudo yum install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm -y
sudo yum install postgresql12-server postgresql12 -y

# initialize postgres db and enable on startup
sudo /usr/pgsql-12/bin/postgresql-12-setup initdb
sudo systemctl start postgresql-12.service 
sudo systemctl enable postgresql-12.service 

#starting the firewall and allowing the mariadb to access from port no. 5432
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=public --add-port=5432/tcp --permanent
sudo firewall-cmd --reload
sudo systemctl restart postgresql-12.service 
