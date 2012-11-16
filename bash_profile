# use vi command line editing
set -o vi

# Mac OS X only
if [ "$(uname)" = "Darwin" ]; then
  export WEBSERV="/Library/WebServer"
  export DOCROOT="/Library/WebServer/Documents"
  export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
  export EDITOR="mate -w"
else
  export EDITOR="vim"
fi

# db2 environment
[ -f "$HOME/sqllib/db2profile" ] && source "$HOME/sqllib/db2profile"
[ -z "$LD_LIBRARY_PATH" -a -n "$IBM_DB_LIB" ] && export LD_LIBRARY_PATH=$IBM_DB_LIB

if [ -x "$(which brew 2>/dev/null)" ]; then
  export HOMEBREW_TEMP=/tmp
fi

# only if mate is installed locally (not rmate)
if [ ! -x "$(which rmate 2>/dev/null)" -a -x "$(which mate 2>/dev/null)" ]; then
  export LESSEDIT="mate -l %lm %f" # edit document in less by hitting 'v'
fi

# LaTeX stuff
if [ -d "/usr/texbin" ]; then
  PATH="$PATH:/usr/texbin"
fi
if [ -x "$(which bibtex 2>/dev/null)" ]; then
  BIBDIR=~/.bibfiles/
  if [[ $BIBINPUT ]]; then
  	BIBINPUT=$BIBINPUT:$BIBDIR
  else
  	BIBINPUT=$BIBDIR
  fi
  export BIBINPUT
  export BIBINPUTS=$BIBINPUT
fi

gd()
{
  ( # doing this in a subshell so we don't lose stdout
    exec &>/dev/null
    git ls-files -m -o --exclude-standard "$@" | xargs unix2dos
  )
}
gu()
{
  ( # doing this in a subshell so we don't lose stdout
    exec &>/dev/null
    git ls-files -m -o --exclude-standard "$@" | xargs dos2unix
  )
}
ga()
{
  gu "$@"
  git add "$@"
}

# Rails
if [ "$(ruby -v | awk '{print $1}')" = "jruby" ]; then
  NG_VAR=--ng
fi
export JRUBY_OPTS='--1.9 -Xlaunch.inproc=false'
in_rails_app()
{
  /usr/bin/env ruby /Users/adsharp/bin/in_rails_app.rb
}
rake_wrapper()
{
  if [ -x "bin/rake" ]; then
    JRUBY_OPTS="$JRUBY_OPTS --ng" bin/rake "$@"
  else
    JRUBY_OPTS="$JRUBY_OPTS --ng" /usr/bin/env rake "$@"
  fi
}

# mysql
if [ -x "$(which mysql 2>/dev/null)" ]; then
  PATH="$PATH:/usr/local/mysql/bin"
fi

PATH="/usr/local/bin:$PATH"
PATH="${HOME}/bin:$PATH"
export PATH=$PATH

# jruby optimisation
# export JAVA_OPTS="$JAVA_OPTS -d32"
alias ng="jruby --ng-server"
alias ngx="jruby --ng -S"
alias rake="JRUBY_OPTS=--ng rake"
alias bundle="JRUBY_OPTS=${NG_VAR} bundle"

# workaround for rake column width issue
export RAKE_COLUMNS=$(tput cols)

# import aliases
[ -f "${HOME}/.aliases" ] && . ${HOME}/.aliases

# rvm
. ${HOME}/.rvm/scripts/rvm

# source completion scripts
COMPLETION_FILES=$(ls /usr/local/etc/bash_completion.d/*{git,hub,subversion,tmux}*)
if [ -d "/usr/local/etc/bash_completion.d" ]; then
  for file in $COMPLETION_FILES; do
    source $file
  done
fi

# git prompt
export PS1='\u@\h \W$(__git_ps1 " (%s)")\$ '
# export GIT_PS1_SHOWDIRTYSTATE=1
# export GIT_PS1_SHOWUNTRACKEDFILES=1
# export GIT_PS1_SHOWSTASHSTATE=1

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
