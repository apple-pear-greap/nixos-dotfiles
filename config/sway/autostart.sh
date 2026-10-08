#!/usr/bin/env bash

set +e

$HOME/nixos-config/config/waybar/waybar-launcher.sh sway 2>&1 &
fcitx5 --replace -d >/dev/null 2>&1 &

# keep clipboard content
wl-clip-persist --clipboard regular --reconnect-tries 0 >/dev/null 2>&1 &
# clipboard content manager
wl-paste --type text --watch cliphist store >/dev/null 2>&1 &

foot -s &
