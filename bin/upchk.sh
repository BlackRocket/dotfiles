#!/bin/bash
# Quelle: https://www.debinux.de/2014/07/snippet-update-script-upchk/
TEMPFILE=`tempfile`
LASTUPDATE=`date -r /var/lib/apt/lists/`
echo "Package Installed Upgrade Branch Architecture -" > $TEMPFILE
CUP=`apt-get dist-upgrade -qq -y -s | grep '^Inst '| cut -d' ' -f2- | sed 's/[^a-zA-Z0-9+:~/.-]/ /g' >> $TEMPFILE`
NUP=`cat $TEMPFILE | wc -l`
if [[ "$NUP" -lt 2 ]] ; then
  echo -e "\e[00;32mNo upgrades available.\e[00m"
else
  echo -e "\e[00;31m`expr $NUP - 1` packages upgradeable.\e[00m"
  echo ""
  column -t -s ' ' $TEMPFILE
fi
echo -e "\n\e[00;93mLast update of package lists: \n$LASTUPDATE\e[00m"
rm $TEMPFILE