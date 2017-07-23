# shellcheck disable=SC1090,SC1091
# vim: ft=sh

[ -f "$HOME/.functions" ] && source "$HOME/.functions"
[ -f "$HOME/.profile" ] && source "$HOME/.profile"

# completion
if [ -d "/Library/Developer/CommandLineTools" ]; then
  source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
fi

# prompt
prompt_command()
{
  PS1="$(exit_status_colors ▸)\h \W$(__git_ps1)$ "
}
export PROMPT_COMMAND=prompt_command

# rbenv
if which rbenv >/dev/null; then
  eval "$(rbenv init -)"
fi
