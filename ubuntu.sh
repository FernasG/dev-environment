#!/bin/bash

printf "Updating Repositories...\n"
sudo apt -qq update
sudo apt -qq upgrade -y

printf "\nVisual Studio Code...\n"
wget -O $HOME/Downloads/vscode.deb 'https://update.code.visualstudio.com/latest/linux-deb-x64/stable'
sudo dpkg -i $HOME/Downloads/vscode.deb

printf "\nNVM - NodeJS...\n"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

printf "\nSpotify...\n"
sudo apt -qq install curl -y
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt -qq install spotify-client -y

printf "\nDocker...\n"
sudo apt -qq install ca-certificates gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo apt -qq update
sudo apt -qq install docker-ce docker-ce-cli containerd.io -y
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

printf "\nDocker Compose...\n"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

printf "\nStyles...\n"
sudo apt -qq install gnome-tweaks git gnome-shell-extensions -y
git clone https://github.com/yeyushengfan258/Reversal-icon-theme.git $HOME/Downloads/reversal-icon
git clone https://github.com/EliverLara/Juno.git $HOME/.local/share/themes/Juno
$HOME/Downloads/reversal-icon/install.sh
gsettings set org.gnome.desktop.interface icon-theme 'Reversal'
gsettings set org.gnome.desktop.interface gtk-theme 'Juno'
gsettings set org.gnome.desktop.wm.preferences theme 'Juno'
