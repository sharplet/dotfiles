[ -f "$HOME/.profile.private" ] && source $HOME/.profile.private

[ -f "$HOME/.aliases" ] && source $HOME/.aliases

if [ -d "/Library/Developer/CommandLineTools" ]; then
  source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
fi
