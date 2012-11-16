export LOGGED_IN=true
export WEBSERV="/Library/WebServer"
export DOCROOT="/Library/WebServer/Documents"
export LESSEDIT="mate -l %lm %f" # edit document in less by hitting 'v'
PATH="/Users/adsharp/bin:/usr/texbin:/usr/local/mysql/bin:/opt/local/bin:/opt/local/sbin:$PATH"
export PATH=$PATH

# setup bibfiles directory for centralised referencing
BIBDIR=~/.bibfiles/
if [[ -n $BIBINPUT ]]; then
	BIBINPUT=$BIBINPUT:$BIBDIR
else
	BIBINPUT=$BIBDIR
fi
export BIBINPUT
export BIBINPUTS=$BIBINPUT

# aliases
alias lmake=latexmake
alias mysqlr="mysql -u root -p"
alias gi="git init"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit"
alias gs="git status"
alias gsh="git show"
alias gl="git log"

# The following three lines have been added by IBM DB2 instance utilities.
if [ -f /Users/adsharp/sqllib/db2profile ]; then
    . /Users/adsharp/sqllib/db2profile
fi
