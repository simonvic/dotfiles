"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" BEHAVIOUR
set nowrap
set ignorecase
set smartcase
set mouse=a
set noexpandtab
set tabstop=4
set sw=4
set clipboard=unnamedplus
set splitright
set splitbelow


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" APPEARANCE
set cursorline
set number
set termguicolors
colorscheme darcula
highlight Comment gui=italic

" hide tilde on end of buffer
hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

set listchars=eol:¬,tab:>\ ,trail:~,extends:>,precedes:<,space:⋅
set list

" make listhchars visible only when selected
hi NonText ctermfg=bg guifg=bg

