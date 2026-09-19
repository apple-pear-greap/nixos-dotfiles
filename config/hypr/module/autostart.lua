local autostart = {
    "fcitx5 -d",
    "waybar",
    "foot -s",
    "swaybg -i ~/.config/hypr/wallpaper/VodOdetta.jpg",
    "wl-paste --type text --watch cliphist store",
    "wl-paste --type image --watch cliphist store",
}

hl.on("hyprland.start",function ()
    for _, value in pairs(autostart) do
       hl.exec_cmd(value)
    end
end)
