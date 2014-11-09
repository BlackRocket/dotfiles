##################################################
# Get/verify info on stuff (useful in other 	   #
# functions)					                           #
##################################################

# Avoid being sourced twice
[[ "`type -t in_array`" == "function" ]] && return 1 

# Check if a value exists in an array
#
# $1        Needle  
# $2        Haystack
# returns   0 if Needle is in Haystack, 1 else
# example   in_array apple "orange apple banana"
in_array() {
    haystack=$2

    if [ -z "$1" ]; then return 1; fi

    for i in ${haystack[@]}; do
        [[ "$1" == "$i" ]] && return 0
    done

    return 1
}


# Test which machine we run on
#
# $1        machine or list of machines which the script runs on .
#           use the actual hostname, please
# returns   0 if the script is runnable in this host, 1 else
# example   require_machine ""
require_machine() {
    return `in_array $HOSTNAME "$1"`
}

DISTRO='unknown'
DISTRO=$(lsb_release -i | awk -F ":" '{ print $2 }' | sed -e 's/^[ \t]*//')

##
# Author: Josh Bailey
# Email: jbsnake <at> <no spam> usalug.org
# usage: getExtension <filename>
function getExtension() { echo "${1##*.}"; }

##
# Author: Josh Bailey
# Email: jbsnake <at> <no spam> usalug.org
# further tweaked by: jsz
# usage: getFileName <filename>
function getFileName() {
    local filename=${1##*/}
    echo "${filename%.*}"
}

##
# Author: Josh Bailey
# Email: jbsnake <at> <no spam> usalug.org
# further tweaked by: jsz
# usage: getPath <filename>
function getPath() { echo "${1%/*}"; }

##
# Author: Josh Bailey
# Email: jbsnake <at> <no spam> usalug.org
# further tweaked by: jsz
# usage: inStr <char> <string>
inStr() {
    local i

    for ((i = 0; i < ${#2}; i++)); do
        if [[ ${2:i:1} = $1 ]]; then
            echo "$i"
        fi
    done
}

##
# Author: Josh Bailey
# Email: jbsnake <at> <no spam> usalug.org
function notADot() {
   if [[ ${1} != '.' ]]
   then
      return 0
   else
      return 1
   fi
}

function notAForwardSlash() {
   if [[ ${1} != '/' ]]
        then
      return 0
        else
           return 1
        fi
}

##
#
function die() { result=$1;shift;[ -n "$*" ]&&printf "%s\n" "$*" >&2;exit $result; }


## Check variable has been set does not require a test handles like an assertion
#
function isdef() { eval test -n \"\${$1+1}\"; }

## If no comment, inserts the date.
# Usage: flag "comment"
function flag() {
    if [ "$1" == "" ];
    then
        echo -e  "\e[0;31m[====== " `date +"%A %e %B %Y"`, `date +"%H"`h`date +"%M"` " ======]\e[0m"
    else
        echo -e  "\e[0;31m[====== " $@ " ======]\e[0m"
    fi
}

##
# Shell function which detects the Linux distro it's running on
# 10/02/17 framp at linux-tips-and-tricks dot de
detectedDistro="Unknown"
regExpLsbInfo="Description:[[:space:]]*([^ ]*)"
regExpLsbFile="/etc/(.*)[-_]"

if [ `which lsb_release 2>/dev/null` ]; then       # lsb_release available
   lsbInfo=`lsb_release -d`
   if [[ $lsbInfo =~ $regExpLsbInfo ]]; then
      detectedDistro=${BASH_REMATCH[1]}
   else
      echo "??? Should not occur: Don't find distro name in lsb_release output ???"
      exit 1
   fi

else                                               # lsb_release not available
   etcFiles=`ls /etc/*[-_]{release,version} 2>/dev/null`
   for file in $etcFiles; do
      if [[ $file =~ $regExpLsbFile ]]; then
         detectedDistro=${BASH_REMATCH[1]}
         break
      else
         echo "??? Should not occur: Don't find any etcFiles ???"
         exit 1
      fi
   done
fi

detectedDistro=`echo $detectedDistro | tr "[:upper:]" "[:lower:]"`

case $detectedDistro in
  suse)   detectedDistro="opensuse" ;;
        linux)  detectedDistro="linuxmint" ;;
esac
export $detectedDistro

##################################################
# Functions to use                               #
# Imported from bashrc                           #
##################################################

## REMIND ME, ITS IMPORTANT! 
# usage: remindme <time> <text>
remindme() { sleep $1; mplayer /usr/share/sounds/gnome/default/alerts/drip.ogg &>/dev/null; notify-send 'Remind' "$2"; zenity --info --title "Remind" --text "$2" ; }

## Extract password protected rar files (unrar-free)
# usage: rarpass <PASSWORD> <FILE> <DESTINATION>         
rarpass() { rar xe -p "$1" "$2" "$3" & }

## open a GUI app from CLI
# usage: open <APP> 
open() { $1 >/dev/null 2>&1 & }

## rip a file with handbrake and good options
# usage: rip <MOVIENAME>
rip() { HandBrakeCLI -i /dev/sr1 -o $HOME/Movies/$1.mp4 -e x264 -q 20 -B 192 -c 1-19 & }

## Brute force way to block all LSO cookies on Linux system with non-free Flash browser plugin
# usage: flash
flash() { for A in $HOME/.macromedia; do ( [ -d $A ] && rm -rf $A ; ln -s -f /dev/null $A ); done }

## 
meine() { sudo chown -R ${USER}:${USER} ${1:-.}; }

## 
sanitize() { sudo chmod -R 700 "$@"; }

# recursively fix dir/file permissions on a given directory
permfix() { if [ -d "$1" ]; then find "$1" -type d -exec chmod 755 {} -type f -exec chmod 644 {} \; else echo "$1 is not a directory."; fi ; }

## 
wetter() { weather -q --cacheage 1800 --cachedir=$HOME/tmp  EDDB; }

##  Nice mount output
nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2=$4="";1') | column -t; }

## online check
connected() { wget -q --tries=20 --timeout=10 http://www.google.com -O /tmp/google.idx &> /dev/null ; if [ ! -s /tmp/google.idx ]; then CONNECT=0; else CONNECT=1; fi }

## geoip lookup (need geoip database: sudo apt-get install geoip-bin)
geoip() { geoiplookup $1; }

## find an unused unprivileged TCP port
findtcp() { (netstat  -atn | awk '{printf "%s\n%s\n", $4, $4}' | grep -oE '[0-9]*$'; seq 32768 61000) | sort -n | uniq -u | head -n 1; }

## binary clock
buhr() { perl -e 'for(;;){@d=split("",`date +%H%M%S`);print"\r";for(0..5){printf"%.4b ",$d[$_]}sleep 1}'; }

## 
uhr() { while true;do clear;echo "===========";date +"%r";echo "===========";sleep 1; done }

##
addclock() { while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done & }

## get sunrise and sunset times 518763
suntimes() { curl -s http://weather.yahooapis.com/forecastrss?w=518763|grep astronomy| awk -F\" '{print "Sonnenaufgang: " $2 "\nSonnenuntergang: " $4;}'; }

## Creates a backup of the file passed as parameter with the date and time
bak() { cp $1 $1_`date +%H:%M:%S_%d-%m-%Y` ; }

## convert unix to normal
unix2normal() { echo $1 | awk '{print strftime("%Y-%m-%d %H:%M:%S",$1)}'; }

## convert normal to unix
normal2unix() { echo "${@}" | awk '{print mktime($0)}'; }

## expand shortened URLs
expandurl() { curl -sIL $1 2>&1 | awk '/^Location/ {print $2}' | tail -n1; }

## short URLs with is.gd
brcs() { wget -qO - "http://brcs.eu/yourls-api.php?signature=${BRCSKEY}&action=shorturl&format=simple&url=$1"  |  xclip  -sel clip ; }

## track flights from the command line (requires html2text: sudo apt-get install html2text)
flightstatus() { if [[ $# -eq 3 ]];then offset=$3; else offset=0; fi; curl "http://mobile.flightview.com/TrackByRoute.aspx?view=detail&al="$1"&fn="$2"&dpdat=$(date +%Y%m%d -d ${offset}day)" 2>/dev/null |html2text |grep ":"; }

## What package does that command come from?
cmdpkg() { PACKAGE=$(dpkg -S $(which $1) | cut -d':' -f1); echo "[${PACKAGE}]"; dpkg -s "${PACKAGE}" ; }

## colored status of running services
services() { printf "$(service --status-all 2>&1|sed -e 's/\[ + \]/\\E\[42m\[ + \]\\E\[0m/g' -e 's/\[ - \]/\\E\[41m\[ - \]\\E\[0m/g' -e 's/\[ ? \]/\\E\[43m\[ ? \]\\E\[0m/g')\n"; }

## Computes most frequent used words of text file 
# usage:   most_frequent "file.txt"
most_frequent() { cat "$1" | tr -cs "[:alnum:]" "\n"| tr "[:lower:]" "[:upper:]" | awk '{h[$1]++}END{for (i in h){print h[i]" "i}}'|sort -nr | cat -n | head -n 30 ; }

## 
http_headers() { /usr/bin/curl -I -L $@ ; }

## 
human_filesize() { awk -v sum="$1" ' BEGIN {hum[1024^3]="Gb"; hum[1024^2]="Mb"; hum[1024]="Kb"; for (x=1024^3; x>=1024; x/=1024) { if (sum>=x) { printf "%.2f %s\n",sum/x,hum[x]; break; } } if (sum<1024) print "1kb"; } ' ; }
 
## 
:h() {  vim --cmd ":silent help $@" --cmd "only"; }

## 
portscan() { H="$1";for((port=1;port<=65535;++port));do echo -en "$port ";if echo -en "open $H $port\nlogout\quit" | telnet 2>/dev/null | grep 'Connected to' > /dev/null;then echo -en "\n\nport $port/tcp is open\n\n";fi;done }

## RTFM function
rtfm() { help $@ || man $@ || $BROWSER "http://www.google.com/search?q=$@"; }

## Colored word-by-word diff of two files   
# ex.: showdiff oldversion.txt newversion.txt
showdiff() { wdiff -n -w $'\033[30;41m' -x $'\033[0m' -y $'\033[30;42m' -z $'\033[0m' $1 $2 ; }

## Get function's source    
source_print() { set | sed -n "/^$1/,/^}$/p"; }

## Set terminal title
terminal_title() { echo -en "\033]2;$@\007"; }

## Download all files of a certain type with wget 
# usage: wgetall mp3 http://example.com/download/
wgetall() { wget -r -l2 -nd -Nc -A.$@ $@ ; }

## Make a backup before editing a file      
safeedit() { cp $1 ${1}.backup && vim $1 ; }

## search in package database
# $1 = search term (package name)
sp() { apt-cache search "$1" | grep -i "$1"; }

## grep by paragraph instead of by line
grepp() { [ $# -eq 1 ] && perl -00ne "print if /$1/i" || perl -00ne "print if /$1/i" < "$2" ; }

## search bash history
# usage: mg [search pattern]
hgg() { history | grep -i $1 | grep -v hg ; }

## grep lsof"
# usage: losfg [port/program/whatever]
lsofg() { lsof | grep -i $1 | less ; }

## grep running processes
# usage: psg [process]
psg() { ps aux | grep USER | grep -v grep && ps aux | grep -i $1 | grep -v grep ; }

## rot47 ("rotate ASCII characters from '!" to '~' 47 places" Caesar-cypher encryption)
# usage:  rot47 [text]
rot47() { echo $@ | tr '!-~' 'P-~!-O' ; }

## Use a logger                  
log() { echo "$1" 1>&2 ; logger -ist "$(basename -- "$0")" "$1" ; }

## Print SSID
# usage: SSID
SSID () { iwconfig wlan0 | grep ESSID | cut -c 31-50 ;}

## imgur album downloader (a)
# usage: imgurdl [album id]
imgurdl() { wget -q "http://imgur.com/a/${1}/layout/blog" -O -|grep '"image"'|cut -d\" -f4|while read id; do echo "Downloading $id.jpg"; wget -q -c "http://i.imgur.com/$id.jpg"; done ; }

## imgur gallery downloader (r)
# usage: imgurgdl [gallery id]
imgurgdl() { wget -q "http://imgur.com/r/${1}" -O -|grep 'post"'|cut -d\" -f2|while read id; do echo "Downloading $id.jpg"; wget -q -c "http://i.imgur.com/$id.jpg"; done; }

## imgur comic album downloader (a)
# usage: imgurcdl '[comic name]' [album id]
imgurcdl() { mkdir "$1"; cd "$1"; wget -q "http://imgur.com/a/${2}/layout/blog" -O -|grep '"image"'|cut -d\" -f4|while read id; do x=$(( $x + 1 )); echo "Downloading ${x}_${id}.jpg"; wget -q -c "http://i.imgur.com/$id.jpg" -O "${x}_$id.jpg"; done; cd .. ; }


## Remove apps with style: nuke it from orbit
# usage: nuke [name of the program]
nuke() { if [ $(whoami) != "root" ] ; then for x in $@; do sudo apt-get autoremove --purge $x; done; else for x in $@; do apt-get autoremove --purge $x; done; fi }
