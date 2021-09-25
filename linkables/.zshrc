# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# The clang python binding searches for header files in /usr/include by default
# MacOS System Integrity Protection prevents the cration of /usr/include (even by root)
# updating CPATH tells the clang python binding where to find the C headers
export CPATH=`xcrun --show-sdk-path`/usr/include

# add the user base's binary directory to the path to allow binaries to be installed
# using `pip3 --user` (reduces risk of breaking system-wide packages)
export PATH=$PATH:$(python3 -m site --user-base)/bin

# source powerlevel10k theme after installing via brew
source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Zsh history search

## loads zsh functions which search history and move the cursor to the end of the line
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

## Up key searches backwards
bindkey "^[[A" history-beginning-search-backward-end
## Down key searches forwards
bindkey "^[[B" history-beginning-search-forward-end

# set default editor to vi
export EDITOR=vi

# replace ls with a more modern replacement (install with brew)
alias ls="exa --long --header --git"
