#!/usr/bin/env bash
set -euo pipefail
VERSION="1.0.0"
n=$#
# semicolon is reqd. only when do or then is on the same line
# always quote - "*$anything*"

#write finding largest 'length of arg' above and replace 15 with it
printf "%-15s %-10s\n" "handle" "maxRating"
printf "%-15s %-10s\n" "------" "---------"
#understand above lines and change number based on max string length from args
for arg in "$@"
do
	res=$(curl -s "https://codeforces.com/api/user.info?handles=$arg")
	sts=$(echo "$res" | cut -d ":" -f 2 | cut -d "," -f 1)
	if [ "$sts" =  '"OK"' ]; then
		# printf "\e[4m$arg\e[0m exists.\n"
		
		if printf "$res" | grep -q 'maxRating' ; then
			handle=$arg
			maxRating=$(printf "$res" | tr "," "\n"| grep 'maxRating' | cut -d ":" -f 2)
			printf "%-15s %-10s\n" "$handle" "$maxRating"
		fi
		# printf "$(echo $res | awk -F':' '{print $NF}' | cut -d '}' -f 1) is the latest rating.\n" 
	fi
done


