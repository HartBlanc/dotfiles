# Install Apple's Command Line Tools, which are prerequisites for Git and Homebrew
xcode-select --install

# Clone repo into new hidden directory
git clone https://github.com/HartBlanc/dotfiles.git ~/.dotfiles

# Create symlinks for dotfiles that must be present in the home directory
# note the *(D) dotfile glob qualifier, dotfiles are not inlcuded by deafult
# if using bash use `shopt -s dotglob` instead
ln -s ~/.dotfiles/linkables/*(D) ~

# Create symlinks for nvim files
ln -s ~/.dotfiles/nvim/* ~/.config/nvim

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle --file=~/.dotfiles/Brewfile
