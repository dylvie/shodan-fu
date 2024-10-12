#!/bin/bash
#(c) Dylvie Shwartz 2024 - Dot not use it to harm
#Query Shodan for ips and urls based on a filter
#needs a shodan license

if [[ ! $1 ]]; then
    echo "Synopsis: $0 <query>"
    exit
fi
shodan stats --facets port $*
echo -n "Choose a port: "
read port
if [[ $port ]]; then
        file=`echo "$*" | tr '/\\ :' '____' | tr -d '"'"'"`
        file="shodan-$file-urls-port$port.txt"
        rm 2>/dev/null -q $file
        echo -e "\n\e[32mRunning Shodan query\e[0m"
        ips=`shodan search --limit 200 --fields ip_str port:$port $* |
                awk 'NR>1 && $1 !~ /^$/ {printf $1 " "}'`
        echo -e "\e[32mPing ips...\e[0m"
        for ip in $ips; do
                ping -c 1 -W 3 $ip |
                        awk 'NR==4' |
                                grep >/dev/null -v '100% packet loss' &&
                                        (echo -n "$ip "; echo "https://$ip:$port" >>"$file")
        done
        echo -e "\n\e[32mWriting $file\e[0m"
fi
