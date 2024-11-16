local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
    automatically_reload_config = true,
    enable_tab_bar = false,
    window_close_confirmation = "NeverPrompt",
    window_decorations = "RESIZE",
    default_cursor_style = "SteadyBlock",
    font_size = 18,
    window_background_opacity = 0.8,
    macos_window_background_blur = 10,
}

return config
