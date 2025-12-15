local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = 'Tokyo Night'

config.font = wezterm.font_with_fallback {
	'JetBrains Mono',
	'Symbols Nerd Font Mono',
	'Noto Color Emoji',
}
config.font_size = 16

config.window_background_opacity = 0.9
config.text_background_opacity = 1.0

config.window_decorations = "RESIZE"

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

return config
