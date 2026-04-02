#!/usr/bin/env bash
set -e

export DEBIAN_FRONTEND=noninteractive

# Accept Microsoft EULA automatically
echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" \
  | sudo debconf-set-selections

# Update and install
sudo apt-get update
sudo apt-get install -y ttf-mscorefonts-installer

# Refresh font cache
fc-cache -f -v