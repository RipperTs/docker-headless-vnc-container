#!/usr/bin/env bash
set -e

exec /opt/google/chrome/google-chrome \
    --no-sandbox \
    --disable-gpu \
    --disable-dev-shm-usage \
    --ozone-platform=x11 \
    --start-maximized \
    "--window-size=${VNC_RESOLUTION/x/,}" \
    --window-position=0,0 \
    "$@"
