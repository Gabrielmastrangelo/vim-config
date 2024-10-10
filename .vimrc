" ==========================
" Vim Configuration File
" ==========================
" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" ----------------------------------------
" Basic Vim Settings
" ----------------------------------------
set nocompatible            " Disable Vi compatibility mode to enable Vim features.
filetype off                " Disable file type detection temporarily.
set encoding=utf-8          " Set encoding to UTF-8.

" ----------------------------------------
" Syntax and Highlighting
" ----------------------------------------
let python_highlight_all=1  " Enable highlighting for Python files.
syntax on                    " Turn on syntax highlighting.

" ----------------------------------------
" Clipboard and Startup
" ----------------------------------------
set clipboard=unnamed        " Allow use of the system clipboard.
set shortmess+=I             " Disable the default Vim startup message.

" ----------------------------------------
" Line Numbers
" ----------------------------------------
set number                   " Show absolute line numbers.
set relativenumber           " Show relative line numbers for easier navigation.

" ----------------------------------------
" Status and User Interface
" ----------------------------------------
set laststatus=2            " Always show the status line, even with one window.

" ----------------------------------------
" Backspace Behavior
" ----------------------------------------
set backspace=indent,eol,start " Allow backspacing over everything.

" ----------------------------------------
" Buffer Management
" ----------------------------------------
set hidden                   " Allow hidden buffers to enable smoother workflow.

" ----------------------------------------
" Search Settings
" ----------------------------------------
set ignorecase               " Ignore case when searching if all characters are lowercase.
set smartcase                " Enable case sensitivity if any capital letters are used.
set incsearch                " Enable incremental search.

" ----------------------------------------
" Key Mappings
" ----------------------------------------
nmap Q <Nop>                " Unbind 'Q' to prevent accidental entry into Ex mode.

set noerrorbells visualbell t_vb= " Disable audible bell (it's annoying).
set mouse+=a                " Enable mouse support for convenience.

" Prevent using arrow keys for movement
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>

" ----------------------------------------
" Key Bindings for CtrlP Fuzzy Finder
" ----------------------------------------
let g:ctrlp_map = '<c-p>'  " Set CtrlP mapping.
let g:ctrlp_cmd = 'CtrlP'  " Set command for CtrlP.

" ----------------------------------------
" Python-Specific Settings
" ----------------------------------------
autocmd BufNewFile,BufRead *.py setfiletype python
    \ | set tabstop=4
    \ | set softtabstop=4
    \ | set shiftwidth=4
    \ | set textwidth=79
    \ | set expandtab
    \ | set autoindent
    \ | set fileformat=unix

" JavaScript, HTML, CSS Settings
autocmd BufNewFile,BufRead *.js,*.html,*.css
    \ | set tabstop=2
    \ | set softtabstop=2
    \ | set shiftwidth=2

" ----------------------------------------
" General Indentation Settings
" ----------------------------------------
filetype plugin indent on   " Enable file type detection, plugins, and indentation.
set tabstop=4               " Set tab character width to 4 spaces.
set shiftwidth=4            " Set indentation width to 4 spaces for shifting text.
set expandtab               " Convert tabs to spaces when inserting.

" ----------------------------------------
" Window Navigation
" ----------------------------------------
" Facilitate tab navigation between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ----------------------------------------
" Folding Settings
" ----------------------------------------
set foldmethod=indent       " Set folding method to indent-based.
set foldlevel=99            " Start with all folds open.
nnoremap <space> za         " Toggle folding with the spacebar.

" ----------------------------------------
" Plugin Management with Vundle
" ----------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim  " Set runtime path to include Vundle.
call vundle#begin()                  " Initialize Vundle.

" Specify Plugins to Install
Plugin 'gmarik/Vundle.vim'            " Let Vundle manage itself.
Plugin 'tmhedberg/SimpylFold'         " Folding support for Python.
Plugin 'scrooloose/nerdtree'         " File explorer.
Plugin 'Valloric/YouCompleteMe'      " Code completion.
Plugin 'vim-syntastic/syntastic'      " Syntax checking.
Plugin 'nvie/vim-flake8'              " Flake8 integration.
Plugin 'sheerun/vim-polyglot'         " Language packs.
Plugin 'morhetz/gruvbox'              " Gruvbox color scheme.

" ----------------------------------------
" Finalize Plugin Installation
" ----------------------------------------
call vundle#end()            " Required to finalize plugin installation.
filetype plugin indent on    " Enable file type detection and indentation.

" ----------------------------------------
" NERDTree Configuration
" ----------------------------------------
autocmd VimEnter * NERDTree | wincmd p  " Open NERDTree on startup.
" Exit Vim if NERDTree is the only window remaining.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endi
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif

" ----------------------------------------
" YouCompleteMe Configuration
" ----------------------------------------
let g:ycm_autoclose_preview_window_after_completion=1  " Auto-close preview window after completion.
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>  " Jump to definition.

" ----------------------------------------
" Python with Virtualenv Support
" ----------------------------------------
if has('python')
    python << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    exec(open(activate_this).read(), dict(__file__=activate_this))
EOF
endif

" ----------------------------------------
" Syntax Checking with Syntastic
" ----------------------------------------
let g:syntastic_python_checkers = ['flake8', 'pylint']  " Add preferred checkers.

" ----------------------------------------
" Color Scheme and Background
" ----------------------------------------
set background=dark         " Set background to dark (change to 'light' if preferred).
colorscheme gruvbox         " Set color scheme to gruvbox.

