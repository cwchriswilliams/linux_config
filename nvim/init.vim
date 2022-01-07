set nocompatible
set smartcase
set mouse=a
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set number
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set nornu | endif
augroup end
filetype plugin indent on
filetype plugin on
set ttyfast
set cursorline
set wildmode=longest,list
syntax on
set clipboard=unnamedplus








