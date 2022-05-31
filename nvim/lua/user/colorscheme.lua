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

-- require('material.functions').change_style('darker')
-- vim.cmd[[colorscheme material]]

-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
--
-- -- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
--
-- -- Load the colorscheme
-- vim.cmd[[colorscheme tokyonight]]

-- vim.o.background = "dark" -- or "light" for light mode
--
-- -- Load and setup function to choose plugin and language highlights
-- require('lush')(require('apprentice').setup({
--   plugins = {
--     "buftabline",
--     "coc",
--     "cmp", -- nvim-cmp
--     "fzf",
--     "gitgutter",
--     "gitsigns",
--     "lsp",
--     "lspsaga",
--     "nerdtree",
--     "netrw",
--     "nvimtree",
--     "neogit",
--     "packer",
--     "signify",
--     "startify",
--     "syntastic",
--     "telescope",
--     "treesitter"
--   },
--   langs = {
--     "c",
--     "clojure",
--     "coffeescript",
--     "csharp",
--     "css",
--     "elixir",
--     "golang",
--     "haskell",
--     "html",
--     "java",
--     "js",
--     "json",
--     "jsx",
--     "lua",
--     "markdown",
--     "moonscript",
--     "objc",
--     "ocaml",
--     "purescript",
--     "python",
--     "ruby",
--     "rust",
--     "scala",
--     "typescript",
--     "viml",
--     "xml"
--   }
-- }))

require('onedark').setup {
    style = 'warm', -- 'warmer',  'darker'
    transparent = true
}
require('onedark').load()
