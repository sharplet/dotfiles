# vi command line editing
set -o vi

# functions
[ -f "$HOME/.functions" ] && source $HOME/.functions

[ -f "$HOME/.profile" ] && source $HOME/.profile

# completion
if [ -d "/Library/Developer/CommandLineTools" ]; then
  source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
fi

if [ -d "/usr/local/etc/bash_completion.d" ]; then
  source /usr/local/etc/bash_completion.d/git-flow-completion.bash
fi

# prompt
export PS1='\h \W$(__git_ps1)$ '

# rbenv
if which rbenv >/dev/null; then
  eval "$(rbenv init -)"
fi

# iTerm2
source $HOME/.iterm/shell_integration.bash
