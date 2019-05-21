# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias ncgas='cd /N/dc2/projects/ncgas'
alias la='ls -lah'
alias cd..='cd ..'
alias ..='cd ..'
alias cd...='cd ../..'
alias ...='cd ../..'
alias l='ls'
alias s='ls'
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'
alias untar='tar -xzvf'
alias h='history | grep '
alias h8tr='htar -cv -Hverify=paranoid -f '
alias du2='du -cha --max-depth 2 2>/dev/null | sort -h'
umask 003
export HISTTIMEFORMAT="%m-%d-%y:%H:%M "

function prettyPath {
mypwd=$(pwd -P)
prettynu="${mypwd/#\/N\/u\/${USER}\/Carbonate/~}"
echo "$prettynu"
}

if [ "$PS1" ]; then

    case $TERM in
        xterm*)
            PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: $(prettyPath)\007"'
            ;;
        *)
            ;;
    esac
    if [ -n "$SINGULARITY_CONTAINER" ]; then
        #echo "if sing cont: $SINGULARITY_CONTAINER"
        PS1="\[\033[0;95m\]Ca.\h.\D{%m%d%y:%H:%M}\[\033[0;96m\](~\${SINGULARITY_CONTAINER}~)\[\033[0;95m\]:\[\033[0;91m\]\$(prettyPath)\[\033[0;92m\] $\[\033[0m\] "
    else
        #echo "else sing cont: $SINGULARITY_CONTAINER"
        PS1="\[\033[0;95m\]Ca.\h.\D{%m%d%y:%H:%M}\[\033[0;96m\](\$(id -g -n))\[\033[0;95m\]:\[\033[0;91m\]\$(prettyPath)\[\033[0;92m\] $\[\033[0m\] "
    fi
fi
