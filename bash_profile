# shellcheck disable=SC1090,SC1091
# vim: ft=sh

# shared configuration
[ -f "$HOME/.profile" ] && source "$HOME/.profile"

# completion
if [ -d "/Library/Developer/CommandLineTools" ]; then
  source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
fi

help() {
	bash -s -- "$@" <<-HELP
		output="\$(help -m "\$@")"

		if [ \$? != 0 ]; then
		  printf >&2 "\$output"
		  exit 1
		fi

		printf "\$output" | "\${PAGER:-less}"
	HELP
}

# prompt
prompt_command()
{
  PS1="$(exit_status_colors ▸)\h \W$(__git_ps1)$ "
}
export PROMPT_COMMAND=prompt_command
