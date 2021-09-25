# Install Apple's Command Line Tools, which are prerequisites for Git and Homebrew
xcode-select --install

# Clone repo into new hidden directory
git clone https://GIT_URL ~/.dotfiles

cd ~/.dotfiles

# Create symlinks for dotfiles that must be present in the home directory
ln -s linkables/* ~

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle
