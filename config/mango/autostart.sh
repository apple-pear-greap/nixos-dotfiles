#!/usr/bin/env bash

set +e

swaybg -i ~/nixos-config/wallpapers/Vesna.png >/dev/null 2>&1 &

$HOME/nixos-config/config/waybar/waybar-launcher.sh mango 2>&1 &
fcitx5 --replace -d >/dev/null 2>&1 &

# keep clipboard content
wl-clip-persist --clipboard regular --reconnect-tries 0 >/dev/null 2>&1 &

# clipboard content manager
wl-paste --type text --watch cliphist store >/dev/null 2>&1 &
