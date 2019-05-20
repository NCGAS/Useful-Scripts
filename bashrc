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
    PS1="\[\033[0;95m\]Ca.\h.\D{%m%d%y:%H:%M}\[\033[0;96m\](\$(id -g -n))\[\033[0;95m\]:\[\033[0;91m\]\$(prettyPath)\[\033[0;92m\] $\[\033[0m\] "
fi

function munkill {
    if [[ -z "$1" ]]; then
	echo "No folder specified, not willing to blitz your current directory."
	exit 1
    elif [[ -f "$1" ]]; then
	echo "Removing file $1"
	munlink -- "$1"
    elif [[ -d "$1" ]]; then
	echo "Removing directory tree $1"
	find "$1" -type f -print0 | xargs --no-run-if-empty -0 -I{} munlink -- "{}"
	sleep 1
	find "$1" -type l -print0 | xargs --no-run-if-empty -0 -n 1 -I{} unlink -- "{}"
	sleep 1
	find "$1" -type d -print0 | sort -r -z | xargs --no-run-if-empty -0 -n 1 -I{} bash -c ' if [[ -e "{}" ]]; then rmdir -p -- "{}" && echo "removed {}"; fi '
	# sort -z or --files0-from=F
    fi
    echo "Finished munlinking."
}
