[ -f "$HOME/.profile.private" ] && source $HOME/.profile.private

[ -f "$HOME/.aliases" ] && source $HOME/.aliases

if [ -d "/Library/Developer/CommandLineTools" ]; then
  source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
fi

export EDITOR=vim
export PROJ_ROOT=$HOME

# PATH
export PATH="$PATH:/usr/local/heroku/bin"
export PATH="$PATH:/usr/local/share/npm/bin"
export PATH=".git/safe/../../bin:$PATH"
export PATH="$HOME/.gem/bin:$PATH"
export PATH="$HOME/bin:$PATH"
