# use vi command line editing
set -o vi

export WEBSERV="/Library/WebServer"
export DOCROOT="/Library/WebServer/Documents"
export LESSEDIT="mate -l %lm %f" # edit document in less by hitting 'v'
PATH="$PATH:/usr/local/mysql/bin"
PATH="$PATH:/usr/local/depot_tools"
PATH="$PATH:/usr/texbin"
PATH="$PATH:/opt/local/bin"
PATH="$PATH:/opt/local/sbin"
export PATH=$PATH

BIBDIR=~/.bibfiles/
if [[ $BIBINPUT ]]; then
	BIBINPUT=$BIBINPUT:$BIBDIR
else
	BIBINPUT=$BIBDIR
fi
export BIBINPUT
export BIBINPUTS=$BIBINPUT

# mysql
alias mysqlr="mysql -u root -p"

# git
alias gi="git init"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit"
alias gs="git status"
alias gsh="git show"
alias gl="git log"

export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
alias ls="ls -G"
alias la="ls -a"
alias ll="ls -l"
alias ping="ping -c 4"
alias srv="cd $DOCROOT"

. ~/.dotfiles/.bash_extra
