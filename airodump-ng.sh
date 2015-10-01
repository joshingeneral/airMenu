#!/bin/bash
# 
#  Created by @JoshInGeneral
#  Location: https://github.com/joshingeneral/airMenu 
#  Description: This is a script that helps quickly set up an enviorment to do password cracking
#  for wireless networks with aircrack-ng.
#  First used at Defcon WCTF for the Jack Tenna Team


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
  CHANNEL*)
    CHANNEL=$(echo $line | sed -e 's/CHANNEL.//')
    echo "CHANNEL:$CHANNEL"
    ;;
  *)
    echo "config load error"
    ;;
esac
done < aircrack.conf

#Show interfaces to use for sniffing
sudo airmon-zc
interfaces=$(sudo airmon-zc | egrep "wlan.|wlan.mon" -o)
count=$(sudo airmon-zc | egrep "phy" -c)
interfaceArray=($interfaces)
echo interfaces:$interfaces
echo "ath9k=Internal Card Asus"
echo "rtl8187=Alfa Card Asus"
#get number of interfaces for loop
echo count:$count

#Check if we are starting or stopping monitoring
if [ "$1" == "start" ]; then
  echo "Attempting to start monitoring..."
  #Ask if interfaces should it be in monitor mode
  for interface in "${interfaceArray[@]}"; do
    echo "Checking interface named: $interface"
    #if the device isn't a monitoring device
    if [[ $interface != *mon* ]]; then
      #check if it has a monitoring counter part
      checkMon=$(echo $interfaces | grep "$interface"mon -o | grep mon)
      #if not in monitor mode
      if [ "$checkMon" == "" ];then
        echo "Interface $interface is not in monitor mode yet"
        echo "do you want it to be?"
        echo "y for yes | anything else for no"
        read ans
        if [ "$ans" == "y" ]; then
          echo "Putting $interface in monitor mode"
          sudo airmon-zc start $interface
        fi
      fi
    fi
  done
  else
    echo "Attempting to stop monitoring..."
    #Ask if interfaces should it be in monitor mode
    for interface in "${interfaceArray[@]}"; do
      echo "Checking interface named: $interface"
      #if the device isn't a monitoring device
      if [[ $interface == *mon* ]]; then
        #check if it has a monitoring counter part
        checkMon=$(echo $interfaces | grep "$interface"mon -o | grep mon)
        #if not in monitor mode
        if [ "$checkMon" == "" ];then
        echo "Interface $interface is in monitor mode"
        echo "do you want it to be stopped?"
        echo "y for yes | anything else for no"
        read ans
        if [ "$ans" == "y" ]; then
          echo "Stopping $interface monitor mode"
          sudo airmon-zc stop $interface
        fi
      fi
    fi
  done
  
  
  fi

echo "Loop done, showing results:"
sudo airmon-zc
interfaces=$(sudo airmon-zc | egrep "wlan.|wlan.mon" -o)
count=$(sudo airmon-zc | egrep "phy" -c)
echo interfaces:$interfaces
echo count:$count
