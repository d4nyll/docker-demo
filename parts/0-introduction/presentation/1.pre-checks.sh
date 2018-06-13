#!/usr/bin/env bash

# Do these checks before you start your presentation
# To ensure it goes smoothly!

# Ensure Elasticsearch is installed and running
sudo systemctl status elasticsearch.service
curl -X DELETE localhost:9200/demo

# Double check that there's nothing in the data store
gr @backend npm run start
curl localhost:3000

# Ensure the ports required are free
sudo netstat -lnp | grep 3000
sudo netstat -lnp | grep 8080

# Ensure old Docker containers are deleted
docker ps -a
docker stop frontend backend elasticsearch
docker rm frontend backend elasticsearch