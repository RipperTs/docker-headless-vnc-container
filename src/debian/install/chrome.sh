#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install latest stable Google Chrome"
wget -qO /tmp/google-chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_$(dpkg --print-architecture).deb"
apt-get update
apt-get install -y /tmp/google-chrome.deb
rm /tmp/google-chrome.deb
apt-get clean -y
