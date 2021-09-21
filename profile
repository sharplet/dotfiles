# vim: ft=sh

EDITOR=vim
export EDITOR

MANPATH=/opt/local/share/man:/usr/local/share/man:"$MANPATH"
export MANPATH

source .aliases
source .functions
[ -f .profile.local ] && source .profile.local

PATH=~/bin:/opt/local/bin:/opt/local/sbin:"$PATH"
export PATH
