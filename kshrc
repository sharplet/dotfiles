# use vi for command line editing
VISUAL=vi
# make long commands easier to work with
set -o multiline

# set the prompt
export PS1="$(hostname -s):\${PWD##*/} $(logname)\$ "

alias ls="ls -G"
