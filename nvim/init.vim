" set the runtime path to include Vundle and initialize
call plug#begin('~/.nvim/plugged')

" let Vundle manage Vundle, required
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'buoto/gotests-vim'
Plug 'wlangstroth/vim-racket'
Plug 'tpope/vim-fugitive'
Plug 'chriskempson/base16-vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-repeat'
Plug 'dhruvasagar/vim-table-mode'
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'mzlogin/vim-markdown-toc'
Plug 'lervag/vimtex'
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'honza/vim-snippets'

" nvim
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

" All of your Plugins must be added before the following line
call plug#end()

filetype plugin on
set wildmenu
set wildmode=longest:list,full
set history=1000
set number
set showcmd
set ignorecase

set hls
set incsearch
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" quick manage $MYVIMRC
nnoremap <leader>so :source $MYVIMRC<cr>
nnoremap <leader>conf :e $MYVIMRC<cr>

" restore last cursor position
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

syntax on
set termguicolors
set background=dark
set nocompatible

" view operation
set mouse=a
set fillchars+=vert:│
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

colorscheme base16-tomorrow-night-eighties
highlight LineNr guibg=NONE
highlight VertSplit ctermbg=NONE guibg=NONE
"colorscheme Tomorrow-Night-Eighties
"colorscheme base16-atelier-dune
"colorscheme PaperColor
"let g:nord_bold = 0
if has('gui_running')
	set guioptions-=T
	set guioptions-=m
	set guifont=Monaco:h15
else
	set t_Co=256
endif

" conf for language
" Enable filetype-specific plugins
" disable the automatic insertion of comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType ruby,yaml,eruby,vim,json setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType tmux,vim setlocal expandtab shiftwidth=2 tabstop=2 foldmethod=marker
autocmd FileType html,css setlocal expandtab shiftwidth=2 tabstop=2 smartindent smarttab softtabstop=2
autocmd FileType sh,expect setlocal expandtab shiftwidth=4 tabstop=4 smartindent
autocmd FileType c,cpp,dot setlocal sw=4 tabstop=4 cindent
autocmd FileType go setlocal sw=4 tabstop=4 noexpandtab
autocmd FileType javascript,java setlocal expandtab tabstop=4 shiftwidth=4 smarttab softtabstop=4
autocmd FileType tex,markdown setlocal expandtab tabstop=2 shiftwidth=2 smarttab softtabstop=2

" conf for window split {{{
" We can use different key mappings for easy navigation between splits to save
" a keystroke. So instead of ctrl-w then j, it’s just ctrl-j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open new split panes to right and bottom, which feels more natural than
" Vim’s default:
set splitbelow
set splitright
" }}}

" sudo write
cmap w!! w !sudo tee % >/dev/null

" auto-pairs {{{
"let g:AutoPairsMapSpace = 0
" }}}

" racket {{{
if has("autocmd")
  au BufReadPost *.rkt,*.rktl,*.scm set filetype=racket
  au filetype racket set lisp
  au filetype racket set autoindent
  au filetype racket let b:autopairs_enabled = 0
endif
" }}}

" tex configuration {{{
let g:tex_flavor = 'latex'
let g:vimtex_compiler_latexmk = {
  \ 'options' : [
  \   '-pdf',
  \   '-pdflatex="xelatex --shell-escape %O %S"',
  \   '-verbose',
  \   '-file-line-error',
  \   '-synctex=1',
  \   '-interaction=nonstopmode',
  \ ]
  \}
" }}}

" markdown configuration {{{
" disable folding
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_folding_disabled = 1
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
" vim table mode
function! s:isAtStartOfLine(mapping)
let text_before_cursor = getline('.')[0 : col('.')-1]
let mapping_pattern = '\V' . escape(a:mapping, '\')
let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
        \ <SID>isAtStartOfLine('\|\|') ?
        \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
        \ <SID>isAtStartOfLine('__') ?
        \ '<c-o>:silent! TableModeDisable<cr>' : '__'
" For Markdown-compatible tables use
let g:table_mode_corner="|"
" }}}

" for easymotion configuration {{{
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
"}}}

" session management {{{
let g:sessions_dir = "~/.vim/sessions"
exec 'nnoremap <Leader>ss :Obsession ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
"exec 'nnoremap <Leader>sr :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'
nnoremap <silent> <Leader>sr  :<C-u>CocList sessions<cr>
" toggle pause session observe
nnoremap <Leader>sp :Obsession<CR>
" end of session management }}}

lua << EOF

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'gopls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
EOF
