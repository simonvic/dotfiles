local vim = vim
local map = vim.keymap.set
local lsp = vim.lsp.buf
local n___ = { "n" }
local _v__ = { "v" }
local __i_ = { "i" }
local ___t = { "t" }
local nvi_ = { "n", "v", "i" }
local nv__ = { "n", "v" }
local n_i_ = { "n", "i" }
local n_it = { "n", "i", "t" }
local n__t = { "n", "t" }
local _vi_ = { "v", "i" }

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

local function cmd(command) return "<Cmd>" .. command .. "<CR>" end

local function inspectVariable() require("dapui").eval() end -- require("dap.ui.widgets").hover()

local function codeAction() lsp.code_action() end

local function goToDefinition() lsp.definition() end

local function rename() lsp.rename() end

local function openDocumentation() lsp.hover(); end

local function showDiagnostics() vim.diagnostic.open_float() end

local function format() lsp.format() end

local function toggleDapUI() require("dapui").toggle() end

local function toggleListChars() vim.opt.list = not vim.opt.list:get() end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keybindings = {
	--	{ modes, lhs, rhs, options}
	------------------------------------------------------------------- ACTIONS
	{ nvi_, "<C-s>", cmd("write"), { silent = true } }, --                 save
	{ nvi_, "<C-z>", cmd("undo"), { silent = true } }, --                  undo
	{ nvi_, "<C-y>", cmd("redo"), { silent = true } }, --                  redo
	{ n_i_, "<A-CR>", codeAction }, --                             code actions
	{ n_i_, "<C-b>", goToDefinition }, --                      go to definition
	{ n_i_, "<A-f>", cmd("Telescope lsp_references") }, --           find usage
	{ n_i_, "<F2>", rename }, --                                         rename
	{ n_i_, "<C-r>", rename },
	{ n_i_, "<F1>", openDocumentation }, --                           open docs
	{ n_i_, "<C-q>", openDocumentation },
	{ n_i_, "<C-e>", showDiagnostics }, --                     show diagnostics
	------------------------------------------------------------------ MOVEMENT
	{ nv__, "<C-LEFT>", "b" }, --                                  previous end
	{ __i_, "<C-LEFT>", "<C-o>b" },
	{ nv__, "<C-RIGHT>", "e" }, --                                    next word
	{ __i_, "<C-RIGHT>", "<C-o>e<RIGHT>" },
	{ nv__, "<HOME>", "^" }, --                                 first character
	{ __i_, "<HOME>", "<C-o>^" },
	{ nv__, "<A-HOME>", "0" }, --                                 start of line
	{ __i_, "<A-HOME>", "<C-o>0" },
	{ nv__, "<END>", "g_" }, --                                  last character
	{ nv__, "<A-END>", "$" },
	{ __i_, "<A-END>", "<C-o>$" }, --                               end of line
	----------------------------------------------------------------- SELECTION
	{ n___, "<C-a>", "ggg0vGg$" }, --                                       all
	{ _vi_, "<C-a>", "<ESC>ggg0vGg$" },
	{ n___, "<S-LEFT>", "v<LEFT>" }, --                                    left
	{ _v__, "<S-LEFT>", "<LEFT>" },
	{ __i_, "<S-LEFT>", "<LEFT><C-o>v" },
	{ n___, "<S-RIGHT>", "v<RIGHT>" }, --                                 right
	{ _v__, "<S-RIGHT>", "<RIGHT>" },
	{ __i_, "<S-RIGHT>", "<C-o>v" },
	{ n___, "<S-UP>", "v<UP>" }, --                                          up
	{ _v__, "<S-UP>", "<UP>" },
	{ __i_, "<S-UP>", "<LEFT><C-o>v<UP><RIGHT>" },
	{ n___, "<S-DOWN>", "v<DOWN>" }, --                                    down
	{ _v__, "<S-DOWN>", "<DOWN>" },
	{ __i_, "<S-DOWN>", "<C-o>v<DOWN><LEFT>" },
	{ n___, "<S-C-LEFT>", "vb" }, --                                  word left
	{ _v__, "<S-C-LEFT>", "b" },
	{ __i_, "<S-C-LEFT>", "<LEFT><C-o>vb" },
	{ n___, "<S-C-RIGHT>", "ve" }, --                                word right
	{ _v__, "<S-C-RIGHT>", "e" },
	{ __i_, "<S-C-RIGHT>", "<C-o>ve" },
	{ n___, "<S-HOME>", "v^" }, --                           to first character
	{ _v__, "<S-HOME>", "^" },
	{ __i_, "<S-HOME>", "<LEFT><C-o>v^" },
	{ n___, "<S-A-HOME>", "v0" }, --                           to start of line
	{ _v__, "<S-A-HOME>", "0" },
	{ __i_, "<S-A-HOME>", "<LEFT><C-o>v0" },
	{ n___, "<S-END>", "vg_" }, --                            to last character
	{ _v__, "<S-END>", "g_" },
	{ __i_, "<S-END>", "<C-o>vg_" },
	{ n___, "<S-A-END>", "v$" }, --                              to end of line
	{ _v__, "<S-A-END>", "$" },
	{ __i_, "<S-A-END>", "<C-o>v$" },
	{ n___, "<S-C-HOME>", "vgg0" }, --                         to start of file
	{ _v__, "<S-C-HOME>", "gg0" },
	{ __i_, "<S-C-HOME>", "<LEFT><C-o>vgg0" },
	{ n___, "<S-C-END>", "vG$" }, --                             to end of file
	{ _v__, "<S-C-END>", "G$" },
	{ __i_, "<S-C-END>", "<C-o>vG$" },
	------------------------------------------------------------------- EDITING
	{ n___, "<C-c>", "yl" }, --                                            copy
	{ _v__, "<C-c>", "y" },
	{ n___, "<C-x>", "yd" }, --                                             cut
	{ _v__, "<C-x>", "d" },
	{ nv__, "<C-v>", '"0p' }, --                                          paste
	{ __i_, "<C-v>", '<C-o>"0p' },
	{ nv__, "<A-v>", "<C-v>" }, --                            visual block mode
	{ __i_, "<A-v>", "<C-o><C-v>" },
	{ __i_, "<A-C-v>", "<C-v>" }, --                     input keycode listener
	{ nv__, "<BS>", '"_x' }, --                                           delete
	{ _v__, "<DEL>", '"_x' },
	{ n___, "<C-H>", '"_db' }, --                        delete rear/front word
	{ __i_, "<C-H>", "<C-w>" },
	{ n___, "<C-DEL>", '"_de' },
	{ __i_, "<C-DEL>", '<C-o>"_de' },
	{ n___, "<S-DEL>", "dd" }, --                                      cut line
	{ __i_, "<S-DEL>", "<C-o>dd" },
	{ n_i_, "<C-A-DOWN>", cmd("move +1"), { silent = true } }, --     move down
	{ _v__, "<C-A-DOWN>", ":move '>+1<CR>gv", { silent = true } },
	{ n_i_, "<C-A-UP>", cmd("move -2"), { silent = true } }, --         move up
	{ _v__, "<C-A-UP>", ":move '<-2<CR>gv", { silent = true } },
	{ n_i_, "<C-S-DOWN>", cmd("copy +0"), { silent = true } }, --     copy down
	{ _v__, "<C-S-DOWN>", ":copy '<-1<CR>gv", { silent = true } },
	{ n_i_, "<C-S-UP>", cmd("copy -1"), { silent = true } }, --         copy up
	{ _v__, "<C-S-UP>", ":copy '>+0<CR>gv", { silent = true } },
	{ n___, "<C-A-l>", "magg=G`a" }, --                           reindent file
	{ __i_, "<C-A-l>", "<ESC>magg=G`aa" },
	{ _v__, "<C-A-l>", "<ESC>ma'<='>`a" }, --                reindent selection
	{ n_i_, "<A-L>", format }, --                                      reformat
	{ n_i_, "<A-c>", cmd("CommentToggle") }, --                  comment toggle
	{ _v__, "<A-c>", ":CommentToggle<CR>" },
	{ _v__, "<TAB>", ">gv" }, --                                increase indent
	{ _v__, "<S-TAB>", "<gv" }, --                              decrease indent
	{ n_i_, "<A-->", cmd("foldclose") }, --                          fold close
	{ n_i_, "<A-+>", cmd("foldopen") }, --                            fold open
	------------------------------------------------------------------- WINDOWS
	{ n_it, "<A-LEFT>", cmd("wincmd h") }, --                 focus left window
	{ n_it, "<A-DOWN>", cmd("wincmd j") }, --                 focus down window
	{ n_it, "<A-UP>", cmd("wincmd k") }, --                     focus up window
	{ n_it, "<A-RIGHT>", cmd("wincmd l") }, --               focus right window
	{ n_i_, "<A-S-LEFT>", cmd("wincmd H") }, --                       move left
	{ n_i_, "<A-S-DOWN>", cmd("wincmd J") }, --                       move down
	{ n_i_, "<A-S-UP>", cmd("wincmd K") }, --                           move up
	{ n_i_, "<A-S-RIGHT>", cmd("wincmd L") }, --                     move right
	{ n_i_, "<A-PageUp>", cmd("bnext") }, --                        next buffer
	{ n_i_, "<A-PageDown>", cmd("bprevious") }, --              previous buffer
	{ n_i_, "<C-t>", cmd("tabnew") }, --                                new tab
	{ n_i_, "<F28>", cmd("tabclose") }, --                            close tab
	{ n_i_, "<F40>", cmd("tabdo close") }, --                    close all tabs
	{ n_i_, "<C-PageUp>", cmd("tabprevious") }, --                 previous tab
	{ n_i_, "<C-PageDown>", cmd("tabnext") }, --                       next tab
	{ n_i_, "<C-S-PageUp>", cmd("-tabmove") }, --              move tab to left
	{ n_i_, "<C-S-PageDown>", cmd("+tabmove") }, --           move tab to right
	{ n__t, "<A-\\>", cmd("Neotree focus") }, --                 focus filetree
	{ __i_, "<A-\\>", cmd("Neotree focus") .. "<ESC>" },
	{ n__t, "<A-ò>", cmd("ToggleTerm") }, --                           terminal
	{ ___t, "<Esc>", "<C-\\><C-n>" },
	{ n_i_, "<C-p>", cmd("Telescope find_files hidden=true") }, --   find files
	{ n_i_, "<A-p>", cmd("Telescope") }, --                           telescope
	{ n_i_, "<C-A-p>", cmd("Telescope lsp_dynamic_workspace_symbols") }, -- find symbols
	{ n_i_, "<A-t>", cmd("Telescope buffers theme=dropdown") }, --      buffers
	{ n_i_, "<C-f>", cmd("Telescope current_buffer_fuzzy_find") }, -- fuzzy find
	{ n_i_, "<C-A-f>", cmd("Telescope live_grep") }, --               live grep
	------------------------------------------------------------------------ UI
	{ n___, "<Leader>ud", toggleDapUI }, --                               dapui
	{ n___, "<Leader>ul", toggleListChars }, --               toggle list chars
	{ nvi_, "<A-9>", cmd("AerialToggle") }, --                  symbols outline
	----------------------------------------------------------------- DEBUGGING
	{ n___, "<F7>", cmd("DapContinue") }, --                               [F7]
	{ n___, "<F55>", cmd("DapTerminate") }, --                       [Alt + F7]
	{ n___, "<F31>", cmd("JdtHotcodeReplace") }, --                 [Ctrl + F7]
	{ n___, "<F8>", cmd("DapStepOver") }, --                               [F8]
	{ n___, "<F32>", cmd("DapStepInto") }, --                       [Ctrl + F8]
	{ n___, "<F20>", cmd("DapStepOut") }, --                       [Shift + F8]
	{ n___, "<F9>", cmd("DapToggleBreakpoint") }, --                       [F9]
	{ n___, "<F33>", conditionBreakpoint }, --                      [Ctrl + F9]
	{ n___, "<F57>", logBreakpoint }, --                             [Alt + F9]
	{ n___, "<F21>", conditionLogBreakpoint }, --                  [Shift + F9]
	{ n___, "<A-q>", inspectVariable }, --                     inspect variable
}


for _, keybind in ipairs(keybindings) do
	map(keybind[1], keybind[2], keybind[3], keybind[4] or {})
end
