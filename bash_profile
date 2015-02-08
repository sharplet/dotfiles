# vi command line editing
set -o vi

# aliases
[ -f "$HOME/.aliases" ] && source $HOME/.aliases

# functions
[ -f "$HOME/.functions" ] && source $HOME/.functions

# present a project selector and change to the selected directory
function go()
{
  local base=${1:-$PROJ_ROOT}
  if [ -z "$base" ]; then
    echo >&2 "error: PROJ_ROOT must be set or a base directory passed as the first argument"
    return 1
  fi

  echo >&2 "(in $base)"
  local findopts="-type d -maxdepth 4"
  local excludes='.cocoapods|.vim/bundle'

  # find -H -> follow symlinks
  local dir=$(find -H $base $findopts -path '*/.git' 2>/dev/null | sed 's,/.git$,,' | grep -vE "$excludes" | xargs -I{} stat -f '%m %N' '{}' | sort -nr | sed -E 's,^[0-9]+ ,,' | sed -E "s,^$base/(src/)?,," | sed 's,/.git$,,' | selecta)

  if [ -n "$dir" ]; then
    local dest=$base/$dir
    if [ ! -d "$dest" ]; then
      dest=$base/src/$dir
    fi
    touch "$dest" && cd "$dest"
  fi
}
export PROJ_ROOT=$HOME

# editor
export EDITOR=vim

# completion
source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-flow-completion.bash

# git
alias gs="git status"
alias g=git
eval "$(hub alias -s)"

# ruby
export GEM_HOME=$HOME/.gems/2.0.0
export GEM_PATH=$GEM_HOME

# prompt
export PS1='\h \W$(__git_ps1)$ '

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# PATH
export PATH="$PATH:/usr/local/share/npm/bin"
export PATH=".git/safe/../../bin:$PATH"
export PATH="$HOME/bin:$PATH"

# environment
for dotenv in $(ls $HOME/.*.env 2>/dev/null); do
  . $dotenv
done

# iTerm2
source $HOME/.iterm/shell_integration.bash
