" Encoding
set encoding=utf-8
set fileencoding=utf-8

set nowrap
set nocompatible
filetype off

" PLUGINS
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'

Plugin 'Valloric/YouCompleteMe'
Plugin 'othree/csscomplete.vim'

Plugin 'Xuyuanp/nerdtree-git-plugin'

call vundle#end()


" enable syntax and plugins (for netrw)
syntax enable

set number
syntax on
colorscheme darcula
filetype plugin indent on

" FINDING FILES
set path+=**
set wildmenu

" TAG JUMPING
command! MakeTags !ctags -R .

" FILE BROWSING:
" Start nerdtree
autocmd vimenter * NERDTree
let g:NERDTreeBookmarksSort=0

" Tweaks for browsing
"let g:netrw_banner=0        " disable annoying banner
"let g:netrw_liststyle=3     " tree view
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

set ts=4 sw=4 et
      

" INDENTATION:
let g:indentLine_char = '│'
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2

" JAVA
let g:syntastic_java_checkers = []

" CSS
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci



" PERSONALIZATION
set termguicolors
let g:lightline = { 'colorscheme': 'darcula' }


set cursorline
augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END
