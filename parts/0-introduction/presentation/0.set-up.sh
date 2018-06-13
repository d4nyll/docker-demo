#!/usr/bin/env bash

# The following instructions are meant for Ubuntu
# for other platforms, check the linked documentation

# Install Elasticsearch
sudo apt update
sudo apt install default-jdk
sudo echo ‘JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"’ >> /etc/environment
source /etc/environment
sudo dpkg -i elasticsearch-6.1.1.deb
sudo systemctl start elasticsearch.service
sudo systemctl enable elasticsearch.service
sudo systemctl daemon-reload

# Install NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
. ~/.bashrc

# Install and use latest LTS version of Node
nvm install lts/*
nvm use lts/*

# Install the Yarn package manager
# https://yarnpkg.com/en/docs/install
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install --no-install-recommends yarn

# Install mdp (to run the presentation)
sudo apt update
sudo apt install mdp

# Install Git Run (`gr`) globally
yarn global add git-run

# Ensure Docker images are pulled in beforehand
docker pull node
docker pull docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.4
