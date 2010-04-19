# use vi command line editing
set -o vi

if [[ $LOGGED_IN != 'truer' ]]; then
  . ~/.profile
fi

export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
alias ls="ls -G"
alias la="ls -a"
alias ll="ls -l"
alias ping="ping -c 4"
alias srv="cd $DOCROOT"

alias lmake=latexmake
alias gvim="open -a MacVim"

. ~/.dotfiles/.bash_extra
