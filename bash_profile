source .profile
eval "$(ssh-agent -s)"

[ -f .bash_profile.local ] && source .bash_profile.local
