# BlueScanParser
This is some scripts to help push the BlueScan JSON file to a Custom Google Map
A demo map can be found at https://goo.gl/xOJ5sM
You can download BlueScanner (Renamed Bluetooth 4.0 Scanner) by John Abraham here: https://play.google.com/store/apps/details?id=com.bluemotionlabs.bluescan&hl=en

# Special Thanks
- Thanks go to John Abraham for creating such an awesome tool and his help with data collection. 
- Wireless CTF at Defcon for letting me present and creating an enviorment to play and learn.

#Legal things our lawyers make us say
By using this code you agree to not hold joshingeneral or his affiliates liable for what you do with it. As such, you should only email those that you have been given permission to email by the individual holding the account or have been authorized by their authoritative parties. You should also read the state and local laws and country laws act in order to ensure compliance and not face legal fines, much of which is covered by the CAN-SPAM act of 2003 in the US. 

#Requirements
A Google Account and Android Device.
Linux or Mac machine with egrep.

#Install
Install should be pretty easy. 

Step 1 - Download https://play.google.com/store/apps/details?id=com.bluemotionlabs.bluescan&hl=en

Step 2 - Collect some data for the map. 

Step 3 - Export the JSON email using the app, normally I just email it to myself and save it to a file named bluescan.json, but your are not limited to this.

#Creating a Map
Step 1 - Download blueScanParserMaps.sh on Mac or Linux (Windows users put into a VM running Ubuntu/Fedora/FreeBSD)

Step 2 - Use the terminal to cd into the folder you downloaded the file and run:
         chmod 775 blueScanParserMaps.sh 

Step 3 - run:
        ./blueScanParserMaps.sh [file]
        Where [file] is the file your created from the JSON data (I named it bluescan.json)
        This will create a file called output.csv
        
Step 4 - Now we need to create a custom map on google and upload the output.csv file

        1)Next goto https://www.google.com/maps
        
        2) Click "My Maps"
        
        3) Then "Create"
        
        4) In the next screen upload the output.csv file.
        
        5) Check the boxes for Longitude and Latitude
        
        6) And then select "Name" for our final field.
        
        7) Give it a description and name if you like, otherwise just enjoy.
        
Step 6 - Now you have a large map with Longitude and Latitude for all the bluetooth devices you have collected. The name filed will be the
        MAC address of the device and you can scroll as you see fit. 
        
        
#Future Features
 -- Create a web page version of this script
 -- Add an option for windows users as well (Probally Powershell)
 

