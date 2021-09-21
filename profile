# vim: ft=sh

while read alias_args; do
  alias "$alias_args"
done <.aliases

EDITOR=vim
export EDITOR

MANPATH=/opt/local/share/man:/usr/local/share/man:"$MANPATH"
export MANPATH

[ -f .functions ] && source .functions
[ -f .profile.local ] && source .profile.local

PATH=~/bin:/opt/local/bin:/opt/local/sbin:"$PATH"
export PATH
