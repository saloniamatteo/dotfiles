" To open a fold, press "zo"
" To close a fold, press "zc"
" To toggle a fold, press "za"
" To open all folds, press "zR"
" To close all folds, press "zM"
" ----------------------------- "

" Visual Options {{{
" show numbers at the left side of the terminal
set number
" show menu auto-completion options
set wildmenu
" highlight the current line (cul = cursorline)
set cul
" use fast terminal
set ttyfast
" redraw only when it is needed
set lazyredraw
" enable syntax
syntax on
set laststatus=2
set encoding=UTF-8
" don't show the current mode (it is shown in the status bar)
set noshowmode
" show the top status bar
set showtabline=2
set ruler
" indentation
set smartindent
set autoindent
set cindent
set wrap
set linebreak
" show matching opening/closing brackets
set showmatch
" enable mouse
set mouse=a
set go=a
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright
" Set terminal title to filename
set title titlestring=
" }}}

" OmniCompletion {{{
" enable OmniCompletion
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set tags=../tags,tags
set path+=.,../,include/,/usr/include/

" configure menu behavior
set completeopt=longest,menuone,preview
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? "\<C-n>" :
			\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
			\ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Use CTRL+Space for omni-completion
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
			\ "\<lt>C-n>" :
			\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
			\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
			\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" Popum menu Highlight Group
highlight Pmenu ctermbg=13 guibg=LightGray
highlight PmenuSel ctermbg=7 guibg=DarkBlue guifg=White
highlight PmenuSbar ctermbg=7 guibg=DarkGray
highlight PmenuThumb guibg=Black
" }}}

" Search {{{
" highlight search results
set hlsearch
" case insensitive search
set ignorecase
" smart case matching
set smartcase
" search as characters are entered
set incsearch
" }}}

" Folds {{{
" enable folding
set foldenable
" open most folds by defaults
set foldlevelstart=10
" }}}

" Remaps {{{
" NOTE: <CR> means line break/enter

" Set spell check to <leader>o (\o; orthography)
map <leader>o :setlocal spell!<CR>

" Clipboard {{{
" NOTE: needs gVim or neoVim for clipboard capabilities
" Using CTRL+C, copy the text to global clipboard and active selection
vnoremap <C-c> "*y :let @+=@*<CR>
" Using CTRL+V, paste the text from global clipboard
map <C-v> "+P
" }}}

" Navigation buttons {{{
" use gj and gk to go up and down a line visually
noremap j gj
noremap k gk

" Split tabs
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" }}}

" Tabs {{{
" Remap CTRL+T to open a new tab
noremap <C-t> :tabnew<CR>
" Remap CTRL+N to go to the next tab
noremap <C-n> :tabn<CR>
" Remap CTRL+P to go to the previous tab
noremap <C-p> :tabp<CR>
" Remap CTRL+X to close the current tab
noremap <C-x> :tabclose<CR>
" }}}

" Cscope {{{
" \fs: Find this C symbol
nnoremap <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" \fg: Find definition
nnoremap <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" \fd: Find functions called by this function
nnoremap <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" \fc: Find functions that call this function
nnoremap <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" \ft: Find this string
nnoremap <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" \fe: Find this egrep pattern
nnoremap <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" \ff: Find this file
nnoremap <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" \fi: Find files that #include this file
nnoremap <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>
" }}}

" listtrans.vim {{{
nmap ;l <Plug>ListtransToggle
vmap ;l <Plug>ListtransToggleVisual
" }}}

" Vim-vmath {
vmap <expr> ++ VMATH_YankAndAnalyse()
nmap        ++ vip++
" }
" }}}

" Plugins {{{
" vim plug: https://github.com/junegunn/vim-plug
" install packages by running :PlugInstall inside Vim
call plug#begin('~/.vim/plugged')
" -------------------- "
" Color schemes
" Dracula
Plug 'dracula/vim'
" -------------------- "
" UI
" Vim dev-icons
Plug 'ryanoasis/vim-devicons'
" Vim status bar (lightline)
Plug 'itchyny/lightline.vim'
Plug 'sainnhe/lightline_foobar.vim'
Plug 'delphinus/lightline-delphinus'
" Git integration
Plug 'lewis6991/gitsigns.nvim'
" Show indentation
Plug 'lukas-reineke/indent-blankline.nvim'
" -------------------- "
"  Better Navigation
"  Vim matchup (better % navigation)
Plug 'andymass/vim-matchup'
" -------------------- "
" Code completion
" NOTE: install `python3-venv`, `python3`, `nvim`, `sqlite`
" or these plugins will not work!
" You should also have neovim >= 0.5.x
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
" -------------------- "
" Miscellaneous utilities
" Vim-autoswap
" NOTE: install `wmctrl` on Linux; requires X11 to be running
" For more info, see project page
Plug 'gioele/vim-autoswap'
" listtrans.vim -- toggle a sentence to a comma-separated list (and viceversa)
Plug 'schoettl/listtrans.vim'
" Vim-vmath -- visual math
" Select some numbers, and press "++", the plugin will show
" the sum, average, minimum, and maximum.
" These will be accessible from the registers denoted by
" the highlighted letter in each result:
"
" Result	 Register
" sum		 s
" average	 a
" minimum	 n
" maximum	 x
" num. of items  c
" range		 r
Plug 'nixon/vim-vmath'
call plug#end()
" }}}

" Colors {{{

" set color scheme to dogrun
" this line will be modified if running in a TTY
colorscheme dracula

" use terminal colors if we have truecolor support
if (has("termguicolors"))
  set termguicolors
endif

" }}}

" Plugin Options {{{
" Start COQ silently
let g:coq_settings = { 'auto_start': 'shut-up' }

" COQ first and third-party plugins
lua require("coq_3p") {
	\ { src = "repl", sh = "bash", max_lines = 99, deadline = 500, unsafe = { "rm", "poweroff", "mv", "reboot" } },
	\ { src = "bc", short_name = "MATH", precision = 6 },
	\ { src = "figlet", short_name = "BIG" },
\ }

" Gitsigns
lua require("gitsigns").setup();

" Indentation
lua require("indent_blankline").setup();

" lightline-delphinus options
let g:lightline_delphinus_use_powerline_glyphs = 1
let g:lightline_delphinus_colorscheme = "nord_improved"

" lightline_foobar options
let g:lightline_foobar_bold = 1

" enable vim dev-icons
let g:webdevicons_enable = 1

" Make cscope silent
let g:cscope_silent = 1

" lightline settings
let g:lightline = {
	\ 'colorscheme': 'dracula',
	\ 'component': {
	\		'lineinfo': ' %3l:%-2v', 
	\ },
	\ 'component_function': {
	\	 'gitbranch': 'FugitiveHead',
	\	 'readonly': 'LightlineReadonly'
	\ },
	\ 'tab_component_function': {
	\	 'tabnum': 'LightlineWebDevIcons',
	\ },
	\ 'separator': {
	\	'right': '',
	\	'left': ''
	\ },
	\ 'subseparator': {
	\	'right': '',
	\	'left': ''
	\ },
	\ 'component_type': {
	\	'ale_error': 'error',
	\	'ale_warning': 'warning',
	\	'ale_ok': 'ok'
	\ },
	\ }

" Check filename (LightLine)
function! LightlineFilename()
	if &buftype ==# 'terminal'
		return expand('%:p')
	elseif expand('%:t') !=# ''
		return expand('%:t')
	else
		return '[No Name]'
	endif
endfunction

" Get WebDevIcon (LightLine)
function! LightlineWebDevIcons(n)
	let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
	return WebDevIconsGetFileTypeSymbol(bufname(l:bufnr))
endfunction

" Show RO symbol if read-only
function! LightlineReadonly() 
 	return &readonly ? 'RO' : '' 
endfunction 

" }}}

" Spell-checking {{{
" Enable spell-checking
set nospell

" Set spell-checking language to en_US
set spelllang=en_us

" Enable word completion
set complete+=kspell
set wildmode=longest,list,full

" }}}

" Others {{{
" Disable VimInfo & ShaDa
let viminfo="/dev/null"
let viminfofile="/dev/null"
let shada="/dev/null"
let shadafile="/dev/null"
" }}}

" DO NOT REMOVE THIS LINE
" vim:foldmethod=marker:foldlevel=0
