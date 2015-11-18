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
PROMPT='%n@%m %2~$(__git_ps1)%% '
