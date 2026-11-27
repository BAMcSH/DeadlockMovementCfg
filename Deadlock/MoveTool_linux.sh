#!/bin/bash

dldir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
log="${dldir}/game/citadel/console.log"
pos="${dldir}/game/citadel/cfg/lastpos.cfg"
pat='setpos_exact ([[:space:]0-9.-]*);'

[[ -f "$pos" ]] || echo "setpos 0 0 0" > "$pos"

trap 'kill $(jobs -p) 2>/dev/null' EXIT

# -n 0: skip existing lines, -F: follow by name (handles file recreation by Proton)
while IFS= read -r line; do
    if [[ $line =~ $pat ]]; then
        echo "setpos ${BASH_REMATCH[1]}" > "$pos"
    fi
    [[ $line == *"Source2Shutdown"* ]] && break
done < <(tail -n 0 -F "$log" 2>/dev/null)
