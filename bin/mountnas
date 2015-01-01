#####
#!/bin/sh
ft=`tput bold`
rs=`tput sgr0`
rd=`tput setb 4`
gn=`tput setf 2`

if [ $(id -u) -ne 0 ]; then
    echo "Skript muss als Root gestartet werden"
    exit
fi
echo -n "Mount (m) or uMount (u) NAS: "
      read MOUNTORUMOUNT

if [ $MOUNTORUMOUNT = m ]; then
   echo
   echo "${ft}Ordner mounted erstellen.${rs}"
   echo "======================================="
	if test -d ~/mounted
		then
  			echo "Ordner schon Vorhanden und wird gelöscht."
	  			rm -r ~/mounted
			echo "Ordner Erfolgreich gelöscht und wird neu erstellt."
		else
				echo "Ordner wird erstellt."
	fi			
	mkdir ~/mounted
		if [ $? = 1 ]; then
   		echo "${rd}Fehler beim erstellen des Ordners!${rs}"
		else
   		echo "Erstellen des Ordners erfolgreich."
		fi
	chown -R :1000 $HOME/mounted
	chmod 777 $HOME/mounted
		if [ $? = 1 ]; then
   		echo "${rd}Fehler beim setzen der Ordner Rechte!${rs}"
   		echo
		else
   		echo "Setzen der Ordner Rechte erfolgreich."
		fi
	echo 
	echo "${ft}NAS Laufwerk mounten.${rs}"	
	echo "======================================="
	echo -n "Server IP: "
		read IP
	echo -n "Ordner auf dem Server: "
		read FOLDER	
	echo -n "Benutzername auf dem Server: "
		read USERNAME
	echo -n "Passwort: "
		stty -echo
	 		read  PASSWORD
	 	stty echo
	echo 	
	echo "Bitte warten ..."
	echo
  	
    sudo /bin/mount -t cifs -o username=$USERNAME,password=$PASSWORD,uid=1000,gid=100,umask=000 //$IP/$FOLDER ~/mounted/
    
    if [ $? = 1 ]; then
      echo "${rd}${ft}NAS Mount nicht erfolgreich.${rs}"
      echo
    else
      echo "${gn}${ft}NAS Mount erfolgreich. Über ~/mounted kann jetzt auf das Laufwerk zugegriffen werden.${rs}"
      echo
    fi
elif [ $MOUNTORUMOUNT = u ]; then
    	
	umount  $HOME/mounted/
	rmdir $HOME/mounted
    
	if [ $? = 1 ]; then
		echo "${rd}${ft}NAS uMount nicht erfolgreich.${rs}"
		echo
	else
		echo "${gn}${ft}NAS uMount erfolgreich.${rs}"
		echo
	fi
else
  	echo "dann halt nicht!"
fi
##################
