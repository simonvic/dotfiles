set nocompatible
filetype plugin on
set path+=**
set wildmenu

set nowrap
set number
syntax on
colorscheme simonvic

set ts=2 sw=2 et

let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1


let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=blue ctermbg=8
