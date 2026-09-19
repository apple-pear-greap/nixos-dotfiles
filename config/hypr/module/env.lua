local env = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto",

    XCURSOR_SIZE = "28",
    XCURSOR_THEME = "adwaita",
}

for key,value in pairs(env) do
    hl.env(key,value)
end
