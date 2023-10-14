local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n"
--   insert_mode = "i"
--   visual_mode = "v"
--   visual_block_mode = "x"
--   term_mode = "t"
--   command_mode = "c"

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- wrapline up and down move
keymap("n", "k", "gk", opts)
keymap("n", "gk", "k", opts)
keymap("n", "j", "gj", opts)
keymap("n", "gj", "j", opts)

keymap("n", "<C-p>", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<C-e>", "<cmd>Telescope buffers cwd_only=true sort_mru=true<cr>", opts)
keymap("n", "<leader>b", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)
-- keymap("n", "<leader>b", "<cmd>Telescope coc diagnostics<cr>", opts)
keymap("n", "<leader>*", "<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand('<cword>')})<cr>",
  opts)

-- Command --
-- sudo write
keymap("c", "w!!", "w !sudo tee % >/dev/null", { noremap = true })
keymap("c", "<C-p>", "<Up>", { noremap = true })
keymap("c", "<C-n>", "<Down>", { noremap = true })

-- Move --
-- Keep cursor line vertically centered in vim
-- keymap("n", "j", "jzz", opts)
-- keymap("n", "k", "kzz", opts)
