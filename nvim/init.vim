

"" Basic {
  " Dir {
    set undodir=~/.undo//
    set undofile
    set backupdir=~/.backup//
    set directory=~/.swp//
  " }

  " Encoding {
    set encoding=utf-8
    set fileencoding=utf-8
    set fileencodings=utf-8
  " }

  " Tabs {
    set tabstop=4
    set softtabstop=0
    set shiftwidth=4
    set expandtab
    set autoindent
  " }


  " Search {
    set hlsearch
    set incsearch
    set ignorecase
    set smartcase
  " }

  " Others {
    set fileformats=unix,dos,mac
    set showcmd
    set hidden
    set backspace=indent,eol,start    " Fix backspace indent
    set mousemodel=popup
  " }

"" }

"" Visual {
  " let $NVIM_TUI_ENABLE_TRUE_COLOR=1

  " Basic {
    set nolinebreak               " don't wrap at words, messes up copying
    set visualbell
    set wildmode=longest,list,full
    set wildmenu
  " }

  " Syntax {
    syntax on
    syntax enable
  " }

  " Cursor {
    set ruler
    set number
    set cursorline
    set scrolloff=3
  "}

  " Tab {
    set list                      " Show tabs differently
    set listchars=tab:>-          " Use >--- for tabs
  " }


  " Use modeline overrides
  set modeline
  set modelines=10

  " Status {
    set title
    set titleold="Terminal"
    set titlestring=%F
    set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (L\ %l\/%L,\ C\ %c)
  " }
""}

"" Key-mapping {
  " Abbreviations {
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
  "}

  " Mapping {
    " Map leader to ,
    let mapleader=','

    " Split
    noremap <Leader>h :<C-u>split<CR>
    noremap <Leader>v :<C-u>vsplit<CR>

    " Tabs
    nnoremap <Tab> gt
    nnoremap <S-Tab> gT
    nnoremap <silent> <S-t> :tabnew<CR>

    " Terminal {
      nnoremap <silent> <leader>sh :terminal<CR>
      " exit 'terminal' mode
      :tnoremap <Esc> <C-\><C-n>
    "}

    " Set working directory
    nnoremap <leader>. :lcd %:p:h<CR>

    " Buffer nav
    noremap <leader>q :bp<CR>
    noremap <leader>w :bn<CR>

    " Close buffer
    noremap <leader>c :bd<CR>

    " Clean search (highlight)
    nnoremap <silent> <leader><space> :noh<cr>
  " }
"" }

"" Plugins {

  let s:vim_plug_dir=expand('~/.config/nvim/autoload')

  " Vim-Plug {
    if !filereadable(s:vim_plug_dir.'/plug.vim')
      execute '!wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -P '.s:vim_plug_dir
      let s:install_plug=1
    endif

    call plug#begin('~/.config/nvim/plugged')

      Plug 'Shougo/unite.vim'
      Plug 'Shougo/neomru.vim'
      Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
      Plug 'zchee/deoplete-jedi'
      Plug 'mbbill/undotree'
      Plug 'scrooloose/nerdtree'
      Plug 'airblade/vim-gitgutter'
      Plug 'tpope/vim-commentary'

      Plug 'sheerun/vim-polyglot' " Language packs
      Plug 'scrooloose/syntastic'
      Plug 'majutsushi/tagbar'
      Plug 'bronson/vim-trailing-whitespace'
      Plug 'editorconfig/editorconfig-vim'
      Plug 'Yggdroot/indentLine'

      " Color thems
      Plug 'tomasr/molokai'
      Plug 'freeo/vim-kalisi'
      Plug 'morhetz/gruvbox'

    call plug#end()

    if exists('s:install_plug')
      augroup PlugInstall
        au!
        au VimEnter * PlugInstall
      augroup END
    endif
  " }

  " Color-thems {
      colorscheme molokai
      set background=dark
  " }
"" }
