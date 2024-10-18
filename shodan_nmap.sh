#!/bin/bash
#(c) Dylvie Shwartz 2024 - Dot not use it to harm
#print a shodan search outputing ip and scan ports for service names with nmap
#need a shodan license

clear

#use shodan filter to retrieve ips and filter honeypots
#add search terms before \\-tag:honeypot
#remove honeypots
shodan search --fields ip_str --limit 100 --facets ip \\-tag:honeypot port:445 vuln:ms17-010 country:it | 
	while read ip; do
		export ip
		#filter honeypots < 30 ports
		#use nmap to scan top 20 ports for services
		nmap -A -Pn --disable-arp-ping --open --top-ports=20 $ip |
			awk '/^[0-9]+\/tcp/ {cpt[$0]} END {if (length(cpt) < 30) {print "\033[32m"ENVIRON["ip"]"\033[0m"; for (line in cpt) print line;}}'
	done
