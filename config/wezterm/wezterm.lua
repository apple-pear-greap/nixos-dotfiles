local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = 'Tokyo Night'

config.font = wezterm.font_with_fallback {
	'JetBrainsMono Nerd Font',
	'Symbols Nerd Font Mono',
	'Noto Color Emoji',
}
config.font_size = 16

-- Transparent background; works in Wayland when decorations are client-side.
config.window_background_opacity = 0.85
config.text_background_opacity = 0.85

-- In Niri, remove client borders/titlebar to avoid double frames.
config.window_decorations = "NONE"

-- Prefer Wayland backend under Niri.
config.enable_wayland = true

-- Tidy tabs.
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
	left = 6,
	right = 6,
	top = 4,
	bottom = 0,
}

return config
