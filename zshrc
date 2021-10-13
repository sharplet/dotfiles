pushd -q "$HOME"
source .profile
popd -q

# enable online help
unalias run-help
autoload run-help
alias help=run-help
HELPDIR=/usr/share/zsh/5.8/help

# Vi command line editing
bindkey -v

# Enable reverse history search in Vi mode
bindkey "^R" history-incremental-search-backward

# Supports Git completion: https://stackoverflow.com/a/28035917
[ -d "$GIT_CORE" ] && zstyle ':completion:*:*:git:*' script "$GIT_CORE"/git-completion.bash
fpath=(~/.zsh/functions $fpath)
autoload -Uz compinit && compinit

# Homebrew additions
fpath+=(/opt/homebrew/share/zsh/site-functions)

# Enable shell functions in prompt
setopt PROMPT_SUBST
PROMPT="%n@%m %2~\$(__git_ps1)%% "
