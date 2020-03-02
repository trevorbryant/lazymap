#!/bin/bash

# credits to calebstewart

if [ $(which nmap) ] && [ -f $(which masscan) ]; then
	info "enumerating all tcp ports w/ masscan"
	sudo masscan -p 1-65535 $1 -p 0-65535 --max-rate 1000 -oG masscan-tcp.grep -e "$2"

	# grab the list of open ports
	ports=`grep "open" masscan-tcp.grep | awk '{ print $5 }' | cut -d'/' -f1 | tr '\n' ',' | sed 's/,$//g'`
	
	if [ -z "$ports" ]; then
		warning "no open tcp ports detected!"
	else
		# Start nmap scan for these ports
		info "scanning open tcp ports w/ nmap ($ports)"
		nmap -sC -sV -sV $1 -p "$ports" -oN open-tcp.nmap
	fi
fi

