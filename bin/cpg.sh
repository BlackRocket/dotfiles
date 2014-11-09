#!/bin/bash
#
## copy and go to dir
if [ -d "$2" ];then
	cp $1 $2 && cd $2
else
   	cp $1 $2
fi