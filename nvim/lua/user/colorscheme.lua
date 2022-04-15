vim.cmd [[
try
  colorscheme darkplus
  " colorscheme apprentice
  " highlight Comment ctermbg=NONE ctermfg=240 cterm=NONE guibg=NONE guifg=#808080 gui=NONE
  " highlight CursorLine ctermbg=236 ctermfg=NONE cterm=NONE guibg=#903040 guifg=NONE gui=NONE
  " highlight LineNr guibg=NONE
  " highlight VertSplit ctermbg=NONE guibg=NONE
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
