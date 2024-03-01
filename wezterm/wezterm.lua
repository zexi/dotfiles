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
config.bold_brightens_ansi_colors = 'BrightAndBold'
config.font = wezterm.font_with_fallback {
  'Hack Nerd Font',
  'Monaco',
  'Kaiti SC',
}

config.hide_tab_bar_if_only_one_tab = true
-- https://github.com/wez/wezterm/issues/3774#issuecomment-1791730581
-- config.freetype_load_flags = 'NO_HINTING'
config.audible_bell = 'Disabled'

return config
