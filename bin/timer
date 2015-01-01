#!/bin/bash

# USAGE
# timer <time> <optional message>
# timer 15 You've lived enough. Go die!

echo "Will go off in" $1 "..."
sleep $1
shift
echo "Time's up!"
mplayer /usr/share/sounds/gnome/default/alerts/drip.ogg &>/dev/null
notify-send 'BOOOM! Time is up!' "$*"
zenity --info --title "BOOOM! Time is up!." --text "$*"
