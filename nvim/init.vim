"***************************************************************************
"" Hao`s NeoVim Config
" ***************************************************************************

"*****************************************************************************
"" Plugin Setup
"*****************************************************************************
"
let s:vim_config_dir=expand($HOME.'/.config/nvim')

"Vim-Plug {
let s:vim_plug_dir=expand($HOME.'/.config/nvim/autoload')

if !filereadable(s:vim_plug_dir.'/plug.vim')
    execute '!wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -P '.s:vim_plug_dir
    let s:install_plug=1
endif

call plug#begin('$HOME/.config/nvim/plugged')

Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'

call plug#end()

if exists('s:install_plug')
    augroup PlugInstall
        au!
        au VimEnter * PlugInstall
    augroup END
endif
"}

"*****************************************************************************
"" Basic Setup
"*****************************************************************************
" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Fix backspace indent
set backspace=indent,eol,start

" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab


" Enable hidden buffers
set hidden

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Encoding
set bomb
set binary

" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd
set shell=/bin/sh

" session management
let g:session_directory = "$HOME/.nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
syntax enable

set ruler
set number

let no_buffers_menu=1
set background=dark

set mousemodel=popup
set cursorline
set guioptions=egmrti
set gfn=Monospace\ 10

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

" Status bar
set laststatus=2

" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"*****************************************************************************
"" Mappings
"*****************************************************************************

" Map leader to ,
let mapleader=','

" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>
" exit 'terminal' mode
:tnoremap <Esc> <C-\><C-n>

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Buffer nav
noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>

" Close buffer
noremap <leader>c :bd<CR>

" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"*****************************************************************************
"" Plugs  config
"*****************************************************************************
" Unite {
	" The prefix key.
	nnoremap    [unite]   <Nop>
	nmap    f [unite]

	call unite#filters#matcher_default#use(['matcher_fuzzy'])
	nnoremap [unite]f :<C-u>Unite file_rec/neovim<CR>
	nnoremap [unite]e :<C-u>Unite -no-split -buffer-name=mru file_mru<cr>
	nnoremap [unite]b :<C-u>Unite -quick-match buffer<cr>
	nnoremap [unite]r :<C-u>Unite -no-split -buffer-name=register register<CR>

	" Start insert.
	call unite#custom#profile('default', 'context', {
	\   'start_insert': 1
	\ })

	autocmd FileType unite call s:unite_my_settings()
	function! s:unite_my_settings()"{{{
	  " Overwrite settings.

	  imap <buffer> jj      <Plug>(unite_insert_leave)
	  "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

	  imap <buffer><expr> j unite#smart_map('j', '')
	  imap <buffer> <TAB>   <Plug>(unite_select_next_line)
	  imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
	  imap <buffer> '     <Plug>(unite_quick_match_default_action)
	  nmap <buffer> '     <Plug>(unite_quick_match_default_action)
	  imap <buffer><expr> x
	          \ unite#smart_map('x', "\<Plug>(unite_quick_match_jump)")
	  nmap <buffer> x     <Plug>(unite_quick_match_jump)
	  nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
	  imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
	  nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
	  nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
	  imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
	  nnoremap <silent><buffer><expr> l
	          \ unite#smart_map('l', unite#do_action('default'))

	  let unite = unite#get_current_unite()
	  if unite.profile_name ==# 'search'
	    nnoremap <silent><buffer><expr> r     unite#do_action('replace')
	  else
	    nnoremap <silent><buffer><expr> r     unite#do_action('rename')
	  endif

	  nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
	  nnoremap <buffer><expr> S      unite#mappings#set_current_sorters(
	          \ empty(unite#mappings#get_current_sorters()) ?


	  " Runs "split" action by <C-s>.
	  imap <silent><buffer><expr> <C-s>     unite#do_action('split')
	endfunction"}}}
" }

" deoplete { 
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#enable_smart_case = 1
" }
