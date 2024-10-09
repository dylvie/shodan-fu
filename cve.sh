#!/bin/bash
#(c) Dylvie Shwartz 2024 - Dot not use it to harm

if [[ ! $1 ]]; then
    echo "$0 <cve>"
    exit
fi
echo -e "\e[35mcvedb\e[0m"
curl -s 'https://cvedb.shodan.io/cve/'$1 | jq
echo -e "\e[35mShodan stats for cve\e[0m"
shodan stats --facets country vuln:$1
echo -e "\e[35mPOC Github\e[0m: " `gh search repos --limit 1 --json fullName $1 | fgrep >/dev/null -v '[]' && echo -e "\e[31mhttps://github.com/search?q=$1&type=repositories\e[0m"`
echo -e "\e[35mPOC Github with dorks\e[0m: " `(gh search code --limit 1 --json path shodan $1 || gh search code --limit 1 --json path dorks $1) | fgrep >/dev/null -v '[]' && echo -e "\e[32mhttps://github.com/search?q=shodan+OR+dorks+$1+path%3A%2F%5C.%28md%7Ctxt%7Ctext%29%24%2F&type=code\e[0m"`
echo -e "\e[35mnuclei template\e[0m: " `find ~/.local/nuclei-templates/code/cves/ -iname "*$1*"`
echo -e "\e[35mexploitdb\e[0m"
searchsploit $1
echo -e "\e[35mmetasploit exploits\e[0m"
msfconsole -q -x "search $1;exit"
