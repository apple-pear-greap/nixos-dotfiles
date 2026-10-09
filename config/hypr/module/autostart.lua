local autostart = {
  "fcitx5 -d",
  "~/.config/waybar/waybar-launcher.sh hyprland",
  "foot -s",
  "swaybg -i ~/.config/hypr/wallpaper/VodOdetta.jpg",
  "wl-paste --type text --watch cliphist store",
  "wl-paste --type image --watch cliphist store",
  "systemctl --user start plasma-polkit-agent.service",
}

hl.on("hyprland.start", function()
  for _, value in pairs(autostart) do
    hl.exec_cmd(value)
  end
end)
