#!/bin/sh
 
 echo Z E I T / D A T U M
 date
 echo
 echo U S E R / H O S T
 echo ${USER}@`hostname`
 echo
 echo K E R N E L
 uname -a | awk '{print $3}' | cut -d '-' -f 1
 echo
 echo C P U - I N F O
 cat /proc/cpuinfo | grep 'model name' | cut -d ':' -f 2
 echo
 echo D I S K
 /bin/df -H | grep Dateisystem
 /bin/df -H | grep 'da'
 /bin/df -H | grep 'db'
 echo
 echo R A M
 free | grep 'total' | awk '{print $1" "$2" "$3}'
 free | grep 'Mem' | awk '{print $2" "$3" "$4}'
 echo
 echo S W A P
 free | grep 'total' | awk '{print $1" "$2" "$3}'
 free | grep 'Swap' | awk '{print $2" "$3" "$4}'
 echo
 echo I P - L A N
 /sbin/ip addr show eth0 | grep 'inet ' | cut -d t -f2 | cut -d / -f1 | cut -b 2-
 echo
 echo I P - W A N
 lynx -dump http://checkip.dyndns.org
