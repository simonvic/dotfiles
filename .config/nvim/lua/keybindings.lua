local vim = vim
local map = vim.keymap.set
vim.cmd [[
""""""""""""""""""""""""""""""""""""""""""""""
"" ACTIONS

" save
nnoremap <silent> <C-s>    <Cmd>write<CR>
inoremap <silent> <C-s>    <Cmd>write<CR>
vnoremap <silent> <C-s>    <Cmd>write<CR>

" undo
nnoremap <silent> <C-z>    <Cmd>undo<CR>
inoremap <silent> <C-z>    <Cmd>undo<CR>
vnoremap <silent> <C-z>    <Cmd>undo<CR>

" redo
nnoremap <silent> <C-y>    <Cmd>redo<CR>
inoremap <silent> <C-y>    <Cmd>redo<CR>
vnoremap <silent> <C-y>    <Cmd>redo<CR>

" completion
" inoremap <C-SPACE>         <Cmd>lua vim.lsp.buf.completion()<CR>

" code action
nnoremap <A-CR>     <Cmd>lua vim.lsp.buf.code_action()<CR>
inoremap <A-CR>     <Cmd>lua vim.lsp.buf.code_action()<CR>

" go to definition
nnoremap <C-b>      <Cmd>lua vim.lsp.buf.definition()<CR>
inoremap <C-b>      <Cmd>lua vim.lsp.buf.definition()<CR>

" find usage
" @TODO change this
nnoremap <A-f>       <Cmd>Telescope lsp_references<CR>
inoremap <A-f>       <Cmd>Telescope lsp_references<CR>

" rename
nnoremap <F2>       <Cmd>lua vim.lsp.buf.rename()<CR>
inoremap <F2>       <Cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <C-r>      <Cmd>lua vim.lsp.buf.rename()<CR>
inoremap <C-r>      <Cmd>lua vim.lsp.buf.rename()<CR>

" documentation
nnoremap <F1>       <Cmd>lua vim.lsp.buf.hover()<CR>
inoremap <F1>       <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <C-q>      <Cmd>lua vim.lsp.buf.hover()<CR>
inoremap <C-q>      <Cmd>lua vim.lsp.buf.hover()<CR>

" diagnostic
nnoremap <C-e>      <Cmd>lua vim.diagnostic.open_float()<CR>
inoremap <C-e>      <Cmd>lua vim.diagnostic.open_float()<CR>


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

" Go to the last character
nnoremap <END>             g_
" inoremap <END>             <C-o>g_
vnoremap <END>             g_

" Go to the end of line
nnoremap <A-END>           $
inoremap <A-END>           <C-o>$
vnoremap <A-END>           $



""""""""""""""""""""""""""""""""""""""""""""""
"" SELECTION

" Switch to select mode
" xnoremap s                 <C-g>

" Select all
nnoremap <C-a>             ggg0vGg$
inoremap <C-a>             <ESC>ggg0vGg$
vnoremap <C-a>             <ESC>ggg0vGg$

" Select to left
nnoremap <S-LEFT>          v
inoremap <S-LEFT>          <LEFT><C-o>v
vnoremap <S-LEFT>          <LEFT>

" Select to right
nnoremap <S-RIGHT>         v
inoremap <S-RIGHT>         <C-o>v
vnoremap <S-RIGHT>         <RIGHT>

" Select to up
nnoremap <S-UP>            v<UP>
inoremap <S-UP>            <LEFT><C-o>v<UP><RIGHT>
vnoremap <S-UP>            <UP>

" Select to down
nnoremap <S-DOWN>          v<DOWN>
inoremap <S-DOWN>          <C-o>v<DOWN><LEFT>
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

" Select to start of file
nnoremap <S-C-HOME>        vgg0
inoremap <S-C-HOME>        <LEFT><C-o>vgg0
vnoremap <S-C-HOME>        gg0

" Select to beginning of file
nnoremap <S-C-END>         vG$
inoremap <S-C-END>         <C-o>vG$
vnoremap <S-C-END>         G$


""""""""""""""""""""""""""""""""""""""""""""""
"" EDITING

" copy
nnoremap <C-c>    yl
vnoremap <C-c>    y

" cut
nnoremap <C-x>    vd
vnoremap <C-x>    d

" paste
nnoremap <C-v>    "0p
inoremap <C-v>    <C-o>"0p
vnoremap <C-v>    "0p

" visual block mode
nnoremap <A-v>    <C-v>
inoremap <A-v>    <C-o><C-v>
vnoremap <A-v>    <C-v>

" that (useful) thing at prints the character you pressed lol
inoremap <A-C-v>    <C-v>


" Delete
nnoremap <BS>                 "_x
vnoremap <BS>                 "_x
vnoremap <Del>                "_x

" Delete rear/front word
nnoremap <C-H>                "_db
inoremap <C-H>                <C-w>
nnoremap <C-DEL>              "_de
inoremap <C-DEL>              <C-o>"_de

" Cut line
nnoremap <S-DEL>              dd
inoremap <S-DEL>              <C-o>dd

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
nnoremap <A-L>                <Cmd>lua vim.lsp.buf.format()<CR>
inoremap <A-L>                <Cmd>lua vim.lsp.buf.format()<CR>

" comment
nnoremap <A-c>                <Cmd>CommentToggle<CR>
inoremap <A-c>                <Cmd>CommentToggle<CR>
vnoremap <A-c>                :CommentToggle<CR>


" folds
nnoremap <A--> <Cmd>foldclose<CR>
inoremap <A--> <Cmd>foldclose<CR>

nnoremap <A-+> <Cmd>foldopen<CR>
inoremap <A-+> <Cmd>foldopen<CR>


""""""""""""""""""""""""""""""""""""""""""""""
"" WINDOWS

" focus left/down/up/right window
nnoremap <A-LEFT>          <Cmd>wincmd h<CR>
nnoremap <A-DOWN>          <Cmd>wincmd j<CR>
nnoremap <A-UP>            <Cmd>wincmd k<CR>
nnoremap <A-RIGHT>         <Cmd>wincmd l<CR>

inoremap <A-LEFT>          <Cmd>wincmd h<CR>
inoremap <A-DOWN>          <Cmd>wincmd j<CR>
inoremap <A-UP>            <Cmd>wincmd k<CR>
inoremap <A-RIGHT>         <Cmd>wincmd l<CR>

tnoremap <A-LEFT>          <Cmd>wincmd h<CR>
tnoremap <A-DOWN>          <Cmd>wincmd j<CR>
tnoremap <A-UP>            <Cmd>wincmd k<CR>
tnoremap <A-RIGHT>         <Cmd>wincmd l<CR>

" move current window to left/down/up/right
nnoremap <A-S-LEFT>        <Cmd>wincmd H<CR>
nnoremap <A-S-DOWN>        <Cmd>wincmd J<CR>
nnoremap <A-S-UP>          <Cmd>wincmd K<CR>
nnoremap <A-S-RIGHT>       <Cmd>wincmd L<CR>

inoremap <A-S-LEFT>        <Cmd>wincmd H<CR>
inoremap <A-S-DOWN>        <Cmd>wincmd J<CR>
inoremap <A-S-UP>          <Cmd>wincmd K<CR>
inoremap <A-S-RIGHT>       <Cmd>wincmd L<CR>

" Buffers
nnoremap <A-PageUp>        <Cmd>bnext<CR>
inoremap <A-PageUp>        <Cmd>bnext<CR>

nnoremap <A-PageDown>      <Cmd>bprevious<CR>
inoremap <A-PageDown>      <Cmd>bprevious<CR>

" Tabs
nnoremap <C-t>             <Cmd>tabnew<CR>
inoremap <C-t>             <Cmd>tabnew<CR>
" (ctrl + f4)
nnoremap <F28>             <Cmd>tabclose<CR>
inoremap <F28>             <Cmd>tabclose<CR>
" (ctrl + shift + f4)
nnoremap <F40>             <Cmd>tabdo close<CR>
inoremap <F40>             <Cmd>tabdo close<CR>
nnoremap <C-PageUp>        <Cmd>tabprevious<CR>
inoremap <C-PageUp>        <Cmd>tabprevious<CR>
nnoremap <C-PageDown>      <Cmd>tabnext<CR>
inoremap <C-PageDown>      <Cmd>tabnext<CR>
nnoremap <C-S-PageUp>      <Cmd>-tabmove<CR>
inoremap <C-S-PageUp>      <Cmd>-tabmove<CR>
nnoremap <C-S-PageDown>    <Cmd>+tabmove<CR>
inoremap <C-S-PageDown>    <Cmd>+tabmove<CR>

" NvimTree
nnoremap <A-\>             <Cmd>Neotree focus<CR>
tnoremap <A-\>             <Cmd>Neotree focus<CR>
inoremap <A-\>             <Cmd>Neotree focus<CR><ESC>

" terminal
nnoremap <A-ò>             <Cmd>ToggleTerm<CR>
tnoremap <A-ò>             <Cmd>ToggleTerm<CR>
tnoremap <Esc>             <C-\><C-n>

" Symbols outline
nnoremap <A-9>             <Cmd>AerialToggle<CR>
inoremap <A-9>             <Cmd>AerialToggle<CR>
vnoremap <A-9>             <Cmd>AerialToggle<CR>


" Telescope
nnoremap <C-p>              <Cmd>Telescope find_files hidden=true<CR>
inoremap <C-p>              <Cmd>Telescope find_files hidden=true<CR>

nnoremap <A-p>              <Cmd>Telescope<CR>
inoremap <A-p>              <Cmd>Telescope<CR>

nnoremap <C-A-p>            <Cmd>Telescope lsp_dynamic_workspace_symbols<CR>
inoremap <C-A-p>            <Cmd>Telescope lsp_dynamic_workspace_symbols<CR>

nnoremap <A-Tab>            <Cmd>Telescope buffers theme=dropdown<CR>
inoremap <A-Tab>            <Cmd>Telescope buffers theme=dropdown<CR>

nnoremap <C-f>              <Cmd>Telescope current_buffer_fuzzy_find<CR>
inoremap <C-f>              <Cmd>Telescope current_buffer_fuzzy_find<CR>

nnoremap <C-A-f>            <Cmd>Telescope live_grep<CR>
inoremap <C-A-f>            <Cmd>Telescope live_grep<CR>


let mapleader = " "
"" UI
" columns
" map <Leader>ucg <Cmd>lua simonvic.utils.ui.toggle_gitsigns()<CR>
" map <Leader>ucf <Cmd>lua simonvic.utils.ui.toggle_foldcolumn()<CR>

" Debug
map <Leader>ud <Cmd>lua require("dapui").toggle()<CR>

" Editor
map <Leader>ul <Cmd>lua vim.opt.list = not vim.opt.list:get()<CR>

]]

local dap = require("dap")

local function logBreakpoint()
	vim.ui.input({ prompt = "Log point message" }, function(input)
		dap.set_breakpoint(nil, nil, input)
	end)
end

local function conditionBreakpoint()
	vim.ui.input({ prompt = "Breakpoint condition" }, function(input)
		dap.set_breakpoint(input)
	end)
end

local function conditionLogBreakpoint()
	vim.ui.input({ prompt = "Breakpoint condition" }, function(condition)
		vim.ui.input({ prompt = "Log point message" }, function(message)
			dap.set_breakpoint(condition, nil, message)
		end)
	end)
end

local function inspectVariable()
	-- require("dap.ui.widgets").hover()
	require("dapui").eval()
end

map("n", "<F7>", "<Cmd>DapContinue<CR>")          -- F7
map("n", "<F55>", "<Cmd>DapTerminate<CR>")        -- Alt + F7
map("n", "<F31>", "<Cmd>JdtHotcodeReplace<CR>")   -- Ctrl + F7
map("n", "<F8>", "<Cmd>DapStepOver<CR>")          -- F8
map("n", "<F32>", "<Cmd>DapStepInto<CR>")         -- Ctrl + F8
map("n", "<F20>", "<Cmd>DapStepOut<CR>")          -- Shift + F8
map("n", "<F9>", "<Cmd>DapToggleBreakpoint<CR>")  -- F9
map("n", "<F33>", conditionBreakpoint)            -- Ctrl + F9
map("n", "<F57>", logBreakpoint)                  -- Alt + F9
map("n", "<F21>", conditionLogBreakpoint)         -- Shift + F9
map("n", "<A-q>", inspectVariable)
-- map("n", "<Leader>dr", function() dap.run_last() end)
