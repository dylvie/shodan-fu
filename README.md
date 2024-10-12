# shodan-fu
Different scripts to use shodan command line for weaponizing tests.

- shodan.sh : print a shodan search outputing ip and ports
- shodan_metasploit : Run a query on shodan excluding honeypots and run a metasploit exploit on assets
- shodan_nmap.sh : print a shodan search outputing ip and scan ports for service names with nmap
- shodan_nmap2.sh : second version using shodan to search for ports for faster scanning
- cve.sh : show information and exploits about a CVE
- shodan_ip.sh : Query Shodan for ips and urls based on a filter

Examples:

```
./shodan_ip.sh 'title:"USG FLEX 100","USG FLEX 100w","USG FLEX 200","USG FLEX 500","USG FLEX 700","USG FLEX 50","USG FLEX 50w","ATP100","ATP200","ATP500","ATP700"'[*] exec: /home/kali/shodan_ip.sh 'title:"USG FLEX 100","USG FLEX 100w","USG FLEX 200","USG FLEX 500","USG FLEX 700","USG FLEX 50","USG FLEX 50w","ATP100","ATP200","ATP500","ATP700"'

Top 10 Results for Facet: port
443                               15,975
8443                               2,331
4443                               1,621
4433                                 745
444                                  716
10443                                531
80                                   297
9443                                 253
4444                                 239
7443                                  89

Choose a port: 443

Running Shodan query
Ping ips...
X.X.X.X X.X.X.X X.X.X.X X.X.X.X X.X.X.X X.X.X.X X.X.X.X X.X.X.X X.X.X.X X.X.X.X X.X.X.X X.X.X.X X.X.X.X 
Writing shodan-title_USG_FLEX_100,USG_FLEX_100w,USG_FLEX_200,USG_FLEX_500,USG_FLEX_700,USG_FLEX_50,USG_FLEX_50w,ATP100,ATP200,ATP500,ATP700-urls-port443.txt
```

Needs a shodan license. Builded as a pentesting tool. Do not use it without consent of asset owner.
