# vim: ft=sh
#
# WARNING: This file is sourced by install.sh, so it should avoid making
# assumptions. For example, $PWD may be ~/.dotfiles instead of ~.

sourcerc() {
  name="$1"
  if [ -f ".$name" ]; then
    source ".$name"
  elif [ -f "$name" ]; then
    source "$name"
  fi
}

EDITOR=vim
export EDITOR

GIT_CORE=/Library/Developer/CommandLineTools/usr/share/git-core

HOMEBREW_CASK_OPTS="--appdir=~/Applications"
export HOMEBREW_CASK_OPTS

MANPATH=/opt/local/share/man:/usr/local/share/man:"$MANPATH"
export MANPATH

sourcerc aliases
sourcerc functions
[ -f .profile.local ] && source .profile.local

[ -d "$GIT_CORE" ] && source "$GIT_CORE"/git-prompt.sh

newpath=~/bin:/opt/local/bin:/opt/local/sbin
[ "$(arch)" = arm64 ] && newpath="$newpath:/opt/homebrew/bin"
[ "$(arch)" = i386 ] && newpath="$newpath:/opt/brew/bin"
PATH="$newpath:$PATH"
unset newpath
export PATH

unset -f sourcerc
