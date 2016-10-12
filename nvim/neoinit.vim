" ***************************************************************************
""
"" Hao`s NeoVim Config
""
"*****************************************************************************

"*****************************************************************************
"" Plugin Setup
"*****************************************************************************
"Vim-Plug {
let s:vim_plug_dir=expand($HOME.'/.config/nvim/autoload')

if !filereadable(s:vim_plug_dir.'/plug.vim')
    execute '!wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -P '.s:vim_plug_dir
    let s:install_plug=1
endif

call plug#begin('$HOME/.config/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot' " Language packs
Plug 'vim-scripts/CSApprox'
Plug 'mbbill/undotree'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/syntastic'
Plug 'Shougo/deoplete.nvim' " auto complete
Plug 'editorconfig/editorconfig-vim'
" Golang Plugs
Plug 'fatih/vim-go'
" Python Plugs
Plug 'davidhalter/jedi-vim'
Plug 'Yggdroot/indentLine'

" colors
" Some themes working for neovim.
Plug 'tomasr/molokai'
"Plug 'freeo/vim-kalisi'
" Plug 'morhetz/gruvbox'

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

" Map leader to ,
let mapleader=','

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
colors molokai

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

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

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

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Use system clipboard with yank and paste
if executable("xclip")
  set clipboard+=unnamedplus
endif

"*****************************************************************************
"" Mappings
"*****************************************************************************
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

" Ctags
map <F12> :! ctags -R .<cr>

"*****************************************************************************
"" Plugs  config
"*****************************************************************************
"
