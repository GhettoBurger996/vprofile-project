#!/bin/bash

# system updates and installs
sudo yum update -y
sudo yum install epel-release -y
sudo yum install git -y
cd /tmp/

# install nvm & node
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
. ~/.nvm/nvm.sh
nvm install v16.16.0

# install yarn & (typescript, nodemon)
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
sudo yum install yarn -y
npm install -g typescript nodemon

# setup project
git clone https://github.com/GhettoBurger996/abc-school_backend
cd abc-school_backend
yarn install
yarn start:dev
