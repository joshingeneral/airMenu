#!/bin/bash
function updateConfig {
#Read in from config file
while read line;
do
  case $line in
      BSSID*)
        BSSID=$(echo $line | sed -e 's/BSSID.//')
        echo "BSSID:$BSSID"
      ;;
      FILEPREFIX*)
        FILEPREFIX=$(echo $line | sed -e 's/FILEPREFIX.//')
        echo "FILEPREFIX:$FILEPREFIX"
      ;;
      WORDLIST*)
        WORDLIST=$(echo $line | sed -e 's/WORDLIST.//')
        echo "WORDLIST:$WORDLIST"
      ;;
      CHANNEL*)
        CHANNEL=$(echo $line | sed -e 's/CHANNEL.//')
        echo "CHANNEL:$CHANNEL"
      ;;
      *)
        #echo "config load error"
        ;;
      esac
      done < aircrack.conf

}
updateConfig
#This is the menu for our tool to do some awesome things
readIn="1"
while [ "$readIn" != "quit" ]; do
  #These are the options we have to run through
 case $readIn in
   1) #first run
     echo "Enter command:"
   ;;
   mon*)
     #start here
     arg1=$(echo $readIn | awk '{ print $2}')
     echo "We are now starting to monitor the lasers"
     ./airodump-ng4.sh $arg1
   ;;
   capture*)
    arg1=$(echo $readIn | awk '{ print $2}')
    sudo airmon-zc
    echo "please enter monitor card"
    read mon
    if [ "$arg1" == "" ]; then
      echo "monitoring on channel $CHANNEL with BSSID $BSSID to file $FILEPREFIX"
      screen -AdmS "airD$BSSID_$CHANNEL_$mon" sudo airodump-ng -c $CHANNEL --bssid $BSSID -w "$FILEPREFIX"_CH"$CHANNEL"_BSSID"$BSSID" "$mon"
      sleep 2
      echo "entering screen now..."
      screen -r "airD$BSSID_$CHANNEL_$mon"
      echo "sudo airodump-ng -c $CHANNEL --bssid $BSSID -w "$FILEPREFIX"_CH"$CHANNEL"_BSSID"$BSSID" $mon"
    elif [ "$arg1" == "nobssid" ];then
      echo "monitoring only on channel $CHANNEL to file $FILEPREFIX"
      screen -AdmS "airD$CHANNEL_$mon" sudo airodump-ng -c $CHANNEL --bssid $BSSID -w "$FILEPREFIX"_CH"$CHANNEL" "$mon"
      sleep 2
      echo "entering screen now..."
      screen -r "airD$CHANNEL_$mon"
      echo "sudo airodump-ng -c $CHANNEL --bssid $BSSID -w $FILEPREFIX"_CH"$CHANNEL $mon"
    elif [ "$arg1" == "all" ];then
      echo "monitoring to file $FILEPREFIX"
      screen -AdmS "airD" sudo airodump-ng -w "$FILEPREFIX" "$mon"
      sleep 2 
      echo "entering screen now..."
      screen -dr "airD"
      echo "sudo airodump-ng -w $FILEPREFIX $mon"
    fi
      echo "Enter command:"
   ;;
   handshake*)
    if [ "$arg1" == "" ]; then
     screen -AdmS "airC" aircrack-ng $FILEPREFIX*.cap -w $WORDLIST | egrep -v "No|Unknown"
      sleep 2
      echo "entering screen now..."
      screen -dr "airC"
    elif [ "$arg1" == "*test*" ]; then
      aircrack-ng $FILEPREFIX*.cap -w $WORDLIST | egrep -v "No|Unknown"
      sleep 2
      echo "entering screen now..."
      screen -dr "airC"
     echo  "aircrack-ng test2-*.cap | egrep -v \"No|Unknown\""
   else
     screen -AdmS "airC$arg1" aircrack-ng *$arg1*.cap -w $WORDLIST | egrep -v "No|Unknown"
      sleep 2
      echo "entering screen now..."
      screen -dr "airC$arg1"
     echo  "aircrack-ng test2-*.cap | egrep -v \"No|Unknown\""
   fi
     ;;
   screen*)
     screen -ls
     echo "Which screen number would you like to resume?"
     read num
     screen -dr $num
     echo "Enter command:"
     ;;
   list*)
     arg1=$(echo $readIn | awk '{ print $2}')
     if [ "$arg1" == "" ]; then
        echo "awk -F\";\" '{print $6,$4,$3}' $FILEPREFIX*.csv | uniq | sort -r"
        awk -F";" '{print $6,$4,$3}' $FILEPREFIX*.csv | uniq |sort -r
     else
        echo "awk -F\";\" '{print \$6,\$4,\$3}' $FILEPREFIX*.csv | egrep \"$arg1\" |uniq| sort -r"
        awk -F";" '{print $6,$4,$3}' $FILEPREFIX*.csv | egrep "$arg1" |uniq| sort -r
     fi
     screen -ls
   ;;
   config* )
     vim aircrack.conf
     updateConfig
     echo "Enter command:"
   ;;
   *)
   #fall out of sky here
      echo "You seem to be lost, please consult the droids for help"
      echo "You can see systems in progress: airD == Airodump | airC == aircrack"
      echo "Type 'mon [start | stop]' to enter monitor mode"
      echo "Type 'config' to edit the aircrack.conf file"
      echo "Type 'capture [ nobssid | all ]' to start monitoring on config channel"
      echo "Type 'handshakes [ fileprefix | test ]' to see what wifi have been proccessed"
      echo "Type 'screen' to list and show running screens"
      echo "Type 'list [SEARCH]' to see current wireless networks being captured"
   ;;
 esac
 #Recieve input from master and your training will be complete 
 read readIn
done

