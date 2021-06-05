#!/bin/bash

printf "Updating Repositories...\n"
sudo apt -qq update
sudo apt -qq upgrade -y

printf "\nVisual Studio Code...\n"
wget -O $HOME/Downloads/vscode.deb 'https://update.code.visualstudio.com/latest/linux-deb-x64/stable'
sudo dpkg -i $HOME/Downloads/vscode.deb

printf "\nSpotify...\n"
sudo apt -qq install curl -y
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt -qq install spotify-client -y

printf "\nStyles...\n"
sudo apt -qq install gnome-tweaks git gnome-shell-extensions -y
git clone https://github.com/yeyushengfan258/Reversal-icon-theme.git $HOME/Downloads/reversal-icon
git clone https://github.com/EliverLara/Juno.git $HOME/.local/share/themes/Juno
$HOME/Downloads/reversal-icon/install.sh
gsettings set org.gnome.desktop.interface icon-theme 'Reversal'
gsettings set org.gnome.desktop.interface gtk-theme 'Juno'
gsettings set org.gnome.desktop.wm.preferences theme 'Juno'
