# vim: ft=sh
#
# WARNING: This file is sourced by install.sh, so it should avoid making
# assumptions. For example, $PWD may be ~/.dotfiles instead of ~.

sourcerc() {
  name="$1"
  if [ -f ".$name" ]; then
    source ".$name"
  else
    source "${name}"
  fi
}

EDITOR=vim
export EDITOR

GIT_CORE=/Library/Developer/CommandLineTools/usr/share/git-core

MANPATH=/opt/local/share/man:/usr/local/share/man:"$MANPATH"
export MANPATH

sourcerc aliases
sourcerc functions
[ -f .profile.local ] && source .profile.local

[ -d "$GIT_CORE" ] && source "$GIT_CORE"/git-prompt.sh

PATH=~/bin:/opt/local/bin:/opt/local/sbin:"$PATH"
export PATH

unset -f sourcerc
