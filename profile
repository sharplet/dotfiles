MANPATH=/opt/local/share/man:/usr/local/share/man:"$MANPATH"
export MANPATH

[ -f .profile.local ] && source .profile.local

PATH=~/bin:/opt/local/bin:/opt/local/sbin:"$PATH"
export PATH
