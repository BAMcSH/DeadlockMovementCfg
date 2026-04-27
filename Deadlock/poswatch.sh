#!/bin/bash

pat="setpos_exact ([[:space:]0-9.-]*);"
init=0

dldir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
log="${dldir}/game/citadel/console.log"
pos="${dldir}/game/citadel/cfg/lastpos.cfg"
echo $pos

if [[ ! -f "$log" ]]; then
    echo "Error: File not found - $log"
    exit 1
fi

tail -f "$log" | while IFS= read -r line; do
    if [[ ! $init ]]; then
		init=1
	else
		# Check the regex
		if [[ $line =~ $pat ]]; then
			echo "setpos ${BASH_REMATCH[1]}" > "${pos}"
		fi
	fi
done

read -p "Press Enter to continue..."