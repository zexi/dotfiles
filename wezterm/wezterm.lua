local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- ref: https://wezfurlong.org/wezterm/colorschemes/t/index.html#tomorrow-night
-- config.color_scheme = 'Tomorrow (dark) (terminal.sexy)'
-- config.color_scheme = 'Tomorrow Night'
-- config.color_scheme = 'GitHub Dark'
config.color_scheme = 'Vs Code Dark+ (Gogh)'
config.font = wezterm.font 'Hack Nerd Font'
config.hide_tab_bar_if_only_one_tab = true

return config
