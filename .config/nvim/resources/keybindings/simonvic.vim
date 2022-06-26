""""""""""""""""""""""""""""""""""""""""""""""
"" ACTIONS

" center current line
nnoremap <A-S-c>           zz
inoremap <A-S-c>           <C-o>zz
vnoremap <A-S-c>           zz

" copy
"vnoremap y ygv

" saving
noremap  <silent> <C-s>    <Cmd>write<CR>
inoremap <silent> <C-s>    <Cmd>write<CR>
vnoremap <silent> <C-s>    <Cmd>write<CR>

" undo
noremap  <silent> <C-z>    <Cmd>undo<CR>
inoremap <silent> <C-z>    <Cmd>undo<CR>
vnoremap <silent> <C-z>    <Cmd>undo<CR>gv

" redo
noremap  <silent> <C-y>    <Cmd>redo<CR>
inoremap <silent> <C-y>    <Cmd>redo<CR>
vnoremap <silent> <C-y>    <Cmd>redo<CR>gv

" completition
inoremap <C-SPACE>         <C-n>


""""""""""""""""""""""""""""""""""""""""""""""
"" MOVEMENT

" Go previous word end
nnoremap <C-LEFT>          b
inoremap <C-LEFT>          <C-o>b
vnoremap <C-LEFT>          b

" Go next word end
nnoremap <C-RIGHT>         e
inoremap <C-RIGHT>         <C-o>e<RIGHT>
vnoremap <C-RIGHT>         e

" Go to first character
nnoremap <HOME>            ^
inoremap <HOME>            <C-o>^
vnoremap <HOME>            ^

" Go to start of line
nnoremap <A-HOME>          0
inoremap <A-HOME>          <C-o>0
vnoremap <A-HOME>          0

" Go to last character
nnoremap <END>             g_
vnoremap <END>             g_

" Go to last character
nnoremap <A-END>           $
inoremap <A-END>           <C-o>$
vnoremap <A-END>           $



""""""""""""""""""""""""""""""""""""""""""""""
"" SELECTION

" Select all
nnoremap <C-a>             ggg0vG
inoremap <C-a>             <ESC>ggg0vG
vnoremap <C-a>             <ESC>ggg0vG


" Select to left
nnoremap <S-LEFT>          v<LEFT>
inoremap <S-LEFT>          <C-o>v<LEFT>
vnoremap <S-LEFT>          <LEFT>

" Select to right
nnoremap <S-RIGHT>         v<RIGHT>
inoremap <S-RIGHT>         <C-o>v<RIGHT>
vnoremap <S-RIGHT>         <RIGHT>

" Select to up
nnoremap <S-UP>            v<UP>
inoremap <S-UP>            <C-o>v<UP>
vnoremap <S-UP>            <UP>

" Select to down
nnoremap <S-DOWN>          v<DOWN>
inoremap <S-DOWN>          <C-o>v<DOWN>
vnoremap <S-DOWN>          <DOWN>

" Select previous word end
nnoremap <S-C-LEFT>        vb
inoremap <S-C-LEFT>        <LEFT><C-o>vb
vnoremap <S-C-LEFT>        b

" Select next word end
nnoremap <S-C-RIGHT>       ve
inoremap <S-C-RIGHT>       <C-o>ve
vnoremap <S-C-RIGHT>       e

" Select to first character
nnoremap <S-HOME>          v^
inoremap <S-HOME>          <LEFT><C-o>v^
vnoremap <S-HOME>          ^

" Select to start of line
nnoremap <S-A-HOME>        v0
inoremap <S-A-HOME>        <LEFT><C-o>v0
vnoremap <S-A-HOME>        0

" Select to last character
nnoremap <S-END>           vg_
inoremap <S-END>           <C-o>vg_
vnoremap <S-END>           g_

" Select to last character
nnoremap <S-A-END>         v$
inoremap <S-A-END>         <C-o>v$
vnoremap <S-A-END>         $


""""""""""""""""""""""""""""""""""""""""""""""
"" EDITING

" Delete line
nnoremap <S-DEL>              dd
inoremap <S-DEL>              <C-o>dd

" Delete rear/front word
inoremap <C-H>                <C-w>
inoremap <C-DEL>              <C-o>dw

" move down
nnoremap <silent> <C-A-DOWN>  <Cmd>move +1<CR>
inoremap <silent> <C-A-DOWN>  <Cmd>move +1<CR>
vnoremap <silent> <C-A-DOWN>  :move '>+1<CR>gv

" move up
nnoremap <silent> <C-A-UP>    <Cmd>move -2<CR>
inoremap <silent> <C-A-UP>    <Cmd>move -2<CR>
vnoremap <silent> <C-A-UP>    :move '<-2<CR>gv

" duplicate down
nnoremap <C-S-DOWN>           <Cmd>copy +0<CR>
inoremap <C-S-DOWN>           <Cmd>copy +0<CR>
vnoremap <C-S-DOWN>           :copy '<-1<CR>gv

" duplicate up
nnoremap <C-S-UP>             <Cmd>copy -1<CR>
inoremap <C-S-UP>             <Cmd>copy -1<CR>
vnoremap <C-S-UP>             :copy '>+0<CR>gv

" reindent file
nnoremap <C-A-l>              magg=G`a
inoremap <C-A-l>              <ESC>magg=G`aa

" reindent selection
vnoremap <C-A-l>              <ESC>ma'<='>`a

" reformat file
" nnoremap <C-L>           
" inoremap <C-L>           

""""""""""""""""""""""""""""""""""""""""""""""
"" WINDOWS

" focus left/down/up/right window
nnoremap <A-LEFT>          <C-w>h
nnoremap <A-DOWN>          <C-w>j
nnoremap <A-UP>            <C-w>k
nnoremap <A-RIGHT>         <C-w>l

inoremap <A-LEFT>          <C-o><C-w>h
inoremap <A-DOWN>          <C-o><C-w>j
inoremap <A-UP>            <C-o><C-w>k
inoremap <A-RIGHT>         <C-o><C-w>l

" move current window to left/down/up/right
nnoremap <A-S-LEFT>        <C-w>H
nnoremap <A-S-DOWN>        <C-w>J
nnoremap <A-S-UP>          <C-w>K
nnoremap <A-S-RIGHT>       <C-w>L

inoremap <A-S-LEFT>        <C-o><C-w>H
inoremap <A-S-DOWN>        <C-o><C-w>J
inoremap <A-S-UP>          <C-o><C-w>K
inoremap <A-S-RIGHT>       <C-o><C-w>L

" Buffers
map  <A-PageUp>            <Cmd>BufferLineCycleNext<CR>
imap <A-PageUp>            <Cmd>BufferLineCycleNext<CR>

map  <A-PageDown>          <Cmd>BufferLineCyclePrev<CR>
imap <A-PageDown>          <Cmd>BufferLineCyclePrev<CR>

map  <A-C-PageUp>          <Cmd>BufferLineMoveNext<CR>
imap <A-C-PageUp>          <Cmd>BufferLineMoveNext<CR>

map  <A-C-PageDown>        <Cmd>BufferLineMovePrev<CR>
imap <A-C-PageDown>        <Cmd>BufferLineMovePrev<CR>

" NERDTree
" map <A-1>                  <Cmd>NERDTreeFocus<CR>
" tmap <A-1>                 <Cmd>NERDTreeFocus<CR>
" imap <A-1>                 <Cmd>NERDTreeFocus<CR>
" map <A-2>                  <Cmd>NERDTreeClose<CR>
" imap <A-2>                 <Cmd>NERDTreeClose<CR>

" NvimTree
map <A-1>                  <Cmd>NvimTreeFocus<CR>
tmap <A-1>                 <Cmd>NvimTreeFocus<CR>
imap <A-1>                 <Cmd>NvimTreeFocus<CR><ESC>
map <A-2>                  <Cmd>NvimTreeClose<CR>
imap <A-2>                 <Cmd>NvimTreeClose<CR>

" terminal
map <A-ò>                  <Cmd>FloatermToggle<CR>
tmap <A-ò>                 <Cmd>FloatermToggle<CR>
tnoremap <Esc>             <C-\><C-n>

" Telescope
map <C-p>                  <Cmd>Telescope find_files hidden=true<CR>
map <C-A-p>                <Cmd>Telescope lsp_workspace_symbols<CR>
map <A-Tab>                <Cmd>Telescope buffers theme=dropdown<CR>
map <C-f>                  <Cmd>Telescope current_buffer_fuzzy_find<CR>
map <C-A-f>                <Cmd>Telescope live_grep<CR>
lua <<EOF
local actions = require('telescope.actions')
require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close
			},
		},
	}
}
EOF
