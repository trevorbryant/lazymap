#!/bin/bash

if [ -f /usr/bin/nmap ]
then
	/usr/bin/nmap -p- -oA $1 $2 2>/dev/null
	ports=$(grep / $1.nmap | cut -d/ -f1 | sed -n '1!p' | xargs | sed 's/ /,/g')
	/usr/bin/nmap -sC -sV -p$ports -oA $1 $2	
else
	echo "Cannot find nmap. Is the package installed?"
fi
