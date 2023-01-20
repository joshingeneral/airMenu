function bti { bluetoothctl info "$1"; }
function btr { bluetoothctl info "$1"| egrep RSSI; }
function btl { while true; do echo run; bluetoothctl info "$1"| egrep RSSI.*$1;                                                                                                                sleep 2; done; }
function fl1 { airodump-ng wlan1mon --bssid="$1" --band a; }
function fl2 { airodump-ng wlan1mon --bssid="$1" --channel="$2" --band a; }
export -f bti
export -f btr
export -f btl
export -f fl1
export -f fl2

alias b="vim ~/.bashrc"
alias m="airmon-ng start wlan1"
alias c="airmon-ng check wlan1"
alias k="airmon-ng check kill"
alias a="airodump-ng wlan1mon"
alias a1="airodump-ng wlan1mon --bssid=d2:e4:0b:ea:c8:61 --channel=1"
#alias fl1="airodump-ng wlan1mon --bssid=C8:B5:AD:FF:56:B9"
#alias fl2="airodump-ng wlan1mon --bssid=C8:B5:AD:FF:56:B9 channel="
alias bts="bluetoothctl scan on"
alias btd="bluetoothctl devices"
