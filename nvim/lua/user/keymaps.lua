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
keymap("n", "<C-e>", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "gr", "<cmd>Telescope lsp_references include_current_line=false include_declaration=false<cr>", opts)
keymap("n", "gi", "<cmd>Telescope lsp_implementations jump_type=vsplit ignore_filename=false<cr>", opts)
keymap("n", "<leader>b", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)
