# PATH, Folders & Files
if [ ! -d ~/build ]; then mkdir ~/build ; chmod 700 ~/build ; fi
if [ ! -d ~/tmp ]; then mkdir ~/tmp ; chmod 700 ~/tmp ; fi
if [ ! -d ~/blog ]; then mkdir ~/blog ; chmod 700 ~/blog ; fi
if [ ! -f ~/.bash_history ]; then touch ~/.bash_history; fi
if [ ! -L ~/.bash_keys ]; then ln -s ~/connect/bash_keys ~/.bash_keys; fi

# ---- source ---- #
if [ -f /etc/bash.bashrc ];       then source /etc/bash.bashrc;         fi
source ~/.bash_keys;
source ~/.bash_functions;
source ~/bin/gitprompt.sh;
source ~/.bash_colors;
source ~/.bash_nonsense;

# Check for an interactive session
case $- in
    *i*) ;;
      *) return;;
esac

# ---- Exports ---- #
set -b
set -o notify
export ARCH="`uname -m`"
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="sudo*:encfs*:&:??:[ ]*:clear:exit:logout:wipe*:ls:ll:la:cd*:cat*:jrnl*:diary*"
export HISTTIMEFORMAT="[%Y-%m-%d - %H:%M:%S] "
export LANG="de_DE.UTF-8"
export TZ="Europe/Berlin"
export EDITOR="vim"
export BLOCKSIZE=K
export BROWSER="iceweasel"
export GPG_TTY="tty"
export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64/jre"
export PATH=$PATH:$JAVA_HOME/bin
export PATH=$PATH:/usr/local:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin:/usr/lib/wine/bin
export PATH=$(echo $PATH | awk -F: ' { for (i = 1; i <= NF; i++) arr[$i]; } END { for (i in arr) printf "%s:" , i; printf "\n"; } ')
export TERM=xterm-256color
export PAGER="less -e"
export LESS="-iMFXR"
export LESS_TERMCAP_mb=$'\E[01;34m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;31m'
export VIDEO_FORMAT="PAL"
export VISUAL="vim"
export MARKPATH=$HOME/.marks
shopt -s histappend histreedit histverify
shopt -s cdspell
shopt -s checkhash
shopt -s checkwinsize
shopt -s cmdhist
shopt -s extglob
shopt -s nocaseglob
shopt -s sourcepath
stty start undef
stty stop undef

# ---- bash completion ---- #
if [ -f /etc/bash_completion ];         then source /etc/bash_completion;         fi
if [ -f $HOME/.bash_complete ];         then source $HOME/.bash_complete;         fi

# ---- Aliases ---- #

# enable color support of ls and also add handy aliases
eval "`dircolors -b`"


# file and folder handlings
alias ls="ls -lA -F -h -X --group-directories-first --color=always"
alias la="ls -A"
alias l="ls -CF"
alias ll='ls -alF'
alias mv="mv -i"
alias cp="cp -iv"
alias dir="ls --color=auto --format=vertical"
alias vdir="ls --color=auto --format=long"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias dirsize="$HOME/bin/dirsize.sh"
alias rmdir="trash"
alias rm="trash"
alias clean="*rm -f "#"* "."*~ *~ *.bak *.dvi *.aux *.log*"
alias mkdir="mkdir -pv"
alias md5="md5sum -c"
alias count="wc -l"
alias patch="patch -p1 <"
alias repar="par2 r"

# Apt-get stuff
alias check="sudo apt-get check"
alias aptsource="sudo apt-get source"
alias apti="sudo apt-get install"
alias apta="sudo apt-add-repository"
alias aptu="sudo apt-get update"
alias aptr="sudo apt-get remove"
alias upgrade="sudo apt-get update && sudo apt-get upgrade && sudo apt-get clean"
alias dist-upgrade="sudo apt-get -qq update ; sudo apt-get dist-upgrade --assume-yes --force-yes"

# System
alias ipt="sudo iptables -L"
alias scan="sudo nmap localhost"
alias net="sudo netstat -ap"
alias tail="tail -n 40"

# LaTeX
alias lmk="latexmk -pdflatex=lualatex -pdf -pv -view=pdf"
alias pdflatex='pdflatex -interaction nonstopmode'
alias texdir="perl $HOME/bin/dirtree.pl"

# remote
alias ssh="ssh -X"

# Blog
alias mblog="sshfs ${DF_FTP_USER}@${DF_FTP_URL}:/ ~/blog ; cd ~/blog"
alias ublog=".. ; fusermount -u ~/blog"
alias blogpost="bb post"
alias postedit="bb edit"
alias postlist="bb list"
alias blogrebuild="bb rebuild"

# Download
alias ytmp3='youtube-dl -x --audio-format mp3 --audio-quality 0 -o "%(title)s.%(ext)s" --restrict-filenames'
alias ytogg='youtube-dl -x --audio-format vorbis --audio-quality 0 -o "%(title)s.%(ext)s" --restrict-filenames'
alias ytdl='youtube-dl --max-quality=MP4 -o "%(title)s.%(ext)s" --restrict-filenames'
alias wgeturlfromfile="wget -r -l1 -H -t1 -nd -N -np -erobots=off -i"        # -i file.txt
alias wget="wget -c"
alias wwwmirror2='wget -k -r -l ${2} ${1}'            # wwwmirror2 usage: wwwmirror2 [level] [site_url]
alias wwwmirror='wget -ErkK -np ${1}'
alias webdl='wget --random-wait -r -p -e robots=off -U mozilla "$1"'   # download an entire website
alias imgdl='wget --no-parent -H -nd -p -A".gif,.jpg,.jpeg,.png" "$1"'  # download all images from a site

# Apps
alias vi="vim"
alias boinc="open $HOME/BOINC/run_manager"
alias diary="jrnl"

# Web
alias DropUp="$HOME/bin/dropbox_uploader upload"
alias DropDown="$HOME/bin/dropbox_uploader download"

# Notes
alias note="note -n"
alias listnote="note -l"
alias rmnote="note -r"
alias notevers="note -v"

# Power
alias reboot="sudo shutdown -r now"
alias ShutUp="sudo shutdown -h now"
alias sleeptime="sudo shutdown -P -h "
alias screensaver="cmatrix"

# Webserver
alias wwwrestart="sudo service apache2 restart"
alias wwwreload="sudo service apache2 reload"
alias wwwstart="sudo service apache2 start"
alias wwwstop="sudo service apache2 stop"
alias dbrestart="sudo service mysql restart"
alias dbreload="sudo service mysql reload"
alias dbstart="sudo service mysql start"
alias dbstop="sudo service mysql stop"

# Handy directory aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# chmod and permissions commands
alias mx="chmod a+x"
alias 000="chmod 000"
alias 644="chmod 644"
alias 755="chmod 755"
alias perm='stat --printf "%a %n \n "' # requires a file name e.g. perm file

# ---- Stuff to Execute ---- #
# Source for is_screen(), retval(), retval2(), PROMPT_COMMAND, PS1, require_machine
# https://github.com/cfenollosa/dotfiles/blob/master/.bashrc

# Check if a value exists in an array
#
# $1 Needle
# $2 Haystack
# returns 0 if Needle is in Haystack, 1 else
# example in_array apple "orange apple banana"
in_array() {
	haystack=$2

	if [ -z "$1" ]; then return 1; fi

	for i in ${haystack[@]}; do

		[[ "$1" == "$i" ]] && return 0
	done

	return 1
}

# Test which machine we run on
require_machine() {
    return `in_array $HOSTNAME "$1"`
}

is_screen() {
  if [[ "$HOSTNAME" == "anniki" ]]; then
    screen="`ps -A | grep -i "screen$" | grep -v grep`"
  else
    screen="`ps axuf | grep "^$USER" | grep -i "screen$" | grep -v grep`"
  fi

  if [ "$screen" != "" ]; then echo "S "; fi
}

retval() {
  if [ $RET -ne 0 ]; then echo 31; else echo 33; fi
}

retval2() {
  if [ $RET -ne 0 ]; then
    # Align
    n_his=`echo $1 | wc -c`
    n_ret=`echo $RET | wc -c`
    spaces=""
    while [ $(( $n_his - $n_ret )) -gt 0 ]; do
      spaces="$spaces "
      n_ret=$(( $n_ret + 1 ))
    done

    echo "$spaces$RET";
  else
    echo $1
  fi
}
PROMPT_COMMAND='RET=$?; echo [$(date +"%H:%M:%S")] >> $HOME/.bash_history_enhanced'
PS1='\[\033[00;`retval`m\][`retval2 \!`] \[\033[00;37m\]\t \[\033[00;37m\]`is_screen`\[\033[00;`hostcolor`m\]\h\[\033[00;37m\]:\[\033[01;34m\]\w\[\033[1;95m\]`setGitPrompt`\[\033[00m\] \$ '

log_commands() {
    if [[ "$BASH_COMMAND" != "RET=\$?" ]] && [[ "$BASH_COMMAND" != 'j --add "$(pwd -P)"' ]] &&
        [[  "$BASH_COMMAND" != 'echo [$(date +"%H:%M:%S")] >> $HOME/.bash_history_enhanced' ]]; then
        d="`date +'%H:%M:%S'`"
        echo -n "[$d] $BASH_COMMAND " >> $HOME/.bash_history_enhanced
    fi
}

source $HOME/.bash_welcome;

# ---- Machine-specific ---- #
require_machine anniki
require_machine runa
require_machine ylva
require_machine amalia
require_machine annica

# Make 'source .bashrc' return 0
trap log_commands DEBUG
