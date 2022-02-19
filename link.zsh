# Create symlinks for dotfiles that must be present in the home directory
# note the *(D) dotfile glob qualifier, dotfiles are not inlcuded by deafult
# if using bash use `shopt -s dotglob` instead
ln -sf ~/.dotfiles/linkables/*(D) ~

# Create symlinks for nvim files
ln -sf ~/.dotfiles/config/* ~/.config
