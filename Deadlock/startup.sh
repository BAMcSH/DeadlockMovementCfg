#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

if [[ $# -eq 0 ]]; then
    echo "Usage: Set Deadlock Steam launch options to:"
    echo "  \"${SCRIPT_DIR}/startup.sh\" %command%"
    exit 1
fi

"$@" -dev -condebug &

"${SCRIPT_DIR}/MoveTool_linux.sh"
