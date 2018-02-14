set nocompatible

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format
Plugin 'gmarik/vundle'

" We could also add repositories with a ".git" extension
Plugin 'scrooloose/nerdtree.git'

" To get plugins from Vim Scripts, you can reference the plugin
" by name as it appears on the site
Plugin 'Buffergator'

" Now we can turn our filetype functionality back on
filetype plugin indent on




set background=dark
set number
set tabstop=4
set shiftwidth=4
set expandtab
syntax on
set autoindent
set smartindent
set ic
set backspace=2
set hlsearch 
set mouse=a

