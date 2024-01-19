#######################################################################
#
# Basic updates
#
#######################################################################
sudo dnf update -y
sudo dnf upgrade -y

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
flatpak install bitwarden
flatpak install spotify
flatpak install discord
flatpak install obsidian

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
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#######################################################################
#
# Bash configs
#
#######################################################################
rm ~/.bash_profile
wget https://raw.githubusercontent.com/regerj/config-files/master/.bash_profile --directory-prefix=$HOME/
rm ~/.bashrc
wget https://raw.githubusercontent.com/regerj/config-files/master/.bashrc --directory-prefix=$HOME/

#######################################################################
#
# Setup custom install command
#
#######################################################################

wget https://raw.githubusercontent.com/regerj/config-files/master/bin/install-usr.sh --directory-prefix=$HOME/
~/install-usr.sh ~/install-usr.sh
rm ~/install-usr.sh
exec bash

#######################################################################
#
# Setup custom docker commands
#
#######################################################################

# Remove all
wget https://raw.githubusercontent.com/regerj/config-files/master/bin/docker-rm-all.sh --directory-prefix=$HOME/
install-usr.sh ~/docker-rm-all.sh
rm ~/docker-rm-all.sh

# Stop all
wget https://raw.githubusercontent.com/regerj/config-files/master/bin/docker-stop-all.sh --directory-prefix=$HOME/
install-usr.sh ~/docker-stop-all.sh
rm ~/docker-stop-all.sh

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
echo "Remember to:"
echo -e "\t\u2705 Set dark mode"
echo -e "\t\u2705 Reboot device"
echo -e "\t\u2705 Restart terminal"
echo -e "\t\u2705 Sign into apps"
echo -e "\t\u2705 Install bitwarden browser extension"
