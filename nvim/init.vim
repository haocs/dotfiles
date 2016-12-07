"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Neovim config
"" Author: Hao
"" Email: git@haoc.io
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Basic {
  " Dir {
    set undodir=~/.undo//
    set undofile
    set nobackup
    set noswapfile
    " set backupdir=~/.backup//
    " set backupext=~bk
    " set writebackup
    " set directory=~/.swp//
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
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1

  " Basic {
    set nolinebreak               " don't wrap at words, messes up copying
    set visualbell
    set wildmode=longest,list,full
    set wildmenu
    set numberwidth=3        " minimun width to use for the number column.
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
    " Map Leader to ,
    let mapleader=','

    " Window navigation {
      " Allow Alt + {h, j, k, l} to navigate between windows
      " In all mode including Terminal
      :tnoremap <A-h> <C-\><C-n><C-w>h
      :tnoremap <A-j> <C-\><C-n><C-w>j
      :tnoremap <A-k> <C-\><C-n><C-w>k
      :tnoremap <A-l> <C-\><C-n><C-w>l
      :nnoremap <A-h> <C-w>h
      :nnoremap <A-j> <C-w>j
      :nnoremap <A-k> <C-w>k
      :nnoremap <A-l> <C-w>l
    " }

    " Split
    noremap <Leader>h :<C-u>split<CR>
    noremap <Leader>v :<C-u>vsplit<CR>

    " Tabs
    nnoremap <Tab> gt
    nnoremap <S-Tab> gT
    nnoremap <silent> <S-t> :tabnew<CR>

    " Terminal {
      nnoremap <silent> <Leader>t :terminal<CR>
      " exit 'terminal' mode
      :tnoremap <Esc> <C-\><C-n>
    "}

    " Set working directory
    nnoremap <Leader>. :lcd %:p:h<CR>

    " Buffer nav
    noremap <Leader>q :bp<CR>
    noremap <Leader>w :bn<CR>

    " Close buffer
    noremap <Leader>c :bd<CR>

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
      Plug 'tpope/vim-commentary'
      Plug 'airblade/vim-gitgutter'
      Plug 'tpope/vim-fugitive'

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

  " NERDTree {
      set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
      let g:NERDTreeChDirMode=2
      let NERDTreeShowHidden=1
      let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
      "let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
      let g:NERDTreeShowBookmarks=1
      let g:nerdtree_tabs_focus_on_files=1
      let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
      let g:NERDTreeWinSize=30

      " NERDTree KeyMapping
      " Locate current file in file systems
      nnoremap <silent> <Leader>l :NERDTreeFind<CR>
      noremap <F2> :NERDTreeToggle<CR>
      " Close NERDTree if no other window open
      autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  " }

  " vim-commentray {
      " to support other file type
      " autocmd FileType apache setlocal commentstring=#\ %s
  " }

  " fugitive-git {
    " noremap <Leader>ga :Gwrite<CR>
    " noremap <Leader>gc :Gcommit<CR>
    " noremap <Leader>gsh :Gpush<CR>
    " noremap <Leader>gll :Gpull<CR>
    noremap <Leader>gs :Gstatus<CR>
    noremap <Leader>gb :Gblame<CR>
    noremap <Leader>gd :Gvdiff<CR>
    " noremap <Leader>gr :Gremove<CR>
  " }

  " Color-thems {
      colorscheme molokai
      set background=dark
  " }

  " Unite {
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    nnoremap <Leader>f :<C-u>Unite file_rec/neovim<CR>
    nnoremap <Leader>e :<C-u>Unite -no-split -buffer-name=mru file_mru<cr>
    nnoremap <Leader>b :<C-u>Unite -quick-match buffer<cr>
    nnoremap <Leader>r :<C-u>Unite -no-split -buffer-name=register register<CR>

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

    " deoplete tab-complete
    inoremap <expr><tab> pumvisible() ? "\<c-n>" :"\<tab>"
  " }

"" }
