sudo apt get update
sudo apt get upgrade

# required for appimages
sudo apt install fuse

# required for sumneko language server and also for general decompressing
sudo apt install unzip
# required for some neovim lsp lanaguage servers
sudo apt install npm

# gcc toolchain so we can compile rust binaries
sudo apt install build-essential

# required to link dotfiles in and just so we have the shell...
sudo apt install zsh

# install latest version of tmux as an appimage
curl -s https://api.github.com/repos/nelsonenzo/tmux-appimage/releases/latest \
| grep "browser_download_url.*appimage" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi - \
&& chmod u+x tmux.appimage \
&& mv tmux.appimage /usr/local/bin/tmux

# install tmux plugin manager (you'll need to prefix-I manually to install the plugins)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install cargo
curl https://sh.rustup.rs -sSf | sh

# install rust binaries to $HOME/.cargo/bin
cargo install exa fd-find bat ripgrep sd git-delta stylua

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# install neovim
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage \
&& chmod u+x nvim.appimage \
&& sudo mv nvim.appimage /usr/local/bin/nvim

# install starship prompt
curl -sS https://starship.rs/install.sh | sh

zsh ~/.dotfiles/link.zsh
chsh -s $(which zsh)
