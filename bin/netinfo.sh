#!/bin/bash
#
# netinfo - shows network information for your system
echo "--------------- Network Information ---------------"
/sbin/ifconfig | awk /'inet Adresse/ {print "IP" $2}'
/sbin/ifconfig | awk /'inet Adresse/ {print $4}'
/sbin/ifconfig | awk /'Bcast/ {print $3}'
/sbin/ifconfig | awk /'Hardware Adresse/ {print "Hardware Adresse:"$6}'
myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
echo "${myip}"
echo "---------------------------------------------------"