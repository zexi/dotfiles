-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- vim.cmd [[
-- set tagfunc=CocTagFunc
-- ]]

-- keymap("n", "<leader>.", "<Plug>(coc-codeaction)", {})
-- keymap("n", "<leader>l", ":CocCommand eslint.executeAutofix<CR>", {})
keymap("n", "gd", "<Plug>(coc-definition)", {silent = true})
-- keymap("n", "gD", "<Plug>(coc-declaration)", {silent = true})
keymap("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keymap("n", "gi", "<Plug>(coc-implementation)", {silent = true})
-- keymap("n", "gr", ":call CocAction('Used')<CR>", {silent = true})
keymap("n", "gr", "<Plug>(coc-references)", {silent = true})
keymap("n", "K", ":call CocActionAsync('doHover')<CR>", {silent = true, noremap = true})
keymap("n", "<leader>rn", "<Plug>(coc-rename)", {})
-- keymap("n", "<leader>rf", "<Plug>(coc-refactor)", {})
keymap("n", "<leader>f", ":CocCommand prettier.formatFile<CR>", {noremap = true})
keymap("i", "<C-Space>", "coc#refresh()", { silent = true, expr = true })
keymap("i", "<TAB>", "pumvisible() ? '<C-n>' : '<TAB>'", {noremap = true, silent = true, expr = true})
keymap("i", "<S-TAB>", "pumvisible() ? '<C-p>' : '<C-h>'", {noremap = true, expr = true})
keymap("i", "<CR>", "pumvisible() ? coc#_select_confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'", {silent = true, expr = true, noremap = true})

vim.o.hidden = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300
vim.o.cmdheight = 2
vim.g.coc_global_extensions = {
  -- 'coc-translator',
  -- 'coc-explorer',
  'coc-lists',
  'coc-json',
  -- 'coc-jedi',
  'coc-pyright',
  -- 'coc-vimlsp',
  'coc-clangd',
  'coc-css',
  'coc-tsserver',
  -- 'coc-vetur',
  -- 'coc-emmet',
  'coc-highlight',
  'coc-java',
  'coc-rls',
  -- 'coc-go'
}
