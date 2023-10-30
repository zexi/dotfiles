vim.cmd [[
let g:test#preserve_screen = 1
let g:test#neovim#start_normal = 1
let g:test#echo_command = 1

nmap <silent> ,r :TestNearest -strategy=toggleterm<CR>
]]
