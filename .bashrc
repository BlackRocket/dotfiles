# PATH, Folders & Files
if [ ! -d "${HOME}/build" ]; then mkdir ${HOME}/build ; chmod 700 ${HOME}/build ; fi
if [ ! -d "${HOME}/tmp" ]; then mkdir ${HOME}/tmp ; chmod 700 ${HOME}/tmp ; fi
if [ ! -d "${HOME}/blog" ]; then mkdir ${HOME}/blog ; chmod 700 ${HOME}/blog ; fi
if [ ! -f $HOME/.bash_history ]; then touch $HOME/.bash_history; fi
if [ ! -L ~/.bash_keys ]; then ln -s ~/connect/bash_keys ~/.bash_keys; fi

# ---- source ---- #
if [ -f /etc/bash.bashrc ];       then source /etc/bash.bashrc;         fi
source ~/.bash_functions;
source ~/bin/gitprompt.sh;
source ~/.bash_keys;
source ~/.bash_colors;
source ~/.bash_nonsense;

# Check for an interactive session
[ -z "$PS1" ] && return
if [[ $- != *i* ]] ; then return; fi

# PATH, Folders & Files
if [ ! -d ~/build ]; then mkdir ~/build ; chmod 700 ~/build ; fi
if [ ! -d ~/tmp ]; then mkdir ~/tmp ; chmod 700 ~/tmp ; fi
if [ ! -d ~/blog ]; then mkdir ~/blog ; chmod 700 ~/blog ; fi
if [ ! -f ~/.bash_history ]; then touch ~/.bash_history; fi
if [ ! -L ~/.bash_keys ]; then ln -s ~/connect/bash_keys ~/.bash_keys; fi

# ---- Exports ---- #
set -b
set -o notify
export ARCH="`uname -m`"
export HISTCONTROL=ignoreboth:erasedups   
export HISTIGNORE="sudo*:encfs*:&:??:[ ]*:clear:exit:logout:wipe*:ls:ll:la:cd*:cat*:calc*"
export HISTTIMEFORMAT="[%Y-%m-%d - %H:%M:%S] "
export LANG="de_DE.UTF-8"
export TZ="Europe/Berlin"
export EDITOR="vim"
export BLOCKSIZE=K        
export BROWSER="firefox"
export GPG_TTY="tty"
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

# bash tipps
alias btipps="$HOME/bin/btipps.sh"

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
alias rbs="$HOME/bin/rbs.sh"
alias rlc="$HOME/bin/rlc.sh"
alias ruc="$HOME/bin/ruc.sh"
alias ren="$HOME/bin/ren.sh"
alias mvg="$HOME/bin/mvg.sh"
alias cpg="$HOME/bin/cpg.sh"
alias unpack="$HOME/bin/unpack.sh"
alias compress="$HOME/bin/pack.sh"
alias splitrar="$HOME/splitrar.sh"
alias rename="$HOME/bin/chnames.sh"
alias rename2="$HOME/bin/rename.sh"
alias umlaute="$HOME/bin/umlaute.pl"
alias md5="/usr/bin/md5sum -c"
alias count="wc -l"
alias patch="patch -p1 <"
alias repar="par2 r"
alias nas="$HOME/bin/mountnas.sh"

# Apt-get stuff     
alias check="sudo apt-get check"
alias aptsource="sudo apt-get source"
alias apti="sudo apt-get install"
alias apta="sudo apt-add-repository"
alias aptu="sudo apt-get update"
alias upchk="$HOME/bin/upchk.sh"
alias upgrade="sudo apt-get update && sudo apt-get upgrade && sudo apt-get clean"
alias dist-upgrade="sudo apt-get -qq update ; sudo apt-get dist-upgrade --assume-yes --force-yes"

# System
alias ipt="sudo iptables -L"
alias scan="sudo nmap localhost"
alias net="sudo netstat -ap" 
alias tail="tail -n 40"
alias sysinfo="sudo $HOME/bin/sysinfo.sh"
alias sysinfo2="$HOME/bin/sysinfo2.sh"
alias settime="sudo $HOME/bin/time.sh"
alias showmem="$HOME/bin/showmem.sh"
alias showtty="$HOME/bin/showtty.sh"
alias showup="$HOME/bin/showuptime.sh"
alias ii="$HOME/bin/ii.sh"
alias metabackup="$HOME/bin/metabackup.sh"
alias netinfo="$HOME/bin/netinfo.sh"
alias cleanup="$HOME/bin/cleanup.sh"
alias cpuload="$HOME/bin/cpuload.sh"
alias pskill="$HOME/bin/pskill.sh"

# LaTeX
alias lmk="latexmk -pdflatex=lualatex -pdf -pv -view=pdf"
alias pdflatex='pdflatex -interaction nonstopmode'
alias texdir="perl $HOME/bin/dirtree.pl"

# remote
#alias ssh="ssh -X"

# Blog
alias mblog="sshfs ${DF_FTP_USER}@${DF_FTP_URL}:/ /home/blackrocket/blog ; cd /home/blackrocket/blog"
alias ublog=".. ; fusermount -u /home/blackrocket/blog"
alias blogpost="$HOME/bin/bb.sh post"
alias postedit="$HOME/bin/bb.sh edit"
alias postlist="$HOME/bin/bb.sh list"
alias blogrebuild="$HOME/bin/bb.sh rebuild"

# Download
alias ytmp3='youtube-dl -x --audio-format mp3 --audio-quality 0 -o "%(title)s.%(ext)s" --restrict-filenames'
alias ytogg='youtube-dl -x --audio-format vorbis --audio-quality 0 -o "%(title)s.%(ext)s" --restrict-filenames'
alias ytdl='youtube-dl --max-quality=MP4 -o "%(title)s.%(ext)s" --restrict-filenames'
alias wgeturlfromfile="wget -r -l1 -H -t1 -nd -N -np -A.jpg -erobots=off -i"        # -i file.txt
alias wget="wget -c"
alias 4chandl="$HOME/bin/download_4chan_lwp.pl"
alias tpb="$HOME/bin/tpb.sh"
alias teu="$HOME/bin/teu.sh"
alias tumblrdl="$HOME/bin/gettumblrpics.sh"

# Apps
alias vi="vim"
alias boinc="open $HOME/BOINC/run_manager"
alias lotto="$HOME/bin/lotto.sh"
alias t="$HOME/.todo/todo.sh -d $HOME/.todo/todo.cfg"
alias timer="$HOME/bin/timer.sh"
alias stopuhr="$HOME/bin/stopuhr.sh"
alias pass="$HOME/bin/pass.sh"
alias cal="$HOME/bin/cal.sh"
alias radio="$HOME/bin/radio.sh"

# Media
alias movieshot="$HOME/bin/shot.sh"
alias thumbit="$HOME/bin/thumbit.sh"
alias upimg="$HOME/bin/imgurbash.sh"
alias m3u="$HOME/bin/makem3u.sh"
alias pngopti="$HOME/bin/pngopti.sh"
alias audio="$HOME/bin/audio.sh"

# Convert
alias toiso="$HOME/bin/toiso.sh"
alias video2avi="$HOME/bin/video2avi.sh"
alias video2dvd="$HOME/bin/video2dvd.sh"
alias dvd2mpg="$HOME/bin/dvd2mpg.sh"
alias dvd2iso="$HOME/bin/dvd2iso.sh"
alias arabic2roman="$HOME/bin/arabic2roman.sh"
alias pdf2text="$HOME/bin/pdf2text.sh"
alias convertatemp="$HOME/bin/convertatemp.sh"

# Web
alias wa="$HOME/bin/wa.sh"
alias DropUp="$HOME/bin/dropbox_uploader upload"
alias DropDown="$HOME/bin/dropbox_uploader download"
alias ifdown="$HOME/bin/downforme.sh"
alias hostscheck="$HOME/bin/hostscheck.sh"
alias tweet="$HOME/bin/tweet.sh"

# Notes
alias note="$HOME/bin/note.sh -n"
alias listnote="$HOME/bin/note.sh -l"
alias rmnote="$HOME/bin/note.sh -r"
alias notevers="$HOME/bin/note.sh -v"

# Power 
alias reboot="sudo shutdown -r now"
alias ShutUp="sudo shutdown -h now"
alias sleeptime="sudo shutdown -P -h "
alias screensaver="cmatrix"

# Git stuff  
alias gitouch="find . \( -type d -empty \) -and \( -not -regex ./\.git.* \) -exec touch {}/.gitignore \;"
alias gitup="git pull"
alias gitco="git clone"
alias gita="git add"
alias gitb="git branch"
alias gitc="git checkout"
alias gitlo='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s %C(bold blue)<%an>%Creset" --abbrev-commit'

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

# Distro specific alias
if [[ "$detectedDistro" == "ubuntu" ]]; then
    alias filescripts='cd ~/.gnome2/nautilus-scripts'
    alias explore='nautilus --browser .'
elif [[ "$detectedDistro" == "linuxmint" ]]; then
    alias filescripts='cd ~/.gnome2/nemo-scripts'
    alias explore='caja --browser .'
elif [[ "$detectedDistro" == "lmde" ]]; then
    alias filescripts='cd ~/.gnome2/nemo-scripts'
    alias explore='nemo --browser .'
fi


# ---- Stuff to Execute ---- #
# Source for is_screen(), retval(), retval2(), PROMPT_COMMAND, PS1, require_machine
# https://github.com/cfenollosa/dotfiles/blob/master/.bashrc

# Avoid being sourced twice
[[ "`type -t in_array`" == "function" ]] && return 1 

# Check if a value exists in an array
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

source ~/.bash_welcome;

# ---- Machine-specific ---- #
require_machine anniki
require_machine runa 
require_machine ylva 
require_machine amalia 
require_machine annica

# Make 'source .bashrc' return 0
trap log_commands DEBUG