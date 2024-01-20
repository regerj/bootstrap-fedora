#!/bin/bash
#######################################################################
#
# Basic updates
#
#######################################################################

sudo dnf update -y
sudo dnf upgrade -y

#######################################################################
#
# Dark mode ofc...
#
#######################################################################

gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark

#######################################################################
#
# Curl installs
#
#######################################################################

curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

#######################################################################
#
# DNF Installs 
#
#######################################################################

sudo dnf install neovim gcc clang kitty gh flatpak wget -y

#######################################################################
#
# GNOME Software Installs
#
#######################################################################

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install com.bitwarden.desktop -y
flatpak install com.spotify.Client -y
flatpak install com.discordapp.Discord -y
flatpak install md.obsidian.Obsidian -y

#######################################################################
#
# GitHub Setup (creates ssh key)
#
#######################################################################

gh auth login
gh auth refresh -h github.com -s admin:ssh_signing_key
gh ssh-key add ~/.ssh/id_ed25519.pub --type signing

#######################################################################
#
# Add keys to agent and setup signing and github info
#
#######################################################################

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
git config --global gpg.format ssh
git config --global user.name regerj
git config --global user.email regerjacob@gmail.com
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgsign true

#######################################################################
#
# Docker setup
#
#######################################################################

sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

#######################################################################
#
# Clone config repo
#
#######################################################################

mkdir src
CONFIG_PATH=$HOME/src/config-files/
git clone https://github.com/regerj/config-files $CONFIG_PATH

#######################################################################
#
# Bash configs
#
#######################################################################

rm ~/.bash_profile
cp $CONFIG_PATH/.bash_profile $HOME
rm ~/.bashrc
cp $CONFIG_PATH/.bashrc $HOME

#######################################################################
#
# Setup custom install command
#
#######################################################################

chmod +x $CONFIG_PATH/bin/install-usr.sh
sudo $CONFIG_PATH/bin/install-usr.sh $CONFIG_PATH/bin/install-usr.sh

#######################################################################
#
# Setup custom docker commands
#
#######################################################################

# Remove all
chmod +x $CONFIG_PATH/bin/docker-rm-all.sh
sudo install-usr.sh $CONFIG_PATH/bin/docker-rm-all.sh

# Stop all
chmod +x $CONFIG_PATH/bin/docker-stop-all.sh
sudo install-usr.sh $CONFIG_PATH/bin/docker-stop-all.sh

#######################################################################
#
# Setup custom kitty
#
#######################################################################

rm -rf $HOME/.config/kitty/
cp -r $CONFIG_PATH/kitty/ $HOME/.config/

#######################################################################
#
# Setup neovim
#
#######################################################################

rm -rf ~/.config/nvim/
rm -rf ~/.local/share/nvim/
git clone git@github.com:regerj/neovim-config.git ~/.config/nvim

#######################################################################
#
# Setup fonts
#
#######################################################################

mkdir jetbrains
cd ./jetbrains
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip ./JetBrainsMono.zip
cd ..
sudo mkdir -p /usr/local/share/fonts/
sudo mv ./jetbrains/ /usr/local/share/fonts/jetbrains/
sudo fc-cache -v

#######################################################################
#
# Final notes
#
#######################################################################

echo "Completed Tasks: "
echo -e "\t\u2705 System update & upgrade"
echo -e "\t\u2705 Switched to dark mode"
echo -e "\t\u2705 Installed rust"
echo -e "\t\u2705 Installed neovim gcc clang kitty gh flatpak wget"
echo -e "\t\u2705 Installed Bitwarden, Spotify, Discord, Kitty"
echo -e "\t\u2705 Generated SSH key"
echo -e "\t\u2705 Added key to Github for signing and authentication"
echo -e "\t\u2705 Install docker"
echo -e "\t\u2705 Setup custom terminal commands"
echo -e "\t\u2705 Setup bash"
echo -e "\t\u2705 Setup neovim"
echo -e "\t\u2705 Setup kitty"
echo -e "\t\u2705 Install font"

echo "Remember to:"
echo -e "\t\u2705 Reboot device to finish any upgrades"
echo -e "\t\u2705 Sign into apps"
echo -e "\t\u2705 Install bitwarden browser extension"

read -p "Press ANY KEY to exit"
exit
