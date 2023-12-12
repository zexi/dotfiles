vim.cmd [[
  augroup _restore_last_cursor_position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    " autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    " autocmd FileType markdown setlocal spell
    autocmd FileType markdown setlocal expandtab tabstop=4 shiftwidth=4 smarttab softtabstop=4
    autocmd FileType tex setlocal expandtab tabstop=2 shiftwidth=2 smarttab softtabstop=2
  augroup end

  augroup _file_type_setting
    autocmd!
    autocmd FileType ruby,yaml,eruby,vim,json setlocal expandtab shiftwidth=2 tabstop=2
    autocmd FileType tmux,vim setlocal expandtab shiftwidth=2 tabstop=2 foldmethod=marker
    autocmd FileType html,css,scss,javascript,lua,vue setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    "" autocmd FileType sh,expect,python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4 colorcolumn=80
    autocmd FileType sh,expect,python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4
    autocmd FileType c,cpp,dot setlocal sw=4 tabstop=4 colorcolumn=80
    autocmd FileType text,gitcommit setlocal colorcolumn=72
    autocmd FileType go,make setlocal sw=4 tabstop=4 noexpandtab
    autocmd FileType java,haskell setlocal expandtab tabstop=4 shiftwidth=4 smarttab softtabstop=4
  augroup end

""  augroup _cursor_line
""    au!
""    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
""    au WinLeave * setlocal nocursorline
""  augroup end
]]

local wr_group = vim.api.nvim_create_augroup('WinResize', { clear = true })

vim.api.nvim_create_autocmd(
  'VimResized',
  {
    group = wr_group,
    pattern = '*',
    command = 'wincmd =',
    desc = 'Automatically resize windows when the host window size changes.'
  }
)
