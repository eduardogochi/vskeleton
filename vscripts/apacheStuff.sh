#!/usr/bin/env bash
#Take ownership of folder for apache
echo "Assigning ownership..."
sudo systemctl stop httpd
sudo usermod -u 510 apache
sudo groupmod -g 510 apache
sudo systemctl start httpd