local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Everforest Dark (Gogh)"

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 14

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

return config
