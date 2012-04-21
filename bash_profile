# use vi command line editing
set -o vi

# import aliases
[ -f "${HOME}/.aliases" ] && . ~/.aliases

# Mac OS X only
if [ "$(uname)" = "Darwin" ]; then
  export WEBSERV="/Library/WebServer"
  export DOCROOT="/Library/WebServer/Documents"
  export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
  export EDITOR="mate -wl1"
else
  export EDITOR="vim"
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
sed_alternatives=(gsed sed)
for app in ${sed_alternatives[*]}; do
    if [ -n "$(which "${app}" 2>/dev/null)" ]; then
        sed_app="${app}"
        break
    fi
done
git_stats ()
{
    in_git_repo || return;
    echo -n "$(git branch -v | ${sed_app} -nr '/^\* \S+\s+[0-9a-fA-F]+ \[(ahead|behind)/{s,[^[]*\[([^]]*)\].*,\1,g;s,behind,-,g;s,ahead,+,g;s,[ \,],,g;p}')"
}
git_has_local_changes ()
{
    in_git_repo || return;
    git diff --no-ext-diff --quiet --exit-code 2> /dev/null || echo -n "*"
}
export PS1='\u@\h \W\[\033[00;36m\]$(git_branch)\[\033[00;31m\]$(git_stats)\[\033[01;35m\]$(git_has_local_changes)\[\033[00m\]\$ '

# Rails
in_rails_app()
{
  /usr/bin/env ruby /Users/adsharp/bin/in_rails_app.rb
}
rake_wrapper()
{
  if [ in_rails_app ]; then
    bundle exec rake "$@"
  else
    rake "$@"
  fi
}

# mysql
if [ -x "$(which mysql 2>/dev/null)" ]; then
  PATH="$PATH:/usr/local/mysql/bin"
fi

PATH="~/bin:$PATH"
PATH="/usr/local/bin:$PATH"
export PATH=$PATH
