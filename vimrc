set nocompatible	" be iMproved, required
"filetype off		" required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'marijnh/tern_for_vim'
"Plugin 'vim-ruby/vim-ruby'
Plugin 'slim-template/vim-slim.git'
"Plugin 'jiangmiao/auto-pairs'
Plugin 'Raimondi/delimitMate'
Plugin 'christophermca/meta5'
Plugin 'jscappini/material.vim'
" Plugin 'x1596357/vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'
" Plugin 'Lokaltog/vim-powerline'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
Plugin 'edkolev/tmuxline.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'chriskempson/base16-vim'
Plugin 'morhetz/gruvbox'
Plugin 'altercation/vim-colors-solarized'
Plugin 'lervag/vimtex'
"Plugin 'rosenfeld/conque-term'
Plugin 'rking/ag.vim'
Plugin 'nvie/vim-flake8'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'mattn/emmet-vim'
Plugin 'wannesm/wmgraphviz.vim'
"Plugin 'sjl/vitality.vim'
Plugin 'godlygeek/tabular'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'sjl/gundo.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'tmhedberg/SimpylFold'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/syntastic'
Plugin 'benekastah/neomake'
Plugin 'kchmck/vim-coffee-script'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'lfilho/cosco.vim'

" All of your Plugins must be added before the following line
call vundle#end()	" required
filetype plugin indent on " required

filetype plugin on
set hls
set hidden
set incsearch
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
set wildmenu
set wildmode=full
set history=1000
set number
set showcmd
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
" 命令行模式增强，ctrl - a到行首， -e 到行尾
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" conf of default YCM
let g:ycm_global_ycm_extra_conf = '/home/lzx/.ycm_extra_conf.py'
nnoremap <leader>gl :YcmCompleter GoToDefinition<CR>
"nnoremap <leader>jd :YcmCompleter GoTo<CR>
let g:ycm_complete_in_comments = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1

" set solarized color theme
syntax on
set background=dark
"let g:solarized_termcolors=256
"let g:solarized_termtrans = 1
"set background=light
"colorscheme solarized

"colorscheme deepsea
"colorscheme desert256
"let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
"colorscheme jellybeans
"colorscheme Tomorrow-Night-Eighties
"colorscheme zenburn
"let g:seoul256_background = 233
"colorscheme seoul256
" conf for gvim
if has('gui_running')
	set guioptions-=T
	set guioptions-=m
	set guifont=monaco\ 12
else
	highlight Comment ctermfg=lightblue cterm=none
endif

" conf for vim-ruby
filetype on           " Enable filetype detection
filetype plugin on    " Enable filetype-specific plugins
autocmd FileType ruby,yaml,eruby setlocal expandtab shiftwidth=2 tabstop=2
let g:user_emmet_install_global = 0
autocmd FileType html,css setlocal expandtab shiftwidth=2 tabstop=2 smartindent smarttab softtabstop=2
autocmd FileType html,css EmmetInstall
autocmd FileType sh,expect setlocal expandtab shiftwidth=4 tabstop=4 smartindent
autocmd FileType c,cpp,dot setlocal sw=4 tabstop=4 cindent
autocmd FileType python,go,javascript setlocal expandtab tabstop=4 shiftwidth=4 smarttab softtabstop=4
autocmd FileType tex,markdown setlocal expandtab tabstop=2 shiftwidth=2 smarttab softtabstop=2

" conf for airline
set laststatus=2
" let g:Powerline_symbols='unicode'
let g:tmuxline_powerline_separators = 0
"let g:airline_theme='durant'

" conf for vim-latex
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'

" conf for Ag
let g:ag_prg="/usr/bin/ag --vimgrep"

" conf for ctags
let g:ctags_statusline=1

" conf for flake8
let g:flake8_ignore='W291,W391,E123,E124,E125,E126,E127,E128,E221,E225,E226,E261,E262,E272,E302,E501,E502'
"autocmd BufWritePost *.py call Flake8()

" conf for window split
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

" config for buffer
"map <C-z> :bp<cr>
"map <C-x> :bn<cr>

" for vim-indent-guides
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" sudo write
cmap w!! w !sudo tee % >/dev/null

" for Tabularize
nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a,, :Tabularize /,\zs<CR>
vmap <Leader>a,, :Tabularize /,\zs<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

" for easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap <Leader>s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" for gundo
nnoremap <Leader>u :GundoToggle<CR>

" for white space mode
highlight ExtraWhitespace ctermbg=red

" Use a blinking upright bar cursor in Insert mode, a blinking block in normal
if &term == 'xterm-256color' || &term == 'screen-256color'
    let &t_SI = "\<Esc>[5 q"
    let &t_EI = "\<Esc>[1 q"
endif

if exists('$TMUX')
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
endif

" for ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
" for python fold
"let g:SimpylFold_fold_import = 0
let g:SimpylFold_docstring_preview = 1
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
set nofoldenable

" for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore=W291,W391,E123,E124,E125,E126,E127,E128,E221,E225,E226,E261,E262,E272,E302,E501,E502'
let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
"nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>
nmap <Leader>Sd :SyntasticToggleMode<CR>
" Neomake
autocmd! BufWritePost * Neomake
" 80th highlighted
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" coffee script
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

set clipboard=unnamed
set clipboard+=unnamedplus

" vim-repeat
silent! call repeat#set("\<Plug>unimpaired.vim", v:count)

" cosco.vim
autocmd FileType javascript,css nmap <silent> <Leader>; <Plug>(cosco-commaOrSemiColon);
autocmd FileType javascript,css imap <silent> <Leader>; <c-o><Plug>(cosco-commaOrSemiColon)
autocmd FileType javascript,css let g:auto_comma_or_semicolon = 1
nmap <Leader>ic :AutoCommaOrSemiColonToggle<CR>

" ultisnips
let g:UltiSnipsExpandTrigger="<c-f>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-m>"

function! ExpandSnippet()
    if delimitMate#WithinEmptyPair()
        return "\<C-R>=delimitMate#ExpandReturn()\<CR>"
    else
        call UltiSnips#ExpandSnippet()
        if g:ulti_expand_res == 0
            return "\<CR>"
        endif
    endif
    return ""
endfunction
inoremap <expr> <CR> "\<C-R>=ExpandSnippet()\<CR>"
