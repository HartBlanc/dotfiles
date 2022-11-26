#!/usr/bin/env sh
for f in ~/.dotfiles/linkables/* ; do ln -isv $f ~/.$(basename $f) ; done

ln -isv ~/.dotfiles/config/* ~/.config
