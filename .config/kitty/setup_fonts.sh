#!/bin/bash

sudo mkdir -p /usr/share/fonts/firacode/
wget -O /tmp/firacode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip
sudo unzip -o /tmp/firacode.zip -d /usr/share/fonts/firacode/
