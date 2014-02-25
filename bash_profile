# vi command line editing
set -o vi

# git environment
git_env="$HOME/.git.env"
if [ -f "$git_env" ]; then
  . "$git_env"
fi
unset git_env

# aliases
alias ls="ls -G"
alias ll="ls -l"
alias stupidxcode='rm -rf ~/Library/Developer/Xcode/DerivedData'
alias xc=xcodebuild
alias xcode4="sudo xcode-select --switch /Applications/Xcode-4.app"
alias xcode5="sudo xcode-select --switch /Applications/Xcode.app"
alias podl="pod install --no-repo-update"
alias podu="pod update --no-repo-update"
alias pod20="pod _0.20.2_"
alias pod24="pod _0.24.0_"
# alias vim=mvim

alias rt="rake test"

alias reload="exec bash --login"

# present a project selector and change to the selected directory
function go()
{
  local base=${1:-$PROJ_ROOT}
  if [ -z "$base" ]; then
    echo >&2 "error: PROJ_ROOT must be set or a base directory passed as the first argument"
    return 1
  fi

  # Arguments to ls:
  #  -t  sort by modification time
  #  -F  directories are formatted with a trailing '/'
  #  -H  follow symlinks, e.g., ls -H /tmp (symlinked to /private/tmp) should
  #      list directory contents, not the link itself
  local dir=$(ls -tFH $base | grep '/$' | sed 's/\/$//' | selecta)

  if [ -n "$dir" ]; then
    local dest=$base/$dir
    touch $dest && cd $dest # && clear
  fi
}
export PROJ_ROOT=~/src/anz

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

export OMSCRIPTS="~/src/omscripts"
export omscripts=$OMSCRIPTS

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
