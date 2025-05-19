" To open a fold, press "zo"
" To close a fold, press "zc"
" To toggle a fold, press "za"
" To open all folds, press "zR"
" To close all folds, press "zM"
" ----------------------------- "

" Visual Options {{{
" Tabs {{{
set tabstop=4			" number of visual spaces per TAB
set softtabstop=4		" number of spaces in tab when editing
set shiftwidth=4		" insert 4 spaces on a tab
"set expandtab			" insert spaces when the TAB key is pressed
" }}}

" UI {{{
set cul					" highlight the current line (cul = cursorline)
set encoding=UTF-8		" set encoding to UTF-8
set foldenable			" enable folding
set foldlevelstart=10	" open most folds by defaults
"set go=a				" formatoptions
set laststatus=2		" enable top status bar
set lazyredraw			" redraw only when needed
set linebreak			" break long lines properly
set mouse=a				" enable mouse
set noshowmode			" don't show the current mode
set number				" show numbers at the left side of the terminal
set relativenumber		" numbers on the left side are relative to the cursor position
set ruler				" show cursor position in status line
set showmatch			" show matching opening/closing brackets
set showtabline=2		" show the top status bar
set splitbelow			" open new vertical split bottom
set splitright			" open new horizontal splits right
set title titlestring=	" set terminal title to filename
set ttyfast				" use fast terminal
set wrap				" wrap long lines onto the next line in the display
syntax on				" enable syntax highlighting
" }}}

" Search {{{
set hlsearch			" highlight search results
set ignorecase			" case insensitive search
set incsearch			" search as characters are entered
set smartcase			" smart case matching
" }}}

" Indentation {{{
set autoindent			" copy the previous line's indentation level
set cindent				" advanced automatic identation for C & C++
set smartindent			" automatically indent new lines properly
" }}}

" Spell-checking {{{
"set spell				" enable spell-checking
set spelllang=en_us		" set spell-checking language to en_US
" }}}

" Syntax highlighting {{{
set complete+=kspell	" use the spell-checker as completion source
set wildmenu			" show menu auto-completion options
set wildmode=longest,list,full
" }}}
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

" Remaps {{{
" NOTE: <CR> means line break/enter

" Set spell check to <leader>o (\o; orthography)
map <leader>o :setlocal spell!<CR>

" Plugins {{{
" Use "s" to navigate with EasyMotion
"
" Note:
" B, E, W -> word: characters separated by whitespace
" b, e, w -> word: characters separated by whitespace or punctuation
"
" Hint: use these motions:
"	Quick move:
"		s{w,W}  -> Go to the beginning of next word
"		s{e,E}  -> Go to the end of next word
"		s{b,B}  -> Go to the beginning of previous word
"		sg{e,E} -> Go to the end of previous word
"
"	Search:
"		sf{char} -> Go to next {char}
"		sF{char} -> Go to previous {char}
"		st{char} -> Go to next {char}, one space before
"		sT{char} -> Go to previous {char}, one space after
map s <Plug>(easymotion-prefix)

" Use s + hjkl for better navigation
map sh <Plug>(easymotion-linebackward)
map sj <Plug>(easymotion-j)
map sk <Plug>(easymotion-k)
map sl <Plug>(easymotion-lineforward)

" Toggle Neotree with \l
map <leader>l :Neotree toggle<CR>
" }}}

" Clipboard {{{
" NOTE: needs gvim or neovim for clipboard capabilities
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

" }}}

" Plugins {{{
" vim plug: https://github.com/junegunn/vim-plug
" install packages by running :PlugInstall
" update packages by running  :PlugUpdate
" upgrade vim-plug by running :PlugUpgrade
call plug#begin('~/.vim/plugged')

" Color schemes {{{
" Tokyonight (:colorscheme tokyonight-{,night,storm,day,moon)
Plug 'folke/tokyonight.nvim'
" }}}

" Statusbar {{{
Plug 'itchyny/lightline.vim'				" vim status bar
Plug 'sainnhe/lightline_foobar.vim'			" lightline color schemes
Plug 'delphinus/lightline-delphinus'		" lightline color scheme
" }}}

" Syntax {{{
Plug 'andymass/vim-matchup'					" better matching via %
Plug 'sheerun/vim-polyglot'					" better file syntax
Plug 'w0rp/ale'								" asynchronous lint engine
Plug 'windwp/nvim-ts-autotag'				" automatically close HTML tags
Plug 'windwp/nvim-autopairs'				" auto pair & close brackets and quotes

" Tree sitter integration & better syntax highlighting
" Note: you also need to run :TSInstall <lang>,
" where <lang> is the language you want.
" I use the following:
" bash, c, cpp, css, html, javascript, markdown, php, scss, vim
" To update installed files, run :TSUpdate
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" }}}

" Neotree {{{
Plug 'nvim-lua/plenary.nvim' " neotree dependency
Plug 'MunifTanjim/nui.nvim' " neotree dependency
Plug 'nvim-neo-tree/neo-tree.nvim'
" }}}

" Eye candy {{{
Plug 'mhinz/vim-startify'					" show startup message
Plug 'ryanoasis/vim-devicons'				" add icons to vim
Plug 'lewis6991/gitsigns.nvim'				" git integration
Plug 'lukas-reineke/indent-blankline.nvim'	" show indent guides
Plug 'TheGLander/indent-rainbowline.nvim'	" show colored indents
" }}}

" Others {{{
Plug 'easymotion/vim-easymotion'			" move quicker
Plug 'm4xshen/hardtime.nvim'				" break bad movement habits
" }}}
call plug#end()
" }}}

" Colors {{{

" set color scheme to dogrun
" this line will be modified if running in a TTY
colorscheme tokyonight-moon

" set proper colors
if $TERM =~ '^\(rxvt\|screen\|interix\|putty\|linux\)\(-.*\)\?$'
  set notermguicolors
  colorscheme koehler
elseif (has("termguicolors"))
  set termguicolors
endif

" }}}

" Plugin Options {{{
" Hardtime
lua <<EOF
require("hardtime").setup({
	disable_mouse = false,
	disabled_filetypes = {},
	disabled_keys = {
		-- re-enable arrow keys
	   ["<Up>"] = false,
	   ["<Down>"] = false,
	   ["<Left>"] = false,
	   ["<Right>"] = false,
	},

	-- either "block" or "hint"
	restriction_mode = "hint"
});
EOF

" EasyMotion options
let g:EasyMotion_smartcase = 1		" v will match both v and V, but V will match V only
let g:EasyMotion_startofline = 0	" keep cursor column when JK motion

" Autoclose brackets & quotes
" Do not add closing pair if already present in the same line
lua <<EOF
require("nvim-autopairs").setup({
	enable_check_bracket_line = false
});
EOF

" automatically close "<" {{{
lua <<EOF
local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

npairs.add_rules({
	Rule("<", ">", {"php", "blade"})
})
EOF
" }}}

" auto center the current line when inserting enter inside curly brackets {{{
lua <<EOF
require("nvim-autopairs").get_rule("{"):replace_map_cr(function()
	local res = '<c-g>u<CR><CMD>normal! ====<CR><up><end><CR>'
	local line = vim.fn.winline()
	local height = vim.api.nvim_win_get_height(0)
	-- Check if current line is within [1/3, 2/3] of the screen height.
	-- If not, center the current line.
	if line < height / 3 or height * 2 / 3 < line then
		-- Here, 'x' is a placeholder to make sure the indentation doesn't break.
		res = res .. 'x<ESC>zzs'
	end
	return res
end)
EOF
" }}}

" Gitsigns
lua require("gitsigns").setup();

" Indent-rainbowline
lua require("ibl").setup(require("indent-rainbowline").make_opts(opts));

" Tree Sitter
lua <<EOF
require("nvim-treesitter.configs").setup({
	ensure_installed = {"bash", "c", "cpp", "css", "html", "javascript", "lua", "markdown", "php", "scss", "vim"},

	highlight = {
		enable = true
	}
});
EOF

" TS-Autotag
lua <<EOF
require("nvim-ts-autotag").setup({
	opts = {
		enable_close_on_slash = true
	}
});
EOF

" Lightline-delphinus
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
	\ 'colorscheme': 'tokyonight',
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

" ALE settings
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_keep_list_window_open=0
let g:ale_set_quickfix=0
let g:ale_list_window_size = 5
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \}
let g:ale_fix_on_save = 1

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

" DO NOT REMOVE THIS LINE
" vim:foldmethod=marker:foldlevel=0
