# use vi command line editing
set -o vi

# Mac OS X only
if [ "$(uname)" = "Darwin" ]; then
  export WEBSERV="/Library/WebServer"
  export DOCROOT="/Library/WebServer/Documents"
  export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
fi

# only if mate is installed locally (not rmate)
if [ ! -x "$(which rmate)" -a -x "$(which mate)" ]; then
  export LESSEDIT="mate -l %lm %f" # edit document in less by hitting 'v'
fi

# LaTeX stuff
if [ -d "/usr/texbin" ]; then
  PATH="$PATH:/usr/texbin"
fi
if [ -x "$(which bibtex)" ]; then
  BIBDIR=~/.bibfiles/
  if [[ $BIBINPUT ]]; then
  	BIBINPUT=$BIBINPUT:$BIBDIR
  else
  	BIBINPUT=$BIBDIR
  fi
  export BIBINPUT
  export BIBINPUTS=$BIBINPUT
fi

# mysql
if [ -x "$(which mysql)" ]; then
  PATH="$PATH:/usr/local/mysql/bin"
fi

PATH="$PATH:~/bin"
export PATH=$PATH

. ~/.dotfiles/.bash_extra
