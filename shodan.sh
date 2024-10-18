#!/bin/bash
#(c) Dylvie Shwartz 2024 - Dot not use it to harm
#print a shodan search outputing ip and ports
#need a shodan license

clear

#use shodan filter to retrieve ips and filter honeypots
#add search terms before \\-tag:honeypot
#remove honeypots
shodan search --fields ip_str --limit 100 country:us \\-tag:honeypot | 
        while read ip; do
		#export ip to use in awk
                export ip
                #query ports on shodan
                shodan search --fields port --limit 100 ip:$ip | 
                	#filter honeypots < 30 ports
                	awk '{cpt[NR] = $0} END {if (length(cpt) < 30) {print "\033[32m"ENVIRON["ip"]"\033[0m"; for (i=1; i<=length(cpt);i++) print cpt[i];}}'
        done
