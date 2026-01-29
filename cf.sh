#!/usr/bin/env bash
set -euo pipefail
VERSION="1.0.0"
n=$#
# semicolon is reqd. only when do or then is on the same line
# always quote - "*$anything*"
for arg in "$@"
do
	res=$(curl -s "https://codeforces.com/api/user.rating?handle=$arg")
	sts=$(echo "$res" | cut -d ":" -f 2 | cut -d "," -f 1)
	if [ "$sts" =  '"OK"' ]; then
		printf "\e[4m$arg\e[0m exists.\n"
		printf "$(echo $res | awk -F':' '{print $NF}' | cut -d '}' -f 1) is the latest rating.\n" 
	else
		printf "\e[4m$arg\e[0m doesn't exist.\n"
	fi
done


