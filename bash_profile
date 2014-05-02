# vi command line editing
set -o vi

# aliases
[ -f "$HOME/.aliases" ] && source $HOME/.aliases

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
    touch $dest && cd $dest
  fi
}
export PROJ_ROOT=$HOME

# editor
export EDITOR='mate -w'

# completion
source /usr/share/git-core/git-completion.bash
source /usr/share/git-core/git-prompt.sh
for f in /usr/local/etc/bash_completion.d/*; do
  source $f
done

# git
alias gs="git status"
alias g=git
eval "$(hub alias -s)"

# prompt
export PS1='\u@\h \W$(__git_ps1)$ '

# ruby
export GEM_HOME="$HOME/.gem/ruby/2.0.0"

# PATH
PATH="/usr/local/share/npm/bin:$PATH"
PATH="$HOME/.gem/ruby/2.0.0/bin:$PATH"
# PATH="/usr/local/opt/ruby/bin:$PATH" # => switched back to system gemset
PATH="$PATH:~/src/anz/jenkins-tools/jenkins/CodeQualityScripts"
PATH="$PATH:~/src/anz/jenkins-tools/jenkins/oclint-0.7/bin"
PATH="$PATH:$HOME/bin"
export PATH

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# environment
for dotenv in $(ls $HOME/.*.env 2>/dev/null); do
  . $dotenv
done
