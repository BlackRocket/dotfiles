#!/bin/bash
if [[ "$detectedDistro" == "opensuse" ]]; then
   if [ $(id -u) -ne 0 ]; then
      echo "Skript muss als Root gestartet werden"
      exit
   fi
   echo
   echo Ersten Zeitserver abfragen
   echo
   netdate -l 1 tcp ptbtime1.ptb.de #ptbtime1.ptb.de
   #
   # Zeitserver 2 falls es beim 1ten nicht geklappt hat
   #
   if [ $? = 1 ]; then
      echo
      echo Nr. 1 Fehlgeschlagen! Versuche naechsten!
      echo
      netdate -l 1 tcp 30.149.17.8 
   else    
      echo PC Uhr stellen
      hwclock --systohc
      exit 0
   fi
   #
   # Zeitserver 3 falls es beim 2ten nicht geklappt hat
   #
   if [ $? = 1 ]; then
      echo
      echo Nr. 2 Fehlgeschlagen! Versuche naechsten!
      echo
      netdate -l 1 tcp 134.106.156.34
   else
      echo PC Uhr stellen
      hwclock --systohc
      exit 0
   fi
   #
   # Zeitserver 4 falls es beim 3ten nicht geklappt hat
   #
   if [ $? = 1 ]; then
      echo
      echo Nr. 3 Fehlgeschlagen! Versuche naechsten!
      echo
      netdate -l 1 tcp 131.188.1.31
   else
      echo PC Uhr stellen
      hwclock --systohc
      exit 0
   fi
   #
   # Zeitserver 5 falls es beim 4ten nicht geklappt hat
   #
   if [ $? = 1 ]; then
      echo
      echo Nr. 4 Fehlgeschlagen! Versuche naechsten!
      echo
      netdate -l 1 tcp 130.149.17.8
   else
      echo PC Uhr stellen
      hwclock --systohc
      exit 0
   fi
   #
   # Zeitserver 6 falls es beim 5ten nicht geklappt hat
   #
   if [ $? = 1 ]; then
      echo
      echo Nr. 5 Fehlgeschlagen! Versuche letzten!
      echo
      netdate -l 1 tcp tcp ptbtime1.ptb.de #134.169.9.139
   else
      echo PC Uhr stellen
      hwclock --systohc
      exit 0
   fi
   #
   # Wenn es bei allen fehlschlug:
   #
   if [ $? = 1 ]; then
      echo
      echo Zeit konnte nicht von den Zeitservern aktualisiert werden
      echo
      exit 1
   else
      echo
      echo Hardwareuhr stellen
      echo
      hwclock --systohc
      exit 0
   fi
###########################################
else
   if [ $(id -u) -ne 0 ]; then
      echo "Skript muss als Root gestartet werden"
      exit
   fi
   echo
   echo Ersten Zeitserver abfragen
   echo
   ntpdate -u ptbtime1.ptb.de #ptbtime1.ptb.de
   #
   # Zeitserver 2 falls es beim 1ten nicht geklappt hat
   #
   if [ $? = 1 ]; then
      echo
      echo Nr. 1 Fehlgeschlagen! Versuche naechsten!
      echo
      ntpdate -u 30.149.17.8 
   else    
      echo PC Uhr stellen
      hwclock --systohc
      exit 0
   fi
   #
   # Zeitserver 3 falls es beim 2ten nicht geklappt hat
   #
   if [ $? = 1 ]; then
      echo
      echo Nr. 2 Fehlgeschlagen! Versuche naechsten!
      echo
      ntpdate -u 134.106.156.34
   else
      echo PC Uhr stellen
      hwclock --systohc
      exit 0
   fi
   #
   # Zeitserver 4 falls es beim 3ten nicht geklappt hat
   #
   if [ $? = 1 ]; then
      echo
      echo Nr. 3 Fehlgeschlagen! Versuche naechsten!
      echo
      ntpdate -u 131.188.1.31
   else
      echo PC Uhr stellen
      hwclock --systohc
      exit 0
   fi
   #
   # Zeitserver 5 falls es beim 4ten nicht geklappt hat
   #
   if [ $? = 1 ]; then
      echo
      echo Nr. 4 Fehlgeschlagen! Versuche naechsten!
      echo
      ntpdate -u 130.149.17.8
   else
      echo PC Uhr stellen
      hwclock --systohc
      exit 0
   fi
   #
   # Zeitserver 6 falls es beim 5ten nicht geklappt hat
   #
   if [ $? = 1 ]; then
      echo
      echo Nr. 5 Fehlgeschlagen! Versuche letzten!
      echo
      ntpdate -u tcp ptbtime1.ptb.de #134.169.9.139
   else
      echo PC Uhr stellen
      hwclock --systohc
      exit 0
   fi
   #
   # Wenn es bei allen fehlschlug:
   #
   if [ $? = 1 ]; then
      echo
      echo Zeit konnte nicht von den Zeitservern aktualisiert werden
      echo
      exit 1
   else
      echo
      echo Hardwareuhr stellen
      echo
      hwclock --systohc
      exit 0
   fi
fi