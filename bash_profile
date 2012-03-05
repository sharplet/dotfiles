# use vi command line editing
set -o vi

if [ "$LOGGED_IN" != 'truer' ]; then
  . ~/.profile
fi

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

# Git
in_git_repo ()
{
    git rev-parse --show-cdup >&/dev/null || return 1;
    git branch | grep -q '* (no branch)' && return 1;
    [ -z "${PWD%%*/.git*}" ] && return 1;
    return 0
}
git_branch ()
{
    in_git_repo || return;
    echo -n " $(git symbolic-ref HEAD | sed 's,.*/\([^/]*\)$,\1,g')"
}
git_stats ()
{
    in_git_repo || return;
    echo -n "$(git branch -v | /usr/local/bin/gsed -nr '/^\* \S+\s+[0-9a-fA-F]+ \[(ahead|behind)/{s,[^[]*\[([^]]*)\].*,\1,g;s,behind,-,g;s,ahead,+,g;s,[ \,],,g;p}')"
}
git_has_local_changes ()
{
    in_git_repo || return;
    git diff --no-ext-diff --quiet --exit-code 2> /dev/null || echo -n "*"
}
export PS1="\u@\h \W\[\033[00;36m\]$(git_branch)\[\033[00;31m\]$(git_stats)\[\033[01;35m\]$(git_has_local_changes)\[\033[00m\]\$ "

# mysql
if [ -x "$(which mysql)" ]; then
  PATH="$PATH:/usr/local/mysql/bin"
fi

PATH="$PATH:~/bin"
export PATH=$PATH
