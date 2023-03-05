local vim = vim
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
local dapui = require("dapui")
local telescope_builtin = require("telescope.builtin")
local telescope_themes = require("telescope.themes")

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
local function cmdEsc(command) return "<Cmd>" .. command .. "<CR><ESC>" end

local function inspectVariable() dapui.eval() end -- require("dap.ui.widgets").hover()
local function codeAction() lsp.code_action() end
local function goToDefinition() lsp.definition() end
local function rename() lsp.rename() end
local function openDocumentation() lsp.hover(); end
local function showDiagnostics() vim.diagnostic.open_float() end
local function format() lsp.format() end
local function toggleDapUI() dapui.toggle() end
local function toggleListChars() vim.opt.list = not vim.opt.list:get() end
local function findUsage() telescope_builtin.lsp_references() end
local function findFiles() telescope_builtin.find_files({ hidden = true }) end
local function findSymbols() telescope_builtin.lsp_dynamic_workspace_symbols() end
local function fuzzyFind() telescope_builtin.current_buffer_fuzzy_find() end
local function liveGrep() telescope_builtin.live_grep() end
local function buffers() telescope_builtin.buffers(telescope_themes.get_dropdown({})) end

local keybindings = {
	leader = " ",
	localleader = " ",
	-- { modes, lhs,              rhs,                             options,           description },
	------------------------------------------------------------------- ACTIONS
	{ nvi_, "<C-s>",          cmd("write"),               { silent = true }, "save" },
	{ nvi_, "<C-z>",          cmd("undo"),                { silent = true }, "undo" },
	{ nvi_, "<C-y>",          cmd("redo"),                { silent = true }, "redo" },
	{ n_i_, "<A-CR>",         codeAction,                 {},                "code actions" },
	{ n_i_, "<C-b>",          goToDefinition,             {},                "go to definition" },
	{ n_i_, "<A-f>",          findUsage,                  {},                "find usage" },
	{ n_i_, "<F2>",           rename,                     {},                "rename" },
	{ n_i_, "<C-r>",          rename,                     {},                "rename" },
	{ n_i_, "<F1>",           openDocumentation,          {},                "open docs" },
	{ n_i_, "<C-q>",          openDocumentation,          {},                "open docs" },
	{ n_i_, "<C-e>",          showDiagnostics,            {},                "show diagnostics" },
	------------------------------------------------------------------ MOVEMENT
	{ nv__, "<C-LEFT>",       "b",                        {},                "previous end" },
	{ __i_, "<C-LEFT>",       "<C-o>b",                   {},                "previous end" },
	{ nv__, "<C-RIGHT>",      "e",                        {},                "next word" },
	{ __i_, "<C-RIGHT>",      "<C-o>e<RIGHT>",            {},                "next word" },
	{ nv__, "<HOME>",         "^",                        {},                "first character" },
	{ __i_, "<HOME>",         "<C-o>^",                   {},                "first character" },
	{ nv__, "<A-HOME>",       "0",                        {},                "start of line" },
	{ __i_, "<A-HOME>",       "<C-o>0",                   {},                "start of line" },
	{ nv__, "<END>",          "g_",                       {},                "last character" },
	{ nv__, "<A-END>",        "$",                        {},                "last character" },
	{ __i_, "<A-END>",        "<C-o>$",                   {},                "end of line" },
	----------------------------------------------------------------- SELECTION
	{ n___, "<C-a>",          "ggg0vGg$",                 {},                "all" },
	{ _vi_, "<C-a>",          "<ESC>ggg0vGg$",            {},                "all" },
	{ n___, "<S-LEFT>",       "v<LEFT>",                  {},                "left" },
	{ _v__, "<S-LEFT>",       "<LEFT>",                   {},                "left" },
	{ __i_, "<S-LEFT>",       "<LEFT><C-o>v",             {},                "left" },
	{ n___, "<S-RIGHT>",      "v<RIGHT>",                 {},                "right" },
	{ _v__, "<S-RIGHT>",      "<RIGHT>",                  {},                "right" },
	{ __i_, "<S-RIGHT>",      "<C-o>v",                   {},                "right" },
	{ n___, "<S-UP>",         "v<UP>",                    {},                "up" },
	{ _v__, "<S-UP>",         "<UP>",                     {},                "up" },
	{ __i_, "<S-UP>",         "<LEFT><C-o>v<UP><RIGHT>",  {},                "up" },
	{ n___, "<S-DOWN>",       "v<DOWN>",                  {},                "down" },
	{ _v__, "<S-DOWN>",       "<DOWN>",                   {},                "down" },
	{ __i_, "<S-DOWN>",       "<C-o>v<DOWN><LEFT>",       {},                "down" },
	{ n___, "<S-C-LEFT>",     "vb",                       {},                "word left" },
	{ _v__, "<S-C-LEFT>",     "b",                        {},                "word left" },
	{ __i_, "<S-C-LEFT>",     "<LEFT><C-o>vb",            {},                "word left" },
	{ n___, "<S-C-RIGHT>",    "ve",                       {},                "word right" },
	{ _v__, "<S-C-RIGHT>",    "e",                        {},                "word right" },
	{ __i_, "<S-C-RIGHT>",    "<C-o>ve",                  {},                "word right" },
	{ n___, "<S-HOME>",       "v^",                       {},                "to first character" },
	{ _v__, "<S-HOME>",       "^",                        {},                "to first character" },
	{ __i_, "<S-HOME>",       "<LEFT><C-o>v^",            {},                "to first character" },
	{ n___, "<S-A-HOME>",     "v0",                       {},                "to start of line" },
	{ _v__, "<S-A-HOME>",     "0",                        {},                "to start of line" },
	{ __i_, "<S-A-HOME>",     "<LEFT><C-o>v0",            {},                "to start of line" },
	{ n___, "<S-END>",        "vg_",                      {},                "to last character" },
	{ _v__, "<S-END>",        "g_",                       {},                "to last character" },
	{ __i_, "<S-END>",        "<C-o>vg_",                 {},                "to last character" },
	{ n___, "<S-A-END>",      "v$",                       {},                "to end of line" },
	{ _v__, "<S-A-END>",      "$",                        {},                "to end of line" },
	{ __i_, "<S-A-END>",      "<C-o>v$",                  {},                "to end of line" },
	{ n___, "<S-C-HOME>",     "vgg0",                     {},                "to start of file" },
	{ _v__, "<S-C-HOME>",     "gg0",                      {},                "to start of file" },
	{ __i_, "<S-C-HOME>",     "<LEFT><C-o>vgg0",          {},                "to start of file" },
	{ n___, "<S-C-END>",      "vG$",                      {},                "to end of file" },
	{ _v__, "<S-C-END>",      "G$",                       {},                "to end of file" },
	{ __i_, "<S-C-END>",      "<C-o>vG$",                 {},                "to end of file" },
	------------------------------------------------------------------- EDITING
	{ n___, "<C-c>",          "yl",                       {},                "copy" },
	{ _v__, "<C-c>",          "y",                        {},                "copy" },
	{ n___, "<C-x>",          "yd",                       {},                "cut" },
	{ _v__, "<C-x>",          "d",                        {},                "cut" },
	{ nv__, "<C-v>",          '"0p',                      {},                "paste" },
	{ __i_, "<C-v>",          '<C-o>"0p',                 {},                "paste" },
	{ nv__, "<A-v>",          "<C-v>",                    {},                "visual block mode" },
	{ __i_, "<A-v>",          "<C-o><C-v>",               {},                "visual block mode" },
	{ __i_, "<A-C-v>",        "<C-v>",                    {},                "input keycode listener" },
	{ nv__, "<BS>",           '"_x',                      {},                "delete" },
	{ _v__, "<DEL>",          '"_x',                      {},                "delete" },
	{ n___, "<C-H>",          '"_db',                     {},                "delete rear word" },
	{ __i_, "<C-H>",          "<C-w>",                    {},                "delete rear word" },
	{ n___, "<C-DEL>",        '"_de',                     {},                "delete front word" },
	{ __i_, "<C-DEL>",        '<C-o>"_de',                {},                "delete front" },
	{ n___, "<S-DEL>",        "dd",                       {},                "cut line" },
	{ __i_, "<S-DEL>",        "<C-o>dd",                  {},                "cut line" },
	{ n_i_, "<C-A-DOWN>",     cmd("move +1"),             { silent = true }, "move down" },
	{ _v__, "<C-A-DOWN>",     ":move '>+1<CR>gv",         { silent = true }, "move down" },
	{ n_i_, "<C-A-UP>",       cmd("move -2"),             { silent = true }, "move up" },
	{ _v__, "<C-A-UP>",       ":move '<-2<CR>gv",         { silent = true }, "move up" },
	{ n_i_, "<C-S-DOWN>",     cmd("copy +0"),             { silent = true }, "copy down" },
	{ _v__, "<C-S-DOWN>",     ":copy '<-1<CR>gv",         { silent = true }, "copy down" },
	{ n_i_, "<C-S-UP>",       cmd("copy -1"),             { silent = true }, "copy up" },
	{ _v__, "<C-S-UP>",       ":copy '>+0<CR>gv",         { silent = true }, "copy up" },
	{ n___, "<C-A-l>",        "magg=G`a",                 {},                "reindent file" },
	{ __i_, "<C-A-l>",        "<ESC>magg=G`aa",           {},                "reindent file" },
	{ _v__, "<C-A-l>",        "<ESC>ma'<='>`a",           {},                "reindent selection" },
	{ n_i_, "<A-L>",          format,                     {},                "reformat" },
	{ n_i_, "<A-c>",          cmd("CommentToggle"),       {},                "comment toggle" },
	{ _v__, "<A-c>",          ":CommentToggle<CR>",       {},                "comment toggle" },
	{ _v__, "<TAB>",          ">gv",                      {},                "increase indent" },
	{ _v__, "<S-TAB>",        "<gv",                      {},                "decrease indent" },
	{ n_i_, "<A-->",          cmd("foldclose"),           {},                "fold close" },
	{ n_i_, "<A-+>",          cmd("foldopen"),            {},                "fold open" },
	------------------------------------------------------------------- WINDOWS
	{ n_it, "<A-LEFT>",       cmd("wincmd h"),            {},                "focus left window" },
	{ n_it, "<A-DOWN>",       cmd("wincmd j"),            {},                "focus down window" },
	{ n_it, "<A-UP>",         cmd("wincmd k"),            {},                "focus up window" },
	{ n_it, "<A-RIGHT>",      cmd("wincmd l"),            {},                "focus right window" },
	{ n_i_, "<A-S-LEFT>",     cmd("wincmd H"),            {},                "move left" },
	{ n_i_, "<A-S-DOWN>",     cmd("wincmd J"),            {},                "move down" },
	{ n_i_, "<A-S-UP>",       cmd("wincmd K"),            {},                "move up" },
	{ n_i_, "<A-S-RIGHT>",    cmd("wincmd L"),            {},                "move right" },
	{ n_i_, "<A-PageUp>",     cmd("bnext"),               {},                "next buffer" },
	{ n_i_, "<A-PageDown>",   cmd("bprevious"),           {},                "previous buffer" },
	{ n_i_, "<C-t>",          cmd("tabnew"),              {},                "new tab" },
	{ n_i_, "<F28>",          cmd("tabclose"),            {},                "close tab" },
	{ n_i_, "<F40>",          cmd("tabdo close"),         {},                "close all tabs" },
	{ n_i_, "<C-PageUp>",     cmd("tabprevious"),         {},                "previous tab" },
	{ n_i_, "<C-PageDown>",   cmd("tabnext"),             {},                "next tab" },
	{ n_i_, "<C-S-PageUp>",   cmd("-tabmove"),            {},                "move tab to left" },
	{ n_i_, "<C-S-PageDown>", cmd("+tabmove"),            {},                "move tab to right" },
	{ n__t, "<A-\\>",         cmd("Neotree focus"),       {},                "focus filetree" },
	{ __i_, "<A-\\>",         cmdEsc("Neotree focus"),    {},                "focus filetree" },
	{ n__t, "<A-ò>",         cmd("ToggleTerm"),          {},                "terminal" },
	{ ___t, "<Esc>",          "<C-\\><C-n>",              {},                "terminal" },
	{ n_i_, "<C-p>",          findFiles,                  {},                "find files" },
	{ n_i_, "<A-p>",          cmd("Telescope"),           {},                "telescope" },
	{ n_i_, "<C-A-p>",        findSymbols,                {},                "find symbols" },
	{ n_i_, "<A-Tab>",        buffers,                    {},                "buffers" },
	{ n_i_, "<C-f>",          fuzzyFind,                  {},                "fuzzy find" },
	{ n_i_, "<C-A-f>",        liveGrep,                   {},                "live grep" },
	------------------------------------------------------------------------ UI
	{ n___, "<Leader>ud",     toggleDapUI,                {},                "dapui" },
	{ n___, "<Leader>ul",     toggleListChars,            {},                "toggle list chars" },
	{ nvi_, "<A-9>",          cmd("AerialToggle"),        {},                "symbols outline" },
	----------------------------------------------------------------- DEBUGGING
	{ n___, "<F7>",           cmd("DapContinue"),         {},                "continue [F7]" },
	{ n___, "<F55>",          cmd("DapTerminate"),        {},                "terminate [Alt + F7]" },
	{ n___, "<F31>",          cmd("JdtHotcodeReplace"),   {},                "hotcodeplace [Ctrl + F7]" },
	{ n___, "<F8>",           cmd("DapStepOver"),         {},                "step over[F8]" },
	{ n___, "<F32>",          cmd("DapStepInto"),         {},                "step into [Ctrl + F8]" },
	{ n___, "<F20>",          cmd("DapStepOut"),          {},                "step out [Shift + F8]" },
	{ n___, "<F9>",           cmd("DapToggleBreakpoint"), {},                "breakpoint [F9]" },
	{ n___, "<F33>",          conditionBreakpoint,        {},                "conditional breakpoint [Ctrl + F9]" },
	{ n___, "<F57>",          logBreakpoint,              {},                "log breakpoint [Alt + F9]" },
	{ n___, "<F21>",          conditionLogBreakpoint,     {},                "conditional log breakpoint [Shift + F9]" },
	{ n___, "<A-q>",          inspectVariable,            {},                "inspect variable" },
}


for _, keybind in ipairs(keybindings) do
	vim.g.mapleader = keybindings.leader
	vim.g.maplocalleader = keybindings.localleader
	vim.keymap.set(keybind[1], keybind[2], keybind[3], keybind[4] or {})
end
