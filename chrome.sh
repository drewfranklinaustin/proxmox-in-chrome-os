#!/bin/bash
curl -s https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo sh -c 'gpg --dearmor > /usr/share/keyrings/google-chrome-keyring.gpg'
sudo apt update
sudo apt upgrade 
curl -sO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install -f -y
google-chrome
