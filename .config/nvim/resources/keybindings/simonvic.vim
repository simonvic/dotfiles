""""""""""""""""""""""""""""""""""""""""""""""
"" MAIN

" saving
noremap <silent> <C-S>     :write<CR>
vnoremap <silent> <C-S>    <C-C>:write<CR>
inoremap <silent> <C-S>    <C-O>:write<CR>

" undo
noremap <silent> <C-z>     :undo<CR>
vnoremap <silent> <C-z>    <C-C>:undo<CR>
inoremap <silent> <C-z>    <C-O>:undo<CR>

" redo
noremap <silent> <C-y>     :redo<CR>
vnoremap <silent> <C-y>    <C-C>:redo<CR>
inoremap <silent> <C-y>    <C-O>:redo<CR>

" focus left/down/up/right window
nnoremap <A-LEFT>          <C-w>h
nnoremap <A-DOWN>          <C-w>j
nnoremap <A-UP>            <C-w>k
nnoremap <A-RIGHT>         <C-w>l

" move current window to left/down/up/right
nnoremap <A-S-LEFT>        <C-W>H
nnoremap <A-S-DOWN>        <C-W>J
nnoremap <A-S-UP>          <C-W>K
nnoremap <A-S-RIGHT>       <C-W>L

" misc
inoremap <C-space>         <C-n>
inoremap <C-H>             <C-w>
inoremap <C-DEL>           <C-o>dw



""""""""""""""""""""""""""""""""""""""""""""""
"" WINDOWS

" Buffers
map <A-PageUp>             <Cmd>BufferLineCycleNext<CR>
map <A-PageDown>           <Cmd>BufferLineCyclePrev<CR>
map <A-C-PageUp>           <Cmd>BufferLineMoveNext<CR>
map <A-C-PageDown>         <Cmd>BufferLineMovePrev<CR>

" NERDTree
" map <A-1>                  <Cmd>NERDTreeFocus<CR>
" tmap <A-1>                 <Cmd>NERDTreeFocus<CR>
" imap <A-1>                 <Cmd>NERDTreeFocus<CR>
" map <A-2>                  <Cmd>NERDTreeClose<CR>
" imap <A-2>                 <Cmd>NERDTreeClose<CR>

" NvimTree
map <A-1>                  <Cmd>NvimTreeFocus<CR>
tmap <A-1>                 <Cmd>NvimTreeFocus<CR>
imap <A-1>                 <Cmd>NvimTreeFocus<CR>
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


