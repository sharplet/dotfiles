# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/adamsharp/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

[ -f "$HOME/.profile" ] && source "$HOME/.profile"

setopt promptsubst
PROMPT='$(exit_status_colors ▸)%m %2~$(__git_ps1)%% '

# batch file renaming
autoload -U zmv

# enable reverse history search in vi mode
bindkey "^R" history-incremental-search-backward
