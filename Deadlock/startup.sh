#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

if [[ $# -eq 0 ]]; then
    echo "Usage: Set Deadlock Steam launch options to:"
    echo "  \"${SCRIPT_DIR}/startup.sh\" %command%"
    exit 1
fi

"$@" -dev -condebug -fullscreen -no_environment_maps -high -novid \
    -softparticlesdefaultoff +mat_disable_fancy_blending -m_rawinput 1 \
    +@panorama_min_comp_layer_cache_cost_TURNED_OFF 256 &

"${SCRIPT_DIR}/poswatch.sh"
