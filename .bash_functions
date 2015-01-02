##################################################
# Get/verify info on stuff (useful in other 	   #
# functions)					                           #
##################################################



# Bookmarks
go() { cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"; }
mark() { mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"; }
unmark() { rm -i "$MARKPATH/$1"; }
marks() { ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo ;}

command_exists () { type "$1" &> /dev/null ; }

DISTRO='unknown'
DISTRO=$(lsb_release -i | awk -F ":" '{ print $2 }' | sed -e 's/^[ \t]*//')

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
wetter() { 
var_data=$(curl -s 'http://weather.tuxnet24.de/?id=GMXX0185')

var_data_humidity=$(echo "$var_data" | grep humidity | cut -c12-15)
var_data_temp=$(echo "$var_data" | grep current_temp | cut -c16-25)
var_data_text=$(echo "$var_data" | grep current_text | cut -c16-60)
var_data_speed=$(echo "$var_data" | grep speed | cut -c9-20)
var_data_direction=$(echo "$var_data" | grep direction | cut -c13-17)
var_data_visib=$(echo "$var_data" | grep visib | cut -c14-25)
var_data_pressure=$(echo "$var_data" | grep pressure | cut -c12-25)
var_data_sunrise=$(echo "$var_data" | grep sunrise | cut -c10-17)
var_data_sunset=$(echo "$var_data" | grep sunset | cut -c9-17)

echo -e "Wetter: ${var_data_temp} ${var_data_text}"
echo -e "Relative Luftfeuchte: ${var_data_humidity}"
echo -e "Windgeschwindigkeit:$ ${var_data_speed} (${var_data_direction})"
echo -e "Sichtweite: ${var_data_visib}"
echo -e "Luftdruck: ${var_data_pressure}"
echo -e "Sonnenaufgang: ${var_data_sunrise}"
echo -e "Sonnenuntergang: ${var_data_sunset}"
}

##  Nice mount output
nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2=$4="";1') | column -t; }

## online check
connected() { wget -q --tries=20 --timeout=10 http://www.google.com -O /tmp/google.idx &> /dev/null ; if [ ! -s /tmp/google.idx ]; then echo -e "${ered}OFFLINE${nocol}"; else echo -e "${egreen}ONLINE${nocol}"; fi }

## geoip lookup (need geoip database: sudo apt-get install geoip-bin)
geoip() { geoiplookup $1; }

## find an unused unprivileged TCP port
findtcp() { (netstat  -atn | awk '{printf "%s\n%s\n", $4, $4}' | grep -oE '[0-9]*$'; seq 32768 61000) | sort -n | uniq -u | head -n 1; }

##
addclock() { while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done & }

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

## Remove apps with style: nuke it from orbit
# usage: nuke [name of the program]
nuke() { if [ $(whoami) != "root" ] ; then for x in $@; do sudo apt-get autoremove --purge $x; done; else for x in $@; do apt-get autoremove --purge $x; done; fi }

quickmail() { echo "$*" | mail -s "$*" sebastian@brcs.eu; }

rgc() { git commit -m"`curl -s http://whatthecommit.com/index.txt`"; }

pass() { [ -z "$1" ] && length=10 || length=$1; </dev/urandom tr -dc '#4VjADLh7@38=W4fEw3?MmdazfwfDc2w6qF_T}htW!8KAWQ5]mJyxNzWTV4&XxmwMRw+BDs&gkAG8}eU#N[u;j}P5MEw9RRpb(nDjDusPUYqE49BkUUf5DUC}3XSJh7L$])+raq5V(]8KVvVj{2(mph;f6NQ)p83a8Zr9{=yW7s_wLUEuqkFCuBJ3{#7#[B#T;mv?_SA69A8p=yHbJ)E3h(U#5u=QV}bR#wv;)VZQ$T59[e?u=h$;%H]U37crQe8t)n3#d8={S#CHy8KNt}N_)}zfzB8p82FQ(yM}tAZ?w;mU3Va$FP$nynuXP8?rUj6AHmk2L!E76QuBeuqK9cX_r}W6?B$yKUY[69LjM{}kzcLEx2)+5F+=rVS8%GtA8}kZTW9+FSj6VVc]q}[]r{7FEszvYSUTB5m$v$=ZG#y;RA)7kYTBHt7@K_abRUU]t77MUTf8PE%_647{wtj4L}J${J&A#Lmpk[26D7Y]dP]9kSSF?3cqLLcv$8U}E6+QRYp' | head -c${length}; echo "";history -d $(($HISTCMD-1)); }

## cleanly list available wireless networks (using iwlist)
wscan() { iwlist wlan0 scan | sed -ne 's#^[[:space:]]*\(Quality=\|Encryption key:\|ESSID:\)#\1#p' -e 's#^[[:space:]]*\(Mode:.*\)$#\1\n#p' ; }

###### notify on Battery power
# works on laptops, desktop having communication b/w UPS & CPU
NotifyOnBATTERY() { while :; do on_ac_power||notify-send "Running on BATTERY"; sleep 1m; done ; }

# copyright 2007 - 2010 Christopher Bratusek
show_battery_load()
{
  case $1 in
    *acpi )
      check_opt acpi show_battery_load::acpi
      if [[ $? != "1" ]]; then
        load=$(acpi -b | sed -e "s/.* \([1-9][0-9]*\)%.*/\1/")
        out="$(acpi -b)"
        state="$(echo "${out}" | awk '{print $3}')"
        case ${state} in
          charging,)
            statesign="^"
          ;;
          discharging,)
            statesign="v"
          ;;
          charged,)
            statesign="°"
          ;;
        esac
        battery="${statesign}${load}"
        echo $battery
      fi
    ;;
    *apm )
      check_opt apm show_battery_load::apm
      if [[ $? != "1" ]]; then
        result="$(apm)"
        case ${result} in
          *'AC on'*)
            state="^"
          ;;
          *'AC off'*)
            state="v"
          ;;
        esac
        load="${temp##* }"
        battery="${state}${load}"
        echo $battery
      fi
    ;;
    * )
      echo -e "\n${ewhite}Usage:\n"
      echo -e "${eorange}show_battery_load${ewhite} |${egreen} --acpi${eiceblue} [show batteryload using acpi]\
      \n${eorange}show_battery_load${ewhite} |${egreen} --apm${eiceblue} [show batteryload using apm]" | column -t
      echo ""
      tput sgr0
    ;;
  esac
}
