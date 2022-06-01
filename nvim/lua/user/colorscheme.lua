-- vim.cmd [[
-- try
--   "colorscheme darkplus
--   colorscheme material
--   " colorscheme apprentice
--   " highlight Comment ctermbg=NONE ctermfg=240 cterm=NONE guibg=NONE guifg=#808080 gui=NONE
--   " highlight CursorLine ctermbg=236 ctermfg=NONE cterm=NONE guibg=#903040 guifg=NONE gui=NONE
--   " highlight LineNr guibg=NONE
--   " highlight VertSplit ctermbg=NONE guibg=NONE
-- catch /^Vim\%((\a\+)\)\=:E185/
--   colorscheme default
--   set background=dark
-- endtry
-- ]]

-- -- Default options
require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = false,    -- Disable setting background
    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,   -- Non focused panes set to alternative background
    styles = {              -- Style to be applied to different syntax groups
      comments = "NONE",    -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "NONE",
      keywords = "NONE",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "NONE",
    },
    inverse = {             -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = {             -- List of various plugins and additional options
      -- ...
    },
  }
})

-- setup must be called before loading
vim.cmd("colorscheme nordfox")

-- vim.g.seoulbones = {
--   -- lightness = 'bright',
--   darkness = 'warm',
-- }
--
-- vim.cmd [[
-- set termguicolors
-- set background=dark
--
-- colorscheme seoulbones
-- ]]
