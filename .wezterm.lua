local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Macchiato"

config.font = wezterm.font("Fira Code Nerd Font")
config.font_size = 15

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

return config
