#!/bin/bash
# Quelle: http://evan.borgstrom.ca/post/538694787/a-better-bash-random-password-generator
MATRIX="HpZld&xsG47f0)W^9gNa!)LR(TbQjh&UwnvP(tD5eAzr6fk@E&y(umB3^h@!K^cbOCV)ScFJoYi2q@MIX8!1"
PASS=""
n=1
i=1
[ -z "$1" ] && length=10 || length=$1
[ -z "$2" ] && num=1 || num=$2
while [ ${i} -le $num ]; do
        while [ ${n} -le $length ]; do
                PASS="$PASS${MATRIX:$(($RANDOM%${#MATRIX})):1}"
                n=$(($n + 1))
        done
        echo $PASS
        n=1
        PASS=""
        i=$(($i + 1))
done