" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')

" let Vundle manage Vundle, required
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
"Plug 'fatih/vim-go'
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
"Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'antoinemadec/coc-fzf'
"Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
Plug 'mattn/emmet-vim'
" Plug 'gyim/vim-boxdraw'
" Plug 'vim-scripts/DrawIt'
Plug 'tpope/vim-rsi'
"Plug 'itchyny/vim-haskell-indent'

" All of your Plugins must be added before the following line
call plug#end()    " required

" coc global extensions to install
let g:coc_global_extensions = [
  \ 'coc-translator',
  \ 'coc-explorer',
  \ 'coc-lists',
  \ 'coc-json',
  \ 'coc-python',
  \ 'coc-vimlsp',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-emmet',
  \ 'coc-tsserver',
  \ 'coc-clangd',
  \ 'coc-vetur',
  \ ]

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
autocmd FileType html,css,javascript,lua setlocal shiftwidth=2 tabstop=2 softtabstop=2 autoindent
autocmd FileType sh,expect setlocal expandtab shiftwidth=4 tabstop=4 smartindent
autocmd FileType c,cpp,dot setlocal sw=4 tabstop=4 cindent colorcolumn=80
autocmd FileType text,gitcommit setlocal colorcolumn=80
autocmd FileType go setlocal sw=4 tabstop=4 noexpandtab
autocmd FileType java,haskell setlocal expandtab tabstop=4 shiftwidth=4 smarttab softtabstop=4
autocmd FileType tex,markdown setlocal expandtab tabstop=4 shiftwidth=4 smarttab softtabstop=4

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

hi Normal guibg=NONE ctermbg=NONE
let t:is_transparent = 1
function! ToggleTransparentBackground()
  if t:is_transparent == 1
    "hi Normal guibg=#111111 ctermbg=black
    set background=dark
    let t:is_transparent = 0
  else
    hi Normal guibg=NONE ctermbg=NONE
    let t:is_transparent = 1
  endif
endfunction
nnoremap <C-x><C-t> :call ToggleTransparentBackground()<CR>

" sudo write
cmap w!! w !sudo tee % >/dev/null

" nerdcommenter {{{
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
"}}}

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

" vim-go {{{
"let g:go_pls_enabled = 1
"let g:go_gopls_options = ['-remote=auto']
""let g:go_def_mode = 'gopls'
"let g:go_info_mode = 'gopls'
"" disable vim-go :GoDef short cut (gd)
"" this is handled by LanguageClient [LC]
"let g:go_def_mapping_enabled = 0
"" show type info in statusbar
" let g:go_auto_type_info = 1
"let g:go_fmt_autosave = 0
"let g:go_def_reuse_buffer = 1
"autocmd FileType go nmap gd <Plug>(go-def-vertical)
"autocmd FileType go nmap <C-]> <Plug>(go-def)
"autocmd FileType go nmap  g] <Plug>(go-implements)
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

" <Leader>f{char} to move to {char}
" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" Need one more keystroke, but on average, it may be more comfortable.
" nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)
"}}}

" coc.nvim default settings {{{
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

set signcolumn=auto

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <C-l> for trigger snippet expand.
"imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
"vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
"let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
"let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
"imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

"" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
" tagstack gotoTag
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

"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gd :call CocAction('jumpDefinition', 'drop')<cr>
nmap <silent> gd :call <SID>gotoTag("Definition")<CR>
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gi :call <SID>gotoTag("Implementation")<CR>
"nmap <silent> gr :call <SID>gotoTag("References")<CR>
nmap <silent> gr :call <SID>gotoTag("Used")<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-refactor)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

"" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" auto format go code and add missing imports
"autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" status line
" Add diagnostic info for https://github.com/itchyny/lightline.vim
function! CocCurrentFucntion()
  "return CocAction("getCurrentFunctionSymbol")
  return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentFunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentFunction': 'CocCurrentFucntion'
      \ },
      \ }

" Using CocFzfList
let g:fzf_layout = {'window': {'width': 0.9, 'height': 0.6}}
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocFzfList diagnostics<cr>
" Show diagnostics current buffer
nnoremap <silent> <space>b  :<C-u>CocFzfList diagnostics --current-buf<CR>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocFzfList commands<cr>
" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>l  :<C-u>CocFzfList location<CR>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocFzfList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocFzfList symbols<cr>
nnoremap <silent> <space>S  :<C-u>CocFzfList services<cr>
" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocFzfListResume<CR>

" coc explore
nmap <space>e :CocCommand explorer<CR>

" coc translator
" popup
nmap <Leader>t <Plug>(coc-translator-p)
vmap <Leader>t <Plug>(coc-translator-pv)
" echo
nmap <Leader>e <Plug>(coc-translator-e)
vmap <Leader>e <Plug>(coc-translator-ev)
" replace
nmap <Leader>r <Plug>(coc-translator-r)
vmap <Leader>r <Plug>(coc-translator-rv)

"set completeopt=noinsert,noselect,menuone

" fzf.vim maps
function! s:fzf_next(idx)
  let commands = ['Files', 'Buffers', 'History']
  execute commands[a:idx]
  let next = (a:idx + 1) % len(commands)
  let previous = (a:idx - 1) % len(commands)
  execute 'tnoremap <buffer> <silent> <c-f> <c-\><c-n>:close<cr>:sleep 100m<cr>:call <sid>fzf_next('.next.')<cr>'
  "execute 'tnoremap <buffer> <silent> <Tab> <c-\><c-n>:close<cr>:sleep 100m<cr>:call <sid>fzf_next('.next.')<cr>'
  execute 'tnoremap <buffer> <silent> <c-b> <c-\><c-n>:close<cr>:sleep 100m<cr>:call <sid>fzf_next('.previous.')<cr>'
  "execute 'tnoremap <buffer> <silent> <S-Tab> <c-\><c-n>:close<cr>:sleep 100m<cr>:call <sid>fzf_next('.previous.')<cr>'
endfunction

command! FzfCycle call <sid>fzf_next(0)

nnoremap <C-p> :FzfCycle<Cr>
nnoremap <C-e> :Buffers<CR>
nnoremap <C-f> :Ag<CR>
nnoremap <leader>ct :Colors<CR>
nnoremap <space>w :Windows<CR>
nnoremap <space>t :TagbarToggle<cr>
nnoremap <space>h :History<cr>

" terminal mode
"tnoremap <Esc> <C-\><C-n>
"if has("nvim")
  "au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  "au FileType fzf tunmap <buffer> <Esc>
"endif
" end of coc and fzf configuration }}}

" session management {{{
let g:sessions_dir = "~/.vim/sessions"
exec 'nnoremap <Leader>ss :Obsession ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
"exec 'nnoremap <Leader>sr :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'
nnoremap <silent> <Leader>sr  :<C-u>CocList sessions<cr>
" toggle pause session observe
nnoremap <Leader>sp :Obsession<CR>
" end of session management }}}

" html/css ocnfig {{{
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
" autocmd FileType html,css let b:autopairs_enabled = 0
autocmd FileType html let b:AutoPairs = AutoPairsDefine({'>' : '<'}, [])
"}}}
