-- require 'web-tools'.setup({
--   keymaps = {
--     rename = nil, -- by default use same setup of lspconfig
--     -- repeat_rename = '.',  -- . to repeat
--   },
--   hurl = {                -- hurl default
--     show_headers = false, -- do not show http headers
--     floating = false,     -- use floating windows (need guihua.lua)
--     formatters = {        -- format the result by filetype
--       json = { 'jq' },
--       html = { 'prettier', '--parser', 'html' },
--     },
--   },
-- })

-- https://github.com/NvChad/nvim-colorizer.lua
require 'colorizer'.setup {
  filetypes = {
    'css',
    'javascript',
    html = { mode = 'foreground', }
  },
}
