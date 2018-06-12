#!/usr/bin/env bash

# Do these checks before you start your presentation
# To ensure it goes smoothly!

# Ensure Elasticsearch is installed and running
$ sudo systemctl status elasticsearch.service

# Ensure the ports required are free
sudo netstat -lnp | grep 3000
sudo netstat -lnp | grep 8080

