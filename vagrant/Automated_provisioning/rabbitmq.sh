#!/bin/bash

# system updates and installs
sudo yum update -y
sudo yum install epel-release -y
sudo yum install wget -y
sudo yum install socat -y
cd /tmp/

# erlang
sudo wget https://packages.erlang-solutions.com/erlang/rpm/centos/7/x86_64/esl-erlang_23.3.1-1~centos~7_amd64.rpm
sudo yum install esl-erlang*.rpm -y


# rabbitmq
sudo wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.19/rabbitmq-server-3.8.19-1.el7.noarch.rpm
# sudo rpm --import https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
sudo yum install rabbitmq-server*.rpm -y
sudo systemctl start rabbitmq-server
sudo systemctl enable rabbitmq-server
sudo systemctl status rabbitmq-server

sudo sh -c 'echo "[{rabbit,
  [ 
    {tcp_listeners, [5672]},
    {loopback_users, []},
    {rabbitmq_management, [{listener, [{port, 15672}]}]},
    {rabbitmq_management, [{cors_allow_origins, ["*"]}]}
  ]
}]." > /etc/rabbitmq/rabbitmq.config'

sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administrator
sudo systemctl restart rabbitmq-server

sudo rabbitmq-plugins enable rabbitmq_management

# cleanup
sudo rm -rf esl-erlang_23.3.1-1~centos~7_amd64.rpm
sudo rm -rf rabbitmq-server-3.8.19-1.el7.noarch.rpm
