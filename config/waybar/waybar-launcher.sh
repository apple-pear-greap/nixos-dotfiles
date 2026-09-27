#!/usr/bin/env bash

set +e

WAYBAR=$HOME/nixos-config/config/waybar
pkill waybar

if [ $1 = "mango" ]
then
  waybar -c "$WAYBAR/mango/config.jsonc" -s "$WAYBAR/mango/style.css" >/dev/null 2>&1 &
else [ $1 = "hyprland" ]
  waybar -c "$WAYBAR/hyprland/config.jsonc" -s "$WAYBAR/hyprland/style.css" >/dev/null 2>&1 &
fi
