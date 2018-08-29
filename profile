# shellcheck disable=SC1090,1091
# vim: ft=sh

command_line_tools=/Library/Developer/CommandLineTools
git_core=/usr/share/git-core

[ -f "$HOME/.profile.private" ] && source "$HOME/.profile.private"

[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"
[ -f "$HOME/.functions" ] && source "$HOME/.functions"
[ -f "$HOME/.git-completion" ] && source "$HOME/.git-completion"

if [ -d "$git_core" ]; then
  source "$git_core/contrib/completion/git-prompt.sh"
elif [ -d "$command_line_tools" ]; then
  source "$command_line_tools$git_core/git-prompt.sh"
fi

export EDITOR=vim
export PROJ_ROOT=$HOME

# gpg
export GPG_TTY=$(tty)

if command_exists rbenv; then eval "$(rbenv init -)"; fi
if command_exists swiftenv; then eval "$(swiftenv init -)"; fi

# PATH
export PATH="$PATH:/usr/local/heroku/bin"
export PATH="$PATH:/usr/local/share/npm/bin"
export PATH=".git/safe/../../bin:$PATH"
export PATH="$HOME/.gem/bin:$PATH"
export PATH="$HOME/bin:$PATH"
