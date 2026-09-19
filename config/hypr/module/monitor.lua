hl.monitor({
    output   = "HDMI-A-3",
    position = "1600x0",
    scale    = "1",
})

hl.monitor({
    output   = "eDP-1",
    position = "0x0",
    scale    = "1.60",
})

for i = 1, 10, 1 do
    if i <= 5 then
        hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-3", default = true })
    else
        hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1", default = true })
    end
end
