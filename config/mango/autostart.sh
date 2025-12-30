#!/run/current-system/sw/bin/bash
# 自启动脚本 仅作参考

set +e

# obs
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots >/dev/null 2>&1

# wallpaper
swaybg -i ~/Pictures/WallPapers/wallHysilens.png >/dev/null 2>&1 &

# top bar
waybar -c ~/nixos-dotfiles/config/waybar/config.json -s ~/nixos-dotfiles/config/waybar/style.css >/dev/null 2>&1 &


# ime input
fcitx5 --replace -d >/dev/null 2>&1 &

# keep clipboard content
# wl-clip-persist --clipboard regular --reconnect-tries 0 >/dev/null 2>&1 &

# clipboard content manager
# wl-paste --type text --watch cliphist store >/dev/null 2>&1 &

# bluetooth 
blueman-applet >/dev/null 2>&1 &

# network
nm-applet >/dev/null 2>&1 &

# Permission authentication
# /usr/lib/xfce-polkit/xfce-polkit >/dev/null 2>&1 &

# inhibit by audio
# sway-audio-idle-inhibit >/dev/null 2>&1 &

# change light value and volume value by swayosd-client in keybind
# swayosd-server >/dev/null 2>&1 &
