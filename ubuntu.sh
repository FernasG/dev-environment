#!/bin/bash

printf "Downloading Packages...\n"
# Prerequisite Packages
sudo apt -qq install curl ca-certificates gnupg lsb-release gnome-tweaks git gnome-shell-extensions -y
# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
# Visual Studio Code
wget --quiet -O $HOME/Downloads/vscode.deb "https://update.code.visualstudio.com/latest/linux-deb-x64/stable"
# Spotify
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo gpg --dearmour -o /usr/share/keyrings/spotify.gpg 
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/spotify.gpg] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
# Beekeeper Studio
wget --quiet -O - https://deb.beekeeperstudio.io/beekeeper.key | sudo gpg --dearmour -o /usr/share/keyrings/beekeeperstudio.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/beekeeperstudio.gpg] https://deb.beekeeperstudio.io stable main" | sudo tee /etc/apt/sources.list.d/beekeeper-studio-app.list
# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# Insomnia
echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" | sudo tee -a /etc/apt/sources.list.d/insomnia.list
# Theme & Icon
git clone https://github.com/yeyushengfan258/Reversal-icon-theme.git $HOME/Downloads/reversal-icon
git clone https://github.com/EliverLara/Juno.git $HOME/.local/share/themes/Juno

printf "\nUpdating Repositories...\n"
sudo apt -qq update && sudo apt -qq upgrade -y

printf "\nInstalling Packages...\n"
sudo dpkg -i $HOME/Downloads/vscode.deb
$HOME/Downloads/reversal-icon/install.sh
sudo chmod +x /usr/local/bin/docker-compose
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
sudo apt -qq install spotify-client beekeeper-studio docker-ce docker-ce-cli containerd.io insomnia -y
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

printf "\nSetting Gnome Themes...\n"
gsettings set org.gnome.desktop.interface icon-theme "Reversal"
gsettings set org.gnome.desktop.interface gtk-theme "Juno"
gsettings set org.gnome.desktop.wm.preferences theme "Juno"