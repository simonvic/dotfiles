" Encoding
set encoding=utf-8
set fileencoding=utf-8

set nowrap
set nocompatible
filetype off

" PLUGINS
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Plugin 'gmarik/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'

" Plugin 'Valloric/YouCompleteMe'
Plugin 'othree/csscomplete.vim'
Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

call vundle#end()


" enable syntax and plugins (for netrw)
syntax enable

set number
syntax on
colorscheme darcula
" colorscheme darculaTransparent
filetype plugin indent on

" FINDING FILES
set path+=**
set wildmenu

" TAG JUMPING
command! MakeTags !ctags -R .

" FILE BROWSING:
" Start nerdtree
" autocmd vimenter * NERDTree
let g:NERDTreeBookmarksSort=0
execute "set <M-1>=\e1"
execute "set <M-2>=\e2"
nnoremap <M-1> :NERDTreeFocus<CR>
nnoremap <M-2> :NERDTreeClose<CR>

" Auto complete 
inoremap <Nul> <C-n>
set smartcase

" CAMEL CASE
" Use one of the following to define the camel characters.
" Stop on capital letters.
let g:camelchar = "A-Z"
" Also stop on numbers.
let g:camelchar = "A-Z0-9"
" Include '.' for class member, ',' for separator, ';' end-statement,
" and <[< bracket starts and "'` quotes.
let g:camelchar = "A-Z0-9.,;:{([`'\""
nnoremap <silent><C-Left> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
nnoremap <silent><C-Right> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>
inoremap <silent><C-Left> <C-o>:call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
inoremap <silent><C-Right> <C-o>:call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>
vnoremap <silent><C-Left> :<C-U>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>v`>o
vnoremap <silent><C-Right> <Esc>`>:<C-U>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>v`<o

" auto closing stuff 
inoremap " ""<left>
inoremap ' ''<left>
"inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" deletion
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

" saving
noremap <silent> <C-S>          :write<CR>
vnoremap <silent> <C-S>         <C-C>:write<CR>
inoremap <silent> <C-S>         <C-O>:write<CR>

" undo / redo
noremap <silent> <C-z>          :undo<CR>
vnoremap <silent> <C-z>         <C-C>:undo<CR>
inoremap <silent> <C-z>         <C-O>:undo<CR>

noremap <silent> <C-y>          :redo<CR>
vnoremap <silent> <C-y>         <C-C>:redo<CR>
inoremap <silent> <C-y>         <C-O>:redo<CR>



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

set autoindent
set noexpandtab
set tabstop=4

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
