#!/bin/sh
#Systemzeit ausgeben
date=`date`
#Temperatur auslesen
temp_cam=`pcsensor -cm | head -n1`
#Schriftzug erstellen als PNG
convert -size 800x600 -background rgba(0,255,255,0.25) -font Courier-bold -pointsize 25 -fill white -draw \
"text 20,575 'intux.de | $date | $temp_cam°C '" /var/www/watermark.png

#Cam-Bild und Schriftzug zusammenbringen
composite -dissolve 50% -quality 100 /var/www/watermark.png /var/www/cam.jpg /var/www/cam_watermark.jpg
