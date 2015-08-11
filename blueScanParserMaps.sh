#!/bin/bash
#################################################
## This script was created by:                 ## 
## @JoshInGeneral                              ##
## on 08/11/2015                               ##
## Description:                                ## 
## This allows us to use the android tool      ##
#$ BlueScan, export the JSON, and export       ##
## it to google maps.                          ## 
## Please see the presentation listed in this  ##
## directory for more details                  ##
#################################################
if [ "$1" == "" ]; then
  echo "Usage: ./blueScanParserMaps.sh [file]"
  exit
fi
echo "Making csv file"
echo "Name, Latitude, Longitude" > output.csv
echo "Reading in file $1"
while read line;
do
  case $line in
      template*)
	echo "copy this if you want to make a new one"
      ;;
      *company*)
        echo $line
      ;;
      *latitude*)
	echo $line
        echo -n $(echo $line | awk '{print $2}') >> output.csv
      ;;
      *longitude*)
	echo $line
        echo $line | egrep "^.*," | awk '{print $2}' >> output.csv
      ;;
      \"mac*)
	echo $line
        echo -n $(echo $line | awk '{print $2}') >> output.csv
      ;;
      *timestamp*)
	timeStamp=$(echo $line | egrep [0-9]{10} -o | xargs date -r )
        echo "\"date\": \"$timeStamp\""        
       ;;
      *)
        #echo "config load error"
        #echo $line
        ;;
      esac
      done < $1
