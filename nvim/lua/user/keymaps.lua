local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

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

keymap("n", "<space>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<C-p>", ":Telescope find_files<CR>", opts)
keymap("n", "<C-e>", ":Telescope buffers<CR>", opts)