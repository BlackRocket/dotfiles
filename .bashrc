# Check for an interactive session
[ -z "$PS1" ] && return
if [[ $- != *i* ]] ; then return; fi

# PATH, Folders & Files
if [ ! -d "${HOME}/build" ]; then mkdir ${HOME}/build ; chmod 700 ${HOME}/build ; fi
if [ ! -d "${HOME}/tmp" ]; then mkdir ${HOME}/tmp ; chmod 700 ${HOME}/tmp ; fi
if [ ! -d "${HOME}/blog" ]; then mkdir ${HOME}/blog ; chmod 700 ${HOME}/blog ; fi
if [ ! -f $HOME/.bash_history ]; then touch $HOME/.bash_history; fi
PATH=$PATH:"/usr/local:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin:/usr/lib/wine/bin:/sbin:/usr/sbin:/usr/local/bin:$HOME/.todo"


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
export JPY=$HOME/bin/j.py  
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

# ---- source ---- #
if [ -f /etc/bash.bashrc ];       then source /etc/bash.bashrc;         fi
if [ -f $HOME/.bash_keys ];       then source $HOME/.bash_keys;         fi
if [ -f $HOME/bin/gitprompt.sh ]; then source $HOME/bin/gitprompt.sh;   fi
if [ -f $HOME/.bash_alias ];      then source $HOME/.bash_alias;        fi
if [ -f $HOME/.bash_functions ];  then source $HOME/.bash_functions;    fi
if [ -f $HOME/.bash_colors ];     then source $HOME/.bash_colors;       fi
if [ -f $HOME/.bash_nonsense ];   then source $HOME/.bash_nonsense;     fi
if [ -f $HOME/bin/j.sh ];         then source $HOME/bin/j.sh;           fi
if [ -f $HOME/bin/drush.sh ];     then source $HOME/bin/drush.sh;       fi

# ---- bash completion ---- #
if [ -f /etc/bash_completion ];         then source /etc/bash_completion;         fi
if [ -f $HOME/.todo/todo_completion ];  then source $HOME/.todo/todo_completion;  fi
if [ -f $HOME/.bash_complete ];         then source $HOME/.bash_complete;         fi


# ---- Stuff to Execute ---- #
# Source for is_screen(), retval(), retval2(), PROMPT_COMMAND, PS1, require_machine
# https://github.com/cfenollosa/dotfiles/blob/master/.bashrc

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

if [ -f $HOME/.bash_welcome ]; then . $HOME/.bash_welcome; fi
if [ -f $HOME/.bash_complete ]; then . $HOME/.bash_complete; fi

# ---- Machine-specific ---- #
require_machine anniki && source $HOME/.bash_mobile && alias gwww='cd /var/www' && alias gnosync="cd ~/NoSync"
require_machine runa && source $HOME/.bash_mobile
require_machine ylva && source $HOME/.bash_server
require_machine amalia && alias gwww="cd /var/www" && alias gvacuum="cd ~/suck/complete" && alias gkaisa="cd /kaisa" && alias gdev="cd /kaisa/Dev" && alias gmilja="cd /milja" && alias ginstalls="cd /kaisa/InstallFiles" && alias gnosync="cd /kaisa/NoSync"
require_machine annica

# Make 'source .bashrc' return 0
trap log_commands DEBUG

. $HOME/.shellrc.load
