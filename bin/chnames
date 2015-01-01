#!/bin/bash

# chnames.sh - Dateinamen ändern durch Ersetzen unliebsamer Zeichen.
# 
# Copyright (C) 2005-2007 Conny Faber <conny@supple-pixels.net>
# Die neueste Version, ein kleines Archiv mit sonderbaren und dennnoch
# möglichen Dateinamen und die englische Version dieses Skripts sind zu
# finden unter http://www.supple-pixels.net.
# 
# Dieses Programm ist freie Software. Es kann unter den Bedingungen der GNU
# General Public License, wie von der Free Software Foundation herausgegeben,
# weitergegeben und/oder modifiziert werden, entweder gemäß Version 2 der
# Lizenz oder (optional) jeder späteren Version.
# 
# Die Veröffentlichung dieses Programms erfolgt in der Hoffnung, dass es
# von Nutzen sein wird, aber OHNE JEDE GARANTIE, noch nicht einmal der der
# VERWENDBARKEIT FÜR EINEN BESTIMMTEN ZWECK. Details sind zu finden in der
# Datei GNU General Public License (siehe Datei COPYING).
# 

# Dieses Skript habe ich v.a. zur Umbenennung von MP3-Dateien geschrieben,
# die oft nicht nur Umlaute enthalten (Problem zwischen verschiedenen
# Kodierungen), sondern auch noch diverse andere Zeichen wie Klammern, +, &,
# Leerzeichen (ungünstig für einige Programme) etc.; aber auch andere Dateien
# lassen sich mit chnames.sh automatisch prüfen und umbenennen.
#
# chnames.sh läßt sich nur UTF-8-kodiert in UTF-8-Shell verwenden, da das Skript
# selbst Zeichen enthält, die außerhalb des ISO-8859-1-Bereiches liegen!
#
# ToDo - later:
# -------------
# -k = keep = mehrfache Vorkommen, z.B. --- ___ behalten
# -s = substitute = eigene Ersetzungsformen angeben, z.B.
#      -s '+|plus' -s '. |.'   (= -s [von|nach])



benutzung()
{
HILFE="chnames.sh - Umbenennen von Datei- und Verzeichnisnamen

Beschreibung:
-------------
  chnames.sh ist ein Shell-Skript, das v.a. zur Umbenennung von MP3-Dateien
  entwickelt wurde, da diese oft Leerzeichen, Umlaute, Klammern und andere
  unliebsame Zeichen enthalten. Es lassen sich per chnames.sh Dateien und
  Verzeichnisse umbenennen, indem automatisch folgende Ersetzungen vorgenom-
  men werden:
  
  (Hinweis: Um alle unten aufgeführten Zeichen sehen zu können, wird ein
            Terminal benötigt, das UTF-8-Zeichen richtig anzeigen kann, z.B.
            urxvt, gnome-terminal, konsole.)
  
  Zeichen                            Wird zu
  ---------------------------------------------------------------------------
  Klammern: () [] {} <>              -
  Leerzeichen                        _
  Ä Ö Ü ä ö ü ß                      Ae Oe Ue ae oe ue ss
  + &                                _and_ bzw. _und_ (je nach Sprachwahl)
  °                                  _deg_ bzw. _Grad_ (je nach Sprachwahl)
  : ;                                .
  ,                                  gefolgt von Leerzeichen: _
                                     sonst:                   .
  ' \" \` ´ ? ! ^ # * ¿ ¡ ,            Werden entfernt.
  Akzentzeichen                      Werden zu Zeichen ohne Akzent:
                                     ÀÁÂÃÅ - A        àáâãå - a
                                     Æ     - AE       æ     - ae
                                     ÇĆĈĊČ - C        çćĉċč - c
                                     ÈÉÊË  - E        èéêë  - e
                                     ÌÍÎÏ  - I        ìíîï  - i
                                     Ñ     - N        ñ     - n
                                     ÒÓÔÕØ - O        òóôõø - o
                                     ŚŜŞŠ  - S        śŝşš  - s
                                     ÙÚÛ   - U        ùúû   - u
                                     Ý     - Y        ýÿ    - y
                                     ŹŻŽ   - Z        źżž   - z
  mehrere Leerzeichen - _ . ~        Werden auf 1 Zeichen reduziert.
  - am Namensanfang                  Wird entfernt.


Benutzung: chnames.sh <-d [dir]> <-D> <-g> <-r> <--check|--echeck|--no-log|-u>
---------  chnames.sh <-f [datei]>... <-g> <--check|--echeck>
           chnames.sh <-h|--usage|--version>
    
  --check       Reiner Test: Tut so, als würde umbenannt werden. Ausgabe von
                Original und potentiell zu verändernden Namen auf der Shell.
                Es werden keine Namen verändert und keine Log-Datei angelegt.
  -d [dir]      Verzeichnis angeben, in dem umbenannt werden soll.
                (Default = aktuelles Verzeichnis)
  -D            Benennt Verzeichnisse um, nicht Dateien.
  --echeck      Extra-Check: Reine Überprüfung, ob Datei- oder Verzeichnis-
                namen Zeichen außerhalb des ASCII-Bereichs enthalten. Erlaubt
                sind die Zeichen 0-9, A-Z, a-z sowie - _ . und ~. Ausgabe der
                Liste gefundener Namen erfolgt auf der Shell. Beim Extra-Check
                werden keine Namen verändert. Hiermit kann z.B. nach dem Um-
                benennen per chnames.sh geprüft werden, ob noch Namen übrig
                sind, die per chnames.sh nicht berücksichtigte Akzentzeichen,
                oder andere Sonderzeichen enthalten.
  -f [file]     Einzelne Datei- oder Verzeichnisnamen zur Ersetzung übergeben.
                Jeder Datei bzw. jedem Verzeichnis muss -f vorangestellt wer-
                den.
                Beachte: Hier wird der Umbenennungsvorgang nur in der Shell
                         ausgegeben. Es wird keine Log-Datei und kein Undo-
                         Skript angelegt.
  -g            Sprache Deutsch für Ersetzungen festlegen:
                - \"&\" und \"+\" werden zu \"_und_\" (default: \"_and_\")
                - \"°\" wird zu \"_Grad_\" (default: \"_deg_\")
  -h, --help    Zeigt diese Hilfe und beendet das Skript.
  --no-log      Keine Log-Datei im Zielverzeichnis erzeugen. Standartgemäß
                wird im Zielverzeichnis eine Log-Datei angelegt, die die
                Original-Namen und die veränderten enthält.
                (chnames_jjmmtt_hhmm.log)
  -r            Rekursiver Durchlauf; geht nicht mit -f
  -u            Undo-Skript im Zielverzeichnis anlegen. In Verbindung mit -r
                wird das Skript nur ins oberste, nicht in die Unterverzeich-
                nisse geschrieben. Durch Aufruf dieses Skriptes werden die
                Original-Namen wiederhergestellt. (chnundo_jjmmtt_hhmm.sh)
                Beachte: Gleichnamige Dateien werden als Backup mit Endung
                         ~n~ gesichert, wobei n die Anzahl bedeutet. Diese
                         Backup-Dateien werden durch das Undo-Skript NICHT
                         wieder zurückbenannt!
  --usage       Kurzhilfe zeigen und Skript beenden.
  --version     Versionsinfo zeigen und Skript beenden.

  Beachte: Es kann nur -d (und -D) oder -f angegeben werden. Werden doch beide
           Parameter genannt, wird nur -f ausgeführt, -d (und -D) nicht.


Hinweise:
---------
  chnames.sh läßt sich nur UTF-8-kodiert in einer UTF-8-Shell verwenden!
  Diverse Checks ermitteln, ob ein Dateiname in einer der folgenden Kodierun-
  gen vorliegt: UTF-8, ASCII, ISO-8859-1 oder allgemein andere Kodierung.
  Umbenannt werden Dateinamen in ISO-8859-1-Kodierung, UTF-8 und ASCII.
  Namen, die anders kodiert sind, werden gesondert gekennzeichnet, jedoch
  nicht verändert. Damit auch ISO-8859-1-Namen bearbeitet werden können, muss
  iconv installiert sein. Sollte iconv nicht auffindbar sein, werden in ISO-
  8859-1 vorliegende Namen nur gekennzeichnet, nicht umbenannt.
  
  Dateien mit durchgehender Großschreibweise müssen ggf. manuell nachbearbei-
  tet werden, da die Umlaute Ä, Ö, Ü nach Ae, Oe, Ue umbenannt werden.
  
  ACHTUNG: Die Überprüfung, in welcher Kodierung ein Name vorliegt, ist nicht
           perfekt. Es ist nicht garantiert, dass sie immer richtig funktio-
           niert, obwohl in meinen Tests bislang alles gut lief.
           Ebenso bieten die in chnames.sh enthaltenen Umbenennungen nur
           einen Rahmen, der aber nicht in jedem Einzelfall das Optimum ist.
           Bitte mit offenen Augen genießen ;-)


Beispiele:
----------
  
  chnames.sh
    
    ==> Benennt alle im aktuellen Verzeichnis liegenden Dateien um.
        Log-Datei landet im aktuellen Ordner.
  
  chnames.sh -d ~/mp3/Deutsches -g -u -r
    
    ==> Benennt rekursiv alle Dateinamen ab dem angegebenen Verzeichnis um;
        ersetzt dabei die Zeichen \"&\" und \"+\" durch ein deutsches \" und \".
        Undo-Skript wird im angegebenen Verzeichnis angelegt, Log-Dateien in
        jedem bearbeiteten Ordner.
  
  chnames.sh -D -d Jazz --no-log
    
    ==> Benennt alle Unterverzeichnisse des Ordners Jazz um. Geht dabei nicht
        rekursiv vor. Legt keine Log-Datei an.
  
  chnames.sh -f \"~/mp3/Deutsches/Comedian Harmonists - Wochenend und \\
  Sonnenschein.mp3\" -f \"~/mp3/Ethnic/04 - Touré Kunda - Aïyayao\"
    
    ==> Umbenennen einzeln angegebener Dateien; Umbenennungsvorgang wird nur
        per Shell ausgegeben, nicht in eine Log-Datei.
  
  chnames.sh -r --check
    
    ==> Reiner Test: Was würde wie verändert werden, wenn es passieren würde.
        Prüft rekursiv alle Dateien. Ausgabe per Shell.
  
  chnames.sh -r -d ~/mp3/Classic --echeck
    
    ==> Reiner Test, günstigerweise nach Umbenennung auszuführen: überprüft,
        ob nicht berücksichtigte Sonderzeichen übrig sind. Durchsucht rekur-
        siv die Inhalte des angegebenen Verzeichnisses. Ausgabe aller Namen,
        die Zeichen ausserhalb des ASCII-Bereichs oder Leerzeichen enthalten,
        erfolgt per Shell.
  

Noch ein Tip:
-------------

  find . -name \"chnames*.log\" -exec cat \"{}\" \";\" -ok rm \"{}\" \";\"
    
    ==> Schneller Überblick nach rekursivem Umbenennen:
        Sucht ab dem aktuellen Verzeichnis rekursiv nach allen von chnames.sh
        angelegten Log-Dateien, zeigt deren Inhalt mit cat an gefolgt von einer
        Abfrage, ob die Log-Datei gelöscht werden soll oder nicht.
"

echo "$HILFE" | less
}


kurzhilfe()
{
USAGE="
Benutzung: chnames.sh <-d [dir]> <-D> <-g> <-r> <--check|--echeck|--no-log|-u>
---------  chnames.sh <-f [datei]>... <-g> <--check|--echeck>
           chnames.sh <-h|--usage|--version>
    
  --check       Testdurchlauf
  -d [dir]      Verzeichnis angeben
  -D            Verzeichnisse umbenennen
  --echeck      Extra-Check, sucht u.a. nicht berücksichtigte Zeichen
  -f [file]     Einzelne Datei oder Verzeichnis umbenennen; -f pro Angabe
  -g            Verwende Deutsch für Ersetzung von \"&\", \"+\" und \"°\"
  -h, --help    Ausführlichere Hilfe
  --no-log      Keine Log-Datei(en) anlegen
  -r            Rekursiv
  -u            Undo-Skript anlegen (chnundo_jjmmtt_hhmm.sh)
  --usage       Kurzhilfe
  --version     Versionsinfo
"

echo "$USAGE"
}


versinfo()
{
VERSION="
chnames.sh - Dateinamen ändern durch Ersetzen unliebsamer Zeichen.
Version vom 27.04.2007
Copyright (C) 2005-2007 Conny Faber <conny@supple-pixels.net>
Eine englische Version dieses Skripts gibt es auf http://www.supple-pixels.net.

Dieses Programm ist freie Software. Details sind zu finden in der GNU
General Public License (siehe Datei COPYING).

Viel Spaß :-)
"

echo "$VERSION"
}


# Encoding prüfen
checkenc()
{
NAME="${i##*/}"
ORT="${i%/*}"

# Wenn NAME leer, sobald alle Zeichen aus ASC daraus entfernt wurden = ASCII
if test -z "${NAME//$ASC}" ; then
 ENC="ASCII"
else
  if test -z "${NAME//$UTF}" ; then
    ENC="UTF-8"
  else
    # Wenn iconv gefunden, dann Namens-Umwandlung testen
    if test -n "$ICONVDA" ; then
      NAMECONV=`echo "$NAME" | iconv -f ISO-8859-1 -t UTF-8`
      if test -z "${NAMECONV//$LAT}" ; then
        ENC="ISO-8859-1"
      else
        ENC="unbekannt"
        # Für umbenennen() - Standart = 1 = umbenennen
        UMB=0
      fi
    # Ansonsten ist auch ISO-8859-1 unbekannt
    else
      ENC="unbekannt"
      UMB=0
    fi
  fi
fi
}


# Reiner Check auf unliebsame Zeichen
extracheck()
{
# Encoding prüfen
checkenc

# Vergleichsname
VNAME="${NAME//$GUTZEI}"

# Wenn noch Zeichen in VNAME stehen, dann sind dies unliebsame Zeichen.
if test -n "$VNAME" ; then
  FOUND=1
  if test "$ORT" == "`pwd`" ; then
    echo "$NAME  ...  Kodierung: $ENC"
  else
    echo "${i/`pwd`\/}  ...  Kodierung: $ENC"
  fi
fi
}


# Funktion zum Umbenennen
umbenennen()
{
# Encoding prüfen
checkenc

# Ausgabe des akt. Original-Namens
if test "$ORT" == "`pwd`" ; then
  echo "Org: $NAME"
else
  # nur relativen Pfad ausgeben
  echo "Org: ${i/`pwd`\/}"
fi


# Wenn Kodierung unbekannt, nur Shell-Ausgabe
if test $UMB -eq 0 ; then
  echo -e "---  keine Änderung  ...  Kodierung ${ENC}\n"

else
  
  if test "$ENC" == "ISO-8859-1" ; then
    x="$NAMECONV"
  else
    x="$NAME"
  fi
  
  # Umbenennungen ausführen
  # -----------------------
  
  # mehrere Leerzeichen durch eins ersetzen
  x="`echo \"$x\" | sed 's/ \{2,\}/ /g'`"
  
  x="`echo \"$x\" | sed 's/ --* /-/g'`"  # Leer (mind. 1x: -) Leer durch -
  x="`echo \"$x\" | sed 's/ __* /_/g'`"  # Leer (mind. 1x: _) Leer durch _
  
  x="${x//. /_}"          # .Leerzeichen durch _
  x="${x//,[ _]/_}"       # ,Leerzeichen ,_ durch _
  x="${x//,/.}"           # , durch .
  
  x="${x//[\'\"\`´\?\!\^#\*¿¡]}"     # entfernt ' " ` ´ ? ! ^ # * ¿ ¡
  x="${x// [\[\(\{\<\]\)\}\>] /-}"   # Leer{[(<}])>Leer durch -
  x="${x// [\[\(\{\<\]\)\}\>]/-}"    # Leer{[(<}])> durch -
  x="${x//[\[\(\{\<\]\)\}\>] /-}"    # {[(<}])>Leer durch -
  x="${x//[\[\(\{\<\]\)\}\>]/-}"     # {[(<}])> durch -
  
  x="${x// /_}"           # Leer durch _
  x="${x//[:\;]/.}"       # : ; durch .
  
  # Umlaute
  x="${x//ä/ae}"
  x="${x//ö/oe}"
  x="${x//ü/ue}"
  x="${x//Ä/Ae}"
  x="${x//Ö/Oe}"
  x="${x//Ü/Ue}"
  x="${x//ß/ss}"
  
  # Akzentzeichen
  x="${x//[ÀÁÂÃÅ]/A}"
  x="${x//Æ/AE}"
  x="${x//[ÇĆĈĊČ]/C}"
  x="${x//[ÈÉÊË]/E}"
  x="${x//[ÌÍÎÏ]/I}"
  x="${x//Ñ/N}"
  x="${x//[ÒÓÔÕØ]/O}"
  x="${x//[ŚŜŞŠ]/S}"
  x="${x//[ÙÚÛ]/U}"
  x="${x//Ý/Y}"
  x="${x//[ŹŻŽ]/Z}"
  x="${x//[àáâãå]/a}"
  x="${x//æ/ae}"
  x="${x//[çćĉċč]/c}"
  x="${x//[èéêë]/e}"
  x="${x//[ìíîï]/i}"
  x="${x//ñ/n}"
  x="${x//[òóôõø]/o}"
  x="${x//[śŝşš]/s}"
  x="${x//[ùúû]/u}"
  x="${x//[ýÿ]/y}"
  x="${x//[źżž]/z}"
  
  # + & je nach Sprachoption ersetzen
  test $GER -eq 0 && x="${x//[\+&]/_and_}" || x="${x//[\+&]/_und_}"
  # ° je nach Sprachoption ersetzen
  test $GER -eq 0 && x="${x//°/_deg_}" || x="${x//°/_Grad_}"
  # - an erster Stelle des Namens
  test "${x:0:1}" == "-" && x="${x/[_-]}"
  
  # mehrere aufeinanderfolgende . - _ ~ reduzieren zu 1 Zeichen . - _ ~
  x="`echo \"$x\" | sed 's/\.\{2,\}/./g'`"
  x="`echo \"$x\" | sed 's/-\{2,\}/-/g'`"
  x="`echo \"$x\" | sed 's/_\{2,\}/_/g'`"
  x="`echo \"$x\" | sed 's/~\{2,\}/~/g'`"
  
  # Ungewöhnliche Zeichenkombinationen, die durch chnames.sh selbst
  # entstehen könnten, beseitigen
  x="${x//-_/-}"       # -_ durch -
  x="${x//_-/-}"       # _- durch -
  x="${x//[_\-~]./.}"  # _. -. ~. durch .
  x="${x//._/-}"       # ._ durch - (passiert häufiger in MP3)
  x="${x//.-/-}"       # .- durch -
  x="${x//[_\-]~/~}"   # _~ -~ durch ~
  x="${x//~[_\-]/~}"   # ~_ ~- durch ~
  
  # Durch die letzten Ersetzungen könnte es wieder zu doppelten Z. kommen:
  x="`echo \"$x\" | sed 's/\.\{2,\}/./g'`"
  x="`echo \"$x\" | sed 's/-\{2,\}/-/g'`"
  x="`echo \"$x\" | sed 's/~\{2,\}/~/g'`"

  
  # Betr. mv und Log-Datei
  if test "$i" != "${ORT}/$x" ; then
  
    # Für das Schreiben des Undo-Skripts
    CHANGED=1
    
    # Umbenennen
    if test $CHECK -eq 0 ; then
      
      mv -f --backup=numbered "$i" "${ORT}/$x"
      
      # Für Undo-Skript
      if test $USKRIPT -eq 1 ; then
        Sx="${x//\`/\\\`}"
        Sx="${Sx//\"/\\\"}"
        Si="${i//\`/\\\`}"
        Si="${Si//\"/\\\"}"
        
        SINHALT="$SINHALT
echo \"von:  ${ORT}/$Sx\"
echo \"nach: $Si\"
mv -f --backup=numbered \"${ORT}/$Sx\" \"$Si\"
echo
"
      fi
    fi
    
    # Ausgabe des neuen Namens auf der Shell
    if test "$ORT" == "`pwd`" -o "$ORT" == "." ; then
      echo -e "NEU: ${x}\n"
    else
      echo -e "NEU: ${ORT/`pwd`\/}/${x}\n"
    fi
    
    # Nur Veränderungen in Log-Datei schreiben
    if test "$DOLOG" == "ja" ; then
      if test "$ENC" == "ISO-8859-1" ; then
        echo "Org:  $NAME (ISO-8859-1)" >> "${ORT}/chnames_${DATUM}.log"
      else
        echo "Org:  $NAME" >> "${ORT}/chnames_${DATUM}.log"
      fi
      echo -e "NEU:  ${x}\n" >> "${ORT}/chnames_${DATUM}.log"
    fi
    
  else
  
    # nur Shell-Ausgabe
    echo -e "---  keine Änderung\n"
    
  fi

fi
}


# BEGINN
# ======

# chnames.sh funktioniert NICHT KORREKT in der bash-Version 2.05b.
#if test ${BASH_VERSINFO[0]} -lt 3 ; then
#  echo
#  echo "chnames.sh - ACHTUNG! - bash-Version"
#  echo
#  echo "chnames.sh wurde getestet mit bash-Version 2.05b und Versionen ab 3.0."
#  echo "Mit der Version 2.05b gab es Fehler."
#  echo "Es ist daher mindestens Version 3.0 noetig!"
#  echo
#  echo "chnames.sh beendet"
#  echo
#  exit 1
#fi

# Wenn chnames.sh NICHT in einem UTF-8-Terminal läuft, Abbruch und Meldung
if test -z "`locale | grep 'LC_CTYPE=.*UTF-8'`" ; then
  echo
  echo "chnames.sh - ACHTUNG! - UTF-8 benoetigt"
  echo
  echo "chnames.sh benoetigt zur korrekten Ausfuehrung ein UTF-8-Terminal."
  echo "Unter Systemen mit ISO-8859-1-Kodierung kann, vorausgesetzt die"
  echo "entsprechende locale steht zur Verfuegung, ein UTF-8-xterm z.B. wie"
  echo "folgt gestartet werden:"
  echo
  echo "  LC_CTYPE=\"de_DE.UTF-8\" xterm"
  echo
  echo "chnames.sh beendet"
  echo
  exit 1
fi

# Meldung falls das Skript unnatürlich beendet wird.
trap 'echo "chnames.sh abgebrochen" ; echo "letzter Stand: $i" ; exit 1' 1 2 15


# 0 = Default; wird bei -f = 1 gesetzt
NURF=0
# Falls nicht anders angegeben: aktuelles Verzeichnis
ORT="`pwd`"
# Falls nicht anders angegeben: Dateien umbenennen (d = Verz.)
TYP="f"
# Für Ersetzung von "&", "+" und "°" (default = Englisch = 0; Deutsch = 1)
GER=0
# Log-Datei: ja = Default; nein = wenn -f oder --no-log
DOLOG="ja"
# Für Eintrag in Log-Datei, falls keine Änderung
CHANGED=0
# Für Testdurchläufe (--check) (0 = tun; 1 = check)
CHECK=0
# Wenn rekursiv = 1
REC=0
# Undo-Skript erstellen = 1
USKRIPT=0
# Für Extra-Check = 1
ECHECK=0


# Parameterabfrage
while test $# -gt 0; do
  case $1 in
    --check ) CHECK=1 ; DOLOG="nein" ; USKRIPT=0 ;;
    -d ) ORT="$2" ; shift ;;
    -D ) TYP="d" ;;
    --echeck) CHECK=1 ; DOLOG="nein" ; USKRIPT=0 ; ECHECK=1
              FOUND=0 ;;
    -f ) 
         if test $NURF -eq 0 ; then
           if test $REC -eq 0 ; then
             NURF=1
             DOLOG="nein"
             USKRIPT=0
             FILES="$2"
           else
             kurzhilfe ; exit 1
           fi
         else
           FILES="${FILES}\n$2"
         fi
         shift ;;
    -g ) GER=1 ;;
    --no-log ) DOLOG="nein" ;;
    -r ) 
         # Wenn -f angegeben ist, darf NICHT rekursiv gesetzt sein
         if test -$NURF -eq 0 ; then
           REC=1
         else
           kurzhilfe ; exit 1
         fi ;;
    --version ) versinfo ; exit 0 ;;
    -u ) test $NURF -eq 0 && USKRIPT=1 || USKRIPT=0 ;;
    --usage ) kurzhilfe ; exit 0 ;;
    --help | -h ) benutzung ; exit 0 ;;
    * ) kurzhilfe ; exit 1 ;;
  esac
  shift
done

# Für Undo-Skript
SORT="$ORT"

# Leerzeichen nicht als Trenner ansehen
IFS=$'\n'

echo

# Wenn Extra-Check
if test $ECHECK -eq 1 ; then
  echo -e "*** chnames.sh - Starte Extra-Check ***\n"
# Wenn Check
elif test $CHECK -eq 1 -a $ECHECK -eq 0 ; then
  echo -e "*** chnames.sh - Starte Check ***\n"
# Wenn Umbenennen
else
  echo -e "*** chnames.sh - Starte Umbenennen ***\n"
fi


# Für alle Dateien/Verzeichnisse in 1 Verzeichnis oder rekursiv
if test $NURF -eq 0 ; then
  
  # Wenn 1 Verzeichnis (nicht rekursiv)
  if test $REC -eq 0 ; then
    OK=0
    # Wenn Extra-Check, Verzeichnis-test auf rx
    if test $ECHECK -eq 1 ; then
      test -r "$ORT" -a -x "$ORT" && OK=1
    else
      test -r "$ORT" -a -w "$ORT" -a -x "$ORT" && OK=1
    fi
    
    # Wenn die vorherigen Abfragen OK, dann FILES füllen
    if test $OK -eq 1 ; then
      FILES=`find "$ORT" -maxdepth 1 -mindepth 1 -type "$TYP" | sort`
    else
      # Fehlermeldung + Abbruch
      echo "${ORT}:"
      echo "Berechtigungen überprüfen!"
      echo "*** chnames.sh beendet ***"
      echo
      exit 1
    fi
  
  # Wenn rekursiv
  else
    # Bei Verzeichnis-Umbenennung -r muss umgekehrt sortiert werden
    if test "$TYP" == "d" ; then
      FILES=`find "$ORT" -mindepth 1 -type "$TYP" | sort -r`
    # Bei Datei-Umbenennung aufsteigend sortieren
    else
      FILES=`find "$ORT" -mindepth 1 -type "$TYP" | sort`
    fi
  fi
fi


# Wenn iconv vorhanden ist, können auch ISO-8859-1-Namen umbenannt bzw.
# bei --echeck die Kodierung ISO-8859-1 ermittelt werden.
# Anmerkung: Eigentlich werden Namen per convmv automatisch und gut umkodiert;
# dessen Ausgabe läßt sich jedoch nicht abfangen, was hier sehr störend wäre.
# Statt iconv könnte ebensogut recode verwendet werden.
ICONVDA=`which iconv`

if test -n "$ICONVDA" ; then
  # LAT = ISO-8859-1 - Hierin nicht enthalten: ¦¨©ª«¬­®¯²³¶·¸¹º»¼½¾
  LAT="[\]\[\!\"#\$%&\'\(\)\*\+,\-.0123456789:\;<=>\?ABCDEFGHIJKLMNOPQRSTUVWXYZ \\\^_\`abcdefghijklmnopqrstuvwxyz\{\|\}~¡¢£¤¥§°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ]"
  # UTF-8 - enthält alle alphanumerischen Zeichen, Space, Tab, Satzzeichen
  UTF="[[:alnum:][:blank:][:punct:]]"
fi

# ASCII-Zeichen für checkenc() - hierin nicht enthalten: / @
ASC="[\]\[\!\"#\$%&\'\(\)\*\+,\-.0123456789:\;<=>\?ABCDEFGHIJKLMNOPQRSTUVWXYZ \\\^_\`abcdefghijklmnopqrstuvwxyz\{\|\}~]"

# Für extracheck() - Erwünschte Zeichen in Namen:
test $ECHECK -eq 1 && \
GUTZEI="[-_~.ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789]"


# Für Namen in Log-Datei und Undo-Skript
if test "$DOLOG" == "ja" -o $USKRIPT -eq 1 ; then
  DATUM=`date +"%y%m%d_%H%M"`
fi

# Undo-Skript vorbereiten
if test $USKRIPT -eq 1 ; then
  
  # Bei -d werden nur relative Pfade im Undo-Skript gesichert. Hiermit
  # wird vor dem Umbenennen in das Verzeichnis gewechselt, aus dem der
  # ursprüngliche chnames.sh-Aufruf erfolgte.
  CDTO=`pwd`
  
  SDATE=`date +"%c"`
  SINHALT='#!/bin/bash'
  SINHALT="$SINHALT

# chnames.sh Undo-Skript
# Generiert am $SDATE

echo
echo 'chnames.sh - Undo-Skript'
echo

if test \"\$1\" != \"--do\" ; then
  echo 'Aufruf per \"./chnundo_jjmmtt_hhmm.sh --do\", um zurück zu benennen.'
  echo 'Gleichnamige Ziele werden überschrieben und als Backup gesichert.'
  echo
  exit 1
fi

echo \"Wechsle in das Verzeichnis, wo chnames.sh ursprünglich aufgerufen wurde:\"
echo \"cd nach ${CDTO}/\"
cd \"$CDTO\"
echo
echo 'Benenne um ...'
echo
"
fi


for i in `echo -e "$FILES"` ; do
  
  # Falls später Problem mit Verzeichnis auftaucht:
  WEITER="ja"
  # Falls Namen in ISO-8859-1 vorliegen, dann = "ja"
  ISTISO="nein"
  # Wenn Kodierung unbekannt = 0, sonst 1 (für umbenennen())
  UMB=1

  
  # Wenn -f oder -r: Verzeichnisrechte testen
  if test $NURF -eq 1 -o $REC -eq 1 ; then
    OK=0
    
    # Wenn Extra-Check, Verzeichnistest auf rx, sonst rwx
    # (die bash ist viel schneller als ein Aufruf von dirname)
    if test $ECHECK -eq 1 ; then
      test -r "${i%/*}" -a -x "${i%/*}" && OK=1
    else
      test -r "${i%/*}" -a -w "${i%/*}" -a -x "${i%/*}" && OK=1
    fi
    
    # Wenn vorherige Abfragen NICHT OK
    if test $OK -eq 0 ; then
      WEITER="nein"
      
      # Fehlermeldung betr. spezielles Verzeichnis
      echo "${i}:"
      echo "***  Vorgang nicht möglich. Berechtigungen überprüfen!"
      echo
    fi
  fi

  if test "$WEITER" == "ja" ; then
    
    if test $ECHECK -eq 1 ; then
      
      # Funktionsaufruf für Extra-Check
      extracheck
    
    else
      
      # Sind Dateien bzw. Verzeichnisse rw?
      if test -r "$i" -a -w "$i" ; then
        # Funktion "umbenennen" aufrufen
        umbenennen
      else
        echo "${i}:"
        echo "***  Umbenennen nicht möglich. Berechtigungen überprüfen."
        echo
      fi
    fi
  fi
  
done


# Wenn Extra-Check
if test $ECHECK -eq 1 ; then
  if test $FOUND -eq 1 ; then
    echo
    echo "*** Die ausgegebenen Namen enthalten unliebsame Zeichen oder ***"
    echo "*** liegen in einer anderen Kodierung als UTF-8 / ASCII vor. ***"
  else
    echo "*** Keine unliebsamen Namen gefunden. ***"
  fi
  echo
  echo "*** chnames.sh - Extra-Check beendet ***"
  echo

# Wenn Check
elif test $CHECK -eq 1 -a $ECHECK -eq 0 ; then
  echo "*** chnames.sh - Check beendet ***"
  echo

# Wenn Umbenennen
else
  echo "*** chnames.sh - Umbenennen beendet ***"
  echo
fi


# Undo-Skript endgültig schreiben + Berechtigung setzen (rwx------)
if test $USKRIPT -eq 1 -a $CHECK -eq 0 -a $CHANGED -eq 1 ; then
  echo "$SINHALT" > "${SORT}/chnundo_${DATUM}.sh"
  chmod 700 "${SORT}/chnundo_${DATUM}.sh"
fi
