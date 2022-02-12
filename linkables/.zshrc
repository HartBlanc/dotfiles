# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# The clang python binding searches for header files in /usr/include by default.
# MacOS System Integrity Protection prevents the cration of /usr/include (even by root).
# Updating CPATH tells the clang python binding where to find the C headers.
# You need to have the command line tools installed for this to work.
# They will not be pressent after an OS upgrade. Use xcode-select --install to install them.
if whence xcrun >/dev/null; then
    export CPATH=`xcrun --show-sdk-path`/usr/include
fi

# add the user base's binary directory to the path to allow binaries to be installed
# using `pip3 --user` (reduces risk of breaking system-wide packages)
export PATH=$PATH:$(python3 -m site --user-base)/bin

# source extensions
if whence brew >/dev/null; then
    source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# set default editor to neovim (used for e.g. commit messages)
export EDITOR=nvim
# set the shell to zsh
export SHELL=$(which zsh)

## AUTOCOMPLETION

# the description for options that are not described by the completion functions
zstyle ':completion:*' auto-description 'specify: %d'
# the completion functions to use
zstyle ':completion:*' completer _expand _complete _correct _approximate
# show what type we are completing (e.g. command vs file)
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' verbose true

# Completion options can be grouped by type (displayed in different lists).
# If the empty string is given  all matches of different types will be displayed seperatley.
zstyle ':completion:*' group-name ''

# select from a menu if there are more than 2 options
zstyle ':completion:*' menu select=2
# only use menu if the options don't fit on the screen
zstyle ':completion:*' menu select=long

# set colors of automcompletion options based on the dircolors command if available
# otherwise use the BSD (macOS) alternative
if whence dircolors >/dev/null; then
    eval "$(dircolors -b)"
else
    eval "$(gdircolors -b)"
fi
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''

# case insensitive completion matching
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}'

# modified plz completion script to not add spaces after path completions
_plz_complete_zsh() {
    local args=("${words[@]:1:$CURRENT}")
    local IFS=$'\n'
    local completions=($(GO_FLAGS_COMPLETION=1 ${words[1]} -p -v 0 --noupdate "${args[@]}"))
    for completion in $completions; do
        compadd -S '' $completion
    done
}


# activate zsh auto-completions
autoload -Uz compinit
compinit

compdef _plz_complete_zsh plz

## HISTORY

setopt histignorealldups sharehistory

export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=~/.zsh_history

# loads zsh functions which search history and move the cursor to the end of the line
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# ALIASES

# replace ls with a more modern replacement (install with brew)
alias ls="exa --classify "
alias la="exa --classify --all"
alias ll="exa --header --classify --all --long"

# use neovim instead of vim
alias vi=nvim

# open a buffer in neovim for each file with a conflict
alias conflicts='git diff --name-only --diff-filter=U | sed "s@^@$(git rev-parse --show-toplevel)/@" | xargs nvim'

# FZF

# use ripgrep for fuzzy finding
export FZF_DEFAULT_COMMAND='rg --files --hidden'

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# URL ESCAPING
autoload -U url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# KEY BINDINGS

# Set terminal keybindings to emacs (zsh may assume you want vim bindings if you set your editor to vim)
# This must be done before other keybindings otherwise other bindings will be overwritten in tmux
bindkey -e

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Up key searches backwards
bindkey "$key[Up]" history-beginning-search-backward-end
# Down key searches forwards
bindkey "$key[Down]" history-beginning-search-forward-end
