-- Shorten function name
local keymap = vim.api.nvim_set_keymap

vim.cmd([[
set tagfunc=CocTagFunc

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:gotoTag(tagkind) abort
  let l:current_tag = expand('<cWORD>')

  let l:current_position = getcurpos()
  let l:current_position[0] = bufnr()

  let l:current_tag_stack = gettagstack()
  let l:current_tag_index = l:current_tag_stack['curidx']
  let l:current_tag_items = l:current_tag_stack['items']

  if CocAction('jump' . a:tagkind)
    let l:new_tag_index = l:current_tag_index + 1
    let l:new_tag_item = [{'tagname': l:current_tag, 'from': l:current_position}]
    let l:new_tag_items = l:current_tag_items[:]
    if l:current_tag_index <= len(l:current_tag_items)
      call remove(l:new_tag_items, l:current_tag_index - 1, -1)
    endif
    let l:new_tag_items += l:new_tag_item

    call settagstack(winnr(), {'curidx': l:new_tag_index, 'items': l:new_tag_items}, 'r')
  endif
endfunction

nmap <silent> gd :call <SID>gotoTag("Definition")<CR>
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi :call <SID>gotoTag("Implementation")<CR>
" nmap <silent> gr :call <SID>gotoTag("Used")<CR>
nmap <silent> gi :Telescope coc implementations<CR>
nmap <silent> gr :Telescope coc references<CR>

nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

]])

-- keymap("n", "<leader>.", "<Plug>(coc-codeaction)", {})
-- keymap("n", "<leader>l", ":CocCommand eslint.executeAutofix<CR>", {})
-- keymap("n", "gd", "<Plug>(coc-definition)", {silent = true})
-- -- keymap("n", "gD", "<Plug>(coc-declaration)", {silent = true})
-- keymap("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
-- keymap("n", "gi", "<Plug>(coc-implementation)", {silent = true})
-- -- keymap("n", "gr", ":call CocAction('Used')<CR>", {silent = true})
-- keymap("n", "gr", "<Plug>(coc-references)", {silent = true})
keymap("n", "K", ":call CocActionAsync('doHover')<CR>", {silent = true, noremap = true})
keymap("n", "<leader>rn", "<Plug>(coc-rename)", {})
-- keymap("n", "<leader>rf", "<Plug>(coc-refactor)", {})
keymap("n", "<leader>f", ":CocCommand prettier.formatFile<CR>", {noremap = true})
keymap("i", "<C-Space>", "coc#refresh()", { silent = true, expr = true })
-- keymap("i", "<TAB>", "pumvisible() ? '<C-n>' : '<TAB>'", {noremap = true, silent = true, expr = true})
-- keymap("i", "<S-TAB>", "pumvisible() ? '<C-p>' : '<C-h>'", {noremap = true, expr = true})
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

require('telescope').load_extension('coc')
