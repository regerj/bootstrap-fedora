# Basics
sudo dnf update
sudo dnf upgrade

# Custom curl installs
# Rust
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

# GNOME Software Installs
flatpak install bitwarden
flatpak install spotify
flatpak install discord
flatpak install obsidian

# DNF Installs
sudo dnf install neovim gcc clang kitty gh

# Setup gh
gh auth login
gh auth refresh -h github.com -s admin:ssh_signing_key
gh ssh-key add ~/.ssh/id_ed25519.pub --type signing

# Setup github
# SSH keys
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
git config --global gpg.format ssh
git config --global user.name regerj
git config --global user.email regerjacob@gmail.com
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgsign true

# Setup bash
rm ~/.bash_profile
wget https://raw.githubusercontent.com/regerj/config-files/master/.bash_profile --directory-prefix=$HOME/
rm ~/.bashrc
wget https://raw.githubusercontent.com/regerj/config-files/master/.bashrc --directory-prefix=$HOME/

# Setup nvim
rm -rf ~/.config/nvim/
rm -rf ~/.local/share/nvim/
git clone git@github.com:regerj/neovim-config.git ~/.config/nvim

# Fonts
mkdir jetbrains
cd ./jetbrains
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip ./JetBrainsMono.zip
cd ..
sudo mkdir -p /usr/local/share/fonts/
sudo mv ./jetbrains/ /usr/local/share/fonts/jetbrains/
sudo fc-cache -v

# Extra notes
echo "Remember to:"
echo -e "\t\u2705 Set dark mode"
echo -e "\t\u2705 Reboot device"
echo -e "\t\u2705 Restart terminal"
echo -e "\t\u2705 Sign into apps"
echo -e "\t\u2705 Install bitwarden browser extension"
