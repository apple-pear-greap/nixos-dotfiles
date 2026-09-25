#!/usr/bin/env bash

set +e

WAYBAR=$HOME/nixos-config/config/waybar
pkill waybar

if [ $1 = "mango" ]
then
  waybar -c "$WAYBAR/mango/config.jsonc" -s "$WAYBAR/mango/style.css"
fi
