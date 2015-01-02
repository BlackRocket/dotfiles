#!/bin/bash


echo "**************************"
echo "* Umbenennen von Dateien *"
echo "**************************"

echo ""
echo -n "Welches Verzeichnis [ Default: Aktuelles ]: "
read x

if [ "x$x" = "x" ]; then dir="."; else dir=$x; fi

cd $dir
echo -n "Verzeichnis: "
pwd
ls * >/dev/null
if [ "$?" != "0" ]; then echo "Keine Dateien im Verzeichnis"; exit 1; fi
echo -n "OK [ ENTER | CTRL+C ] ?"
read x

date=$(date +%Y%m%d)
echo -n "Datum [ Default: "$date" ]: "
read x
if [ "x$x" != "x" ]; then date=$x; fi

echo -n "Thema [ Default: _ ]: "
read x
if [ "x$x" = "x" ]; then topic=""; else topic=$x; fi

i=1
for file in $(ls)
do
no=$(echo "_"$i)
if [ "$i" -lt "10" ]; then no=$(echo "_000"$i); fi
if [ "$i" -lt "100" ] && [ "$i" -gt "9" ]; then no=$(echo "_00"$i); fi
if [ "$i" -lt "1000" ] && [ "$i" -gt "99" ]; then no=$(echo "_0"$i); fi
ext=$(echo $file|cut -f2 -d ".")
echo $file" -> "$date"_"$topic$no"."$ext
let i=$i+1
done

echo -n "Alles klar (das war nur ein Probelauf) [ ENTER | CTRL+C ] ? "
read x

i=1
for file in $(ls)
do
no=$(echo "_"$i)
if [ "$i" -lt "10" ]; then no=$(echo "_000"$i); fi
if [ "$i" -lt "100" ] && [ "$i" -gt "9" ]; then no=$(echo "_00"$i); fi
if [ "$i" -lt "1000" ] && [ "$i" -gt "99" ]; then no=$(echo "_0"$i); fi
ext=$(echo $file|cut -f2 -d ".")
file2=$(echo $date"_"$topic$no"."$ext)
mv -v $file $file2
let i=$i+1
done

exit 0
