vim.cmd [[
  augroup _restore_last_cursor_position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  augroup end
]]

vim.cmd [[
  augroup _file_type_setting
    autocmd!
    autocmd FileType ruby,yaml,eruby,vim,json setlocal expandtab shiftwidth=2 tabstop=2
    autocmd FileType tmux,vim setlocal expandtab shiftwidth=2 tabstop=2 foldmethod=marker
    autocmd FileType html,css,scss,javascript,vue,lua setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 autoindent smartindent
    autocmd FileType sh,expect,python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4 colorcolumn=80
    autocmd FileType c,cpp,dot setlocal sw=4 tabstop=4 cindent colorcolumn=80
    autocmd FileType text,gitcommit setlocal colorcolumn=72
    autocmd FileType go setlocal sw=4 tabstop=4 noexpandtab
    autocmd FileType java,haskell setlocal expandtab tabstop=4 shiftwidth=4 smarttab softtabstop=4
    autocmd FileType tex,markdown setlocal expandtab tabstop=4 shiftwidth=4 smarttab softtabstop=4
  augroup end
]]