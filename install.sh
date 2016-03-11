#!/bin/bash

# Universal Install Script
# http://www.xkcd.net/1654

pip install "$1" &
easy_install "$1" &
brew install "$1" &
npm install "$1" &
yum install "$1" & dnf install "$1" &
docker run "$1" &
apt-get install "$1" &
sudo apt-get install "$1" &
steamcmd +aap_update "$1" validate &
git clone https://github.com/"$1"/$1" &
cd "$1";./configre;make;make install &
curl "$1" | bash &


