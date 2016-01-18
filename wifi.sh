#!/bin/bash
while true; do
#Set path varrible
pcapPath="/mnt/webdav2/pcaps/"
#Make directory if does not exist already
mkdir -p "$pcapPath""proccessed/"
if [ -f "$pcapPath"*.cap ]; then
pcap=$(ls -tra "$pcapPath"*.cap | tail -n1)
temp=$(echo "$RANDOM".tmp)
text="$pcap".txt
echo "Using pcap: $pcap"
echo "Writing out to: $text"

#List out the SSID's in order
tshark -nnr $pcap | egrep SSID | egrep "[0-9a-f][0-9a-f]\:[0-9a-f][0-9a-f]\:[0-9a-f][0-9a-f]\:.*" -o | sed 's/802.*SSID\=//g' | awk '{print "@SSID="$4" "$5" "$6} ' | sort -u >> $temp
#List out all the devices attempting to connect
tshark -nnr $pcap | egrep SSID | egrep "[0-9a-f][0-9a-f]\:[0-9a-f][0-9a-f]\:[0-9a-f][0-9a-f]\:.*" -o | sed 's/802.*SSID\=//g' | awk '{print $1","$2","$4" "$5" "$6}' | sort -u >> $temp

#Load mac database from wireshark
curl "https://code.wireshark.org/review/gitweb?p=wireshark.git;a=blob_plain;f=manuf" | awk '{print $1" "$2}' > macs.lst

#Create Header
echo "=============================" > $text
echo $pcap >> $text
echo "=============================" >> $text

#Figure out Venders from MAC
while read line;
do
 mac=$(echo $line | egrep "^........" -o);
 vender=$(egrep "$mac" -i macs.lst | awk '{print $2}');
# vender2=$(egrep "$mac" -i macs.lst | sed -e 's/\:/\-/g' | awk '{print $2}');
 if [[ $vender == "" || $mac == "" ]];
  then echo "$line" >> $text
 else
  echo "$line ($vender)" >> $text
 fi;
done < $temp


#cat $text >> "$pcap".txt
mv -f $pcap "$pcapPath""proccessed/"
cat $text | mutt -s "$pcap ready" -- joshingeneral@gmail.com
else
  echo "No files found"
fi
echo "Checking again in:"
sleep 1
echo "5"
sleep 1
echo "4"
sleep 1
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"

done
