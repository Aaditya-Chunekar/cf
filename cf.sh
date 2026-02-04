#!/usr/bin/env bash
set -euo pipefail
n=$#
# semicolon is reqd. only when do or then is on the same line
# always quote - "*$anything*"
if [ "$1" = '-r' ] || [ "$1" = '--recommend' ]
then
	printf "Problems recommended for $2 are:\n"
	seen=$(curl -s https://codeforces.com/api/user.status?handle=$2 | tr '{' '\n' | grep index | cut -d "," -f 1,2 | sort | uniq)
	prob=$(curl -s https://codeforces.com/api/problemset.problems | tr '{' '\n' | grep solvedCount | sort -t: -k4,4nr| cut -d "," -f 1,2)
	for line in $seen
	do
		# printf "line is %s\n" "$line"
		# below 'true' is necesasary to counter set -e
		if printf "$prob" | grep -q "$line" || true
		then

			prob=$(printf "$prob" | grep -v "$line")
			
		fi
	done
	# falling left backslash for multiline cmd in script
	printf "%s\n" "$prob" | head -n 5 | cut -d '"' -f 3,6 | \
	tr ',' '/' | tr -d '"' | \
	sed 's|:|https://codeforces.com/problemset/problem/|g'
	exit 0
fi
#write finding largest 'length of arg' above and replace 15 with it
printf "%-15s %-6s %-10s %-10s %-12s\n" "handle" "rating" "maxRating" "nContests" "contribution"
printf "%-15s %-6s %-10s %-10s %-12s\n" "------" "------" "---------" "---------" "------------"
#understand above lines and change number based on max string length from args
for arg in "$@"
do
	res=$(curl -s "https://codeforces.com/api/user.info?handles=$arg")
	userRating=$(curl -s "https://codeforces.com/api/user.rating?handle=$arg")
	sts=$(echo "$res" | cut -d ":" -f 2 | cut -d "," -f 1)
	if [ "$sts" =  '"OK"' ]; then
		# printf "\e[4m$arg\e[0m exists.\n"
		
		if printf "$res" | grep -q 'maxRating' ; then
			handle=$arg
			maxRating=$(printf "$res" | tr "," "\n"| grep 'maxRating' | cut -d ":" -f 2)
			rating=$(printf "$res" | tr "," "\n"| grep 'rating' | cut -d ":" -f 2)
			nContests=$(printf "$userRating" | tr "," "\n" | grep -c 'newRating')
			contribution=$(printf "$res" | tr "," "\n"| grep 'contribution' | cut -d ":" -f 2)
			printf "%-15s %-6s %-10s %-10s %-12s\n" "$handle" "$rating" "$maxRating" "$nContests" "$contribution"
		fi
		# printf "$(echo $res | awk -F':' '{print $NF}' | cut -d '}' -f 1) is the latest rating.\n" 
	fi
done


