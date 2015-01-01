#!/bin/sh
x1="sa-learn starten (kann dauern!):"
x2="sa-learn Ausgabe:"
echo =========================================================================================================
echo Spam lernen
echo
echo sa-learn_SPAM Ordner in /tmp erststellen:
if test -d /tmp/sa-learn_SPAM
 then
   echo Ordner schon Vorhanden und wird geloescht.
   rm -r /tmp/sa-learn_SPAM
	echo Ordner Erfolgreich gelöscht und wird neu erstellt.
else
	echo Ordner wird erstellt.
fi
mkdir /tmp/sa-learn_SPAM
mkdir /tmp/sa-learn_SPAM/BENUTZERNAME
if [ $? = 1 ]; then
    echo Fehler beim erstellen der Ordner!
    echo
else
    echo Erstellen der Ordner erfolgreich.
    echo
fi
echo Spam von den Benutzern aus dem Ordner spam_learn nach /tmp/sa-learn_SPAM kopieren:
cp /var/spool/imap/user/BENUTZERNAME/spam_learn/[0-9]*\. /tmp/sa-learn_SPAM/BENUTZERNAME
if [ $? = 1 ]; then
    echo Fehler beim kopieren der Daten!
    echo
else
    echo Kopieren erfolgreich.
    echo
fi
echo Rechte des Verzeichnisses /tmp/sa-learn_SPAM ändern:
chown -R mail:mail /tmp/sa-learn_SPAM
if [ $? = 1 ]; then
    echo Fehler beim ändern der Rechte!
    echo
else
    echo Rechte ändern erfolgreich.
    echo
fi
echo
echo SPAM learn von BENUTZERNAME wird gestartet...
echo SPAM learn ist gestartet...
echo SPAM learn Ausgabe:
sudo -u mail -H sa-learn --spam --showdots --dir /tmp/sa-learn_SPAM/BENUTZERNAME
echo =========================================================================================================
echo Ham lernen
echo
echo sa-learn_HAM Ordner in /tmp erststellen
if test -d /tmp/sa-learn_HAM
 then
   echo Ordner schon Vorhanden und wird geloescht.
   rm -r /tmp/sa-learn_HAM
	echo Ordner Erfolgreich gelöscht und wird neu erstellt.
else
	echo Ordner wird erstellt.
fi
mkdir /tmp/sa-learn_HAM
mkdir /tmp/sa-learn_HAM/BENUTZERNAME
if [ $? = 1 ]; then
    echo Fehler beim erstellen der Ordner!
    echo
else
    echo Erstellen der Ordner erfolgreich
    echo
fi
echo Spam von den Benutzern aus dem Ordner ham_learn Ordner nach /tmp/sa-learn_HAM kopieren:
cp /var/spool/imap/user/BENUTZERNAME/ham_learn/[0-9]*\. /tmp/sa-learn_HAM/BENUTZERNAME
if [ $? = 1 ]; then
    echo Fehler beim kopieren der Daten!
    echo
else
    echo Kopieren erfolgreich
    echo
fi
echo Rechte des Verzeichnisses /tmp/sa-learn_HAM ändern:
chown -R mail:mail /tmp/sa-learn_HAM
if [ $? = 1 ]; then
    echo Fehler beim ändern der Rechte!
    echo
else
    echo Rechte ändern erfolgreich
    echo
fi
echo
echo HAM learn von BENUTZERNAME wird gestartet
echo HAM learn ist gestartet...
echo HAM learn Ausgabe:
sudo -u mail -H sa-learn --ham --showdots --dir /tmp/sa-learn_HAM/blackrocket
echo =========================================================================================================