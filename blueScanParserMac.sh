#/bin/bash

######################################################################################################################
## This script was created by:                 																		## 
## @JoshInGeneral                              																		## 
## on 08/11/2015                               																		## 
## Description:                                																		##  
## This tool will use the epoch time stamp to find other bluetooth MAC addresses found around that time				##
## This will help you to find other MAC addresses that you scanned at a given time. If you start and 				##
## stop the scan after each collection you will be able to use this easily. If you need to convert epoch use:		##
## http://epochconverter.com 																						##
## Please see the presentation listed in this directory for more details                  							##
######################################################################################################################
if [ "$1" == "" ]; then
echo "usage: ./blueScanParser.sh [file]"
exit
fi 
echo "What time string do you want to start from?"
echo "Format: epoch"
read $timeInput
cat $1 | egrep "$timeInput.*" -B3 -A8 | egrep mac | egrep "\"[A-F0-9]{2}:[A-F0-9]{2}:[A-F0-9]{2}" -o | sed -e 's/\"//' | sort | uniq > mac.tmp
cat mac.tmp
while read line; 
do 
 echo $line; 
 curl http://www.coffer.com/mac_find/?string=$line -s | egrep search | awk 'BEGIN { FS = ">"; RS="<"; ORS="" }; {print $2}'; 
 sleep 2; 
done < mac.tmp
