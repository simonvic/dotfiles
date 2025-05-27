-- TODO: toggle bool (<C-x> set to false, <C-a> set to true)
-- TODO: surround to gs

local M = {}

M.modes = {
	n___ = { "n" },
	_v__ = { "v" },
	__i_ = { "i" },
	___t = { "t" },
	nvi_ = { "n", "v", "i" },
	nsi_ = { "n", "s", "i" },
	nv__ = { "n", "v" },
	n_i_ = { "n", "i" },
	n_it = { "n", "i", "t" },
	n__t = { "n", "t" },
	_vi_ = { "v", "i" },
	_xo_ = { "x", "o" },
	nxo_ = { "n", "x", "o" }
}

M.util = {
	cmd = function(command) return "<Cmd>" .. command .. "<CR>" end,
	cmd_sel = function(command) return "'<,'>" .. command .. "<CR>" end,
	cmd_esc = function(command) return "<Cmd>" .. command .. "<CR><ESC>" end,
}

-- shortcuts
local n___ = M.modes.n___
local _v__ = M.modes._v__
local __i_ = M.modes.__i_
local ___t = M.modes.___t
local nvi_ = M.modes.nvi_
local nv__ = M.modes.nv__
local n_i_ = M.modes.n_i_
local nsi_ = M.modes.nsi_
local n_it = M.modes.n_it
local n__t = M.modes.n__t
local _xo_ = M.modes._xo_
local nxo_ = M.modes.nxo_
local cmd = M.util.cmd
local cmd_sel = M.util.cmd_sel

function M.not_implemented(name)
	name = name or "Key mapping"
	vim.notify(name .. " not implemented", vim.log.levels.WARN)
end

local foldcolumn = vim.opt.foldcolumn
local signcolumn = vim.opt.signcolumn

local function feed(keys, termcodes)
	termcodes = termcodes or true
	if termcodes then
		keys = vim.api.nvim_replace_termcodes(keys, true, true, true)
	end
	vim.api.nvim_feedkeys(keys, "n", false)
end

M.fn = {

	toggle_list_chars           = function() vim.opt.list = not vim.opt.list:get() end,
	-- TODO: if == "no" then update signcolumn
	toggle_fold_column          = function() vim.opt.foldcolumn = vim.opt.foldcolumn:get() == "0" and foldcolumn or "0" end,
	toggle_sign_column          = function() vim.opt.signcolumn = vim.opt.signcolumn:get() == "no" and signcolumn or "no" end,
	toggle_line_number          = function() vim.opt.number = not vim.opt.number:get() end,
	toggle_relative_number      = function() vim.opt.relativenumber = not vim.opt.relativenumber:get() end,
	toggle_inlay_hints          = function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,

	terminal                    = function() vim.cmd("terminal") end,
	terminal_float              = function() vim.cmd("terminal") end,

	commands                    = function() vim.cmd("map") end,

	diagnostic_show             = vim.diagnostic.open_float,
	diagnostic_show_all         = vim.diagnostic.setqflist,
	diagnostic_next             = function() vim.diagnostic.jump({ count = 1 }) end, -- TODO: open float if open already
	diagnostic_prev             = function() vim.diagnostic.jump({ count = -1 }) end,

	code_actions                = vim.lsp.buf.code_action,
	definition                  = vim.lsp.buf.definition,
	references                  = vim.lsp.buf.references,
	implementation              = vim.lsp.buf.implementation,
	workspace_symbols           = vim.lsp.buf.workspace_symbol,
	document_symbols            = vim.lsp.buf.document_symbol,
	rename                      = vim.lsp.buf.rename,
	hover                       = function() vim.lsp.buf.hover({ border = "rounded" }) end,
	signature_help              = function() vim.lsp.buf.signature_help({ border = "rounded", anchor_bias = "above" }) end,
	format                      = vim.lsp.buf.format,
	formatSelection             = function()
		vim.lsp.buf.format({
			range = {
				["start"] = vim.api.nvim_buf_get_mark(0, "<"),
				["end"] = vim.api.nvim_buf_get_mark(0, ">")
			}
		})
	end,

	-- plugin abstractions

	commands_menu               = function() M.not_implemented("commands_menu") end,

	-- eventually add default implementation with netrw
	filetree_focus              = function() vim.cmd("Explore") end,
	filetree_toggle             = function() M.not_implemented("filetree_toggle") end,
	filetree_refresh            = function() M.not_implemented("filetree_refresh") end,
	filetree_expand_or_descend  = function() M.not_implemented("filetree_expand_or_descend") end,
	filetree_collapse_or_ascend = function() M.not_implemented("filetree_collapse_or_ascend") end,
	filetree_vcs_change_next    = function() M.not_implemented("filetree_vcs_change_next") end,
	filetree_vcs_change_prev    = function() M.not_implemented("filetree_vcs_change_prev") end,

	symbols_outline_focus       = function() M.not_implemented("symbols_outline_focus") end,
	symbols_outline_float       = function() M.not_implemented("symbols_outline_float") end,

	zen_mode                    = function() M.not_implemented("zen_mode") end,

	toggle_context              = function() M.not_implemented("toggle_context") end,
	find_files                  = function() feed(":edit **/*") end,
	fuzzy_find                  = function() feed(":grep %<left><left> ") end,
	live_grep                   = function() feed(":grep ") end,
	buffers                     = function() feed(":buffer ") end,

	vcs_change_next             = function() M.not_implemented("vcs_change_next") end,
	vcs_change_prev             = function() M.not_implemented("vcs_change_prev") end,
	vcs_change_preview          = function() M.not_implemented("vcs_change_preview") end,
	vcs_change_preview_inline   = function() M.not_implemented("vcs_change_preview_inline") end,
	vcs_blame                   = function() M.not_implemented("vcs_blame") end,
	vcs_blame_line              = function() M.not_implemented("vcs_blame_line") end,

	toggle_debugger             = function() M.not_implemented("toggle_debugger") end,
	debugger_continue           = function() M.not_implemented("debugger_continue") end,
	debugger_terminate          = function() M.not_implemented("debugger_terminate") end,
	debugger_rerun              = function() M.not_implemented("debugger_rerun") end,
	debugger_stepover           = function() M.not_implemented("debugger_stepover") end,
	debugger_stepin             = function() M.not_implemented("debugger_stepin") end,
	debugger_stepout            = function() M.not_implemented("debugger_stepout") end,
	breakpoint_toggle           = function() M.not_implemented("breakpoint_toggle") end,
	breakpoint_condition        = function() M.not_implemented("breakpoint_condition") end,
	breakpoint_log              = function() M.not_implemented("breakpoint_log") end,
	breapoint_condition_log     = function() M.not_implemented("breapoint_condition_log") end,
	inspect_variable            = function() M.not_implemented("inspect_variable") end,

	organize_imports            = function() M.not_implemented("organize_imports") end,
	pick_tests                  = function() M.not_implemented("pick_tests") end,
	test_class                  = function() M.not_implemented("test_class") end,
	test_method                 = function() M.not_implemented("test_method") end,

	cursors_add_down            = function() M.not_implemented("cursors_add_down") end,
	cursors_add_up              = function() M.not_implemented("cursors_add_up") end,
	cursors_add_word            = function() M.not_implemented("cursors_add_word") end,
	cursors_add_selection       = function() M.not_implemented("cursors_add_selection") end,
	cursors_skip_selection      = function() M.not_implemented("cursors_skip_selection") end,
	cursors_align               = function() M.not_implemented("cursors_align") end,
	cursors_toggle              = function() M.not_implemented("cursors_toggle") end,
	cursors_delete              = function() M.not_implemented("cursors_delete") end,
	cursors_clear               = function() M.not_implemented("cursors_clear") end,

	-- TODO: builtin implementation?
	move_argument_next          = function() M.not_implemented("move_argument_next") end,
	move_argument_prev          = function() M.not_implemented("move_argument_prev") end,
	move_function_next          = function() M.not_implemented("move_function_next") end,
	move_function_prev          = function() M.not_implemented("move_function_prev") end,
	move_class_next             = function() M.not_implemented("move_class_next") end,
	move_class_prev             = function() M.not_implemented("move_class_prev") end,

	goto_next_function          = function() M.not_implemented("goto_next_function") end,
	goto_next_argument          = function() M.not_implemented("goto_next_argument") end,
	goto_next_class             = function() M.not_implemented("goto_next_class") end,
	goto_next_comment           = function() M.not_implemented("goto_next_comment") end,
	goto_prev_function          = function() M.not_implemented("goto_prev_function") end,
	goto_prev_argument          = function() M.not_implemented("goto_prev_argument") end,
	goto_prev_class             = function() M.not_implemented("goto_prev_class") end,
	goto_prev_comment           = function() M.not_implemented("goto_prev_comment") end,

	select_around_function      = function() M.not_implemented("select_around_function") end,
	select_inside_function      = function() M.not_implemented("select_inside_function") end,
	select_around_argument      = function() M.not_implemented("select_around_argument") end,
	select_inside_argument      = function() M.not_implemented("select_inside_argument") end,
	select_around_class         = function() M.not_implemented("select_around_class") end,
	select_inside_class         = function() M.not_implemented("select_inside_class") end,
	select_around_comment       = function() M.not_implemented("select_around_comment") end,
	select_inside_comment       = function() M.not_implemented("select_inside_comment") end,

}

M.leader = " "
M.localleader = " "
M.mappings = {
	--modes,lhs,                                  rhs,                                             options },
	{ n___, "-",                                  "/",                                             { desc = "Search forward" } },
	{ n___, "_",                                  "?",                                             { desc = "Search backward" } },
	{ n___, "è",                                  "[",                                             { desc = "Backward [ alias", remap = true } },
	{ n___, "+",                                  "]",                                             { desc = "Forward ] alias", remap = true } },
	--------------------------------------------------------------------------- ACTIONS
	{ nvi_, "<C-s>",                              cmd("write"),                                    { desc = "Save", silent = true } },
	{ n___, "U",                                  cmd("redo"),                                     { desc = "Redo", silent = true } },
	{ n___, { "<A-CR>", "gra" },                  function() M.fn.code_actions() end,              { desc = "Code actions" } },
	{ n___, { "<C-b>", "grd" },                   function() M.fn.definition() end,                { desc = "Go to definition" } },
	{ __i_, "<C-b>",                              function() M.fn.definition() end,                { desc = "Go to definition" } },
	{ n___, { "gri" },                            function() M.fn.implementation() end,            { desc = "Go to implementation" } },
	{ n___, { "<A-r>", "grr" },                   function() M.fn.references() end,                { desc = "Find references" } },
	{ __i_, "<A-r>",                              function() M.fn.references() end,                { desc = "Find references" } },
	{ n___, { "<C-r>", "grn" },                   function() M.fn.rename() end,                    { desc = "Rename" } },
	{ __i_, "<C-r>",                              function() M.fn.rename() end,                    { desc = "Rename" } },
	{ n___, { "<C-q>", "grq" },                   function() M.fn.hover() end,                     { desc = "Open docs" } },
	{ __i_, "<C-q>",                              function() M.fn.hover() end,                     { desc = "Open docs" } },
	{ nsi_, "<A-q>",                              function() M.fn.signature_help() end,            { desc = "Signature help" } },
	{ n___, { "<C-e>", "<leader>d" },             function() M.fn.diagnostic_show() end,           { desc = "Show diagnostics" } },
	{ __i_, "<C-e>",                              function() M.fn.diagnostic_show() end,           { desc = "Show diagnostics" } },
	{ n___, "<leader>D",                          function() M.fn.diagnostic_show_all() end,       { desc = "Show diagnostics for entire project" } },
	--------------------------------------------------------------------------- MOVEMENT
	{ n___, "]h",                                 function() M.fn.vcs_change_next() end,           { desc = "Go next hunk" } },
	{ n___, "[h",                                 function() M.fn.vcs_change_prev() end,           { desc = "Go prev hunk" } },
	{ n___, "<leader>h",                          function() M.fn.vcs_change_preview_inline() end, { desc = "Preview hunk diff inline" } },
	{ n___, "<leader>H",                          function() M.fn.vcs_change_preview() end,        { desc = "Preview hunk diff" } },
	{ n___, "]d",                                 function() M.fn.diagnostic_next() end,           { desc = "Go next diagnostic" } },
	{ n___, "[d",                                 function() M.fn.diagnostic_prev() end,           { desc = "Go prev diagnostic" } },
	{ nxo_, "]f",                                 function() M.fn.goto_next_function() end,        { desc = "Go to next function" } },
	{ nxo_, "]a",                                 function() M.fn.goto_next_argument() end,        { desc = "Go to next argument" } },
	{ nxo_, "]c",                                 function() M.fn.goto_next_class() end,           { desc = "Go to next class" } },
	{ nxo_, "]k",                                 function() M.fn.goto_next_comment() end,         { desc = "Go to next comment" } },
	{ nxo_, "[f",                                 function() M.fn.goto_prev_function() end,        { desc = "Go to previous function" } },
	{ nxo_, "[a",                                 function() M.fn.goto_prev_argument() end,        { desc = "Go to previous argument" } },
	{ nxo_, "[c",                                 function() M.fn.goto_prev_class() end,           { desc = "Go to previous class" } },
	{ nxo_, "[k",                                 function() M.fn.goto_prev_comment() end,         { desc = "Go to previous comment" } },
	---------------------------------------------------------------------------- EDITING
	{ n___, "<C-A-l>",                            "gg=G<C-o>",                                     { desc = "Reindent file" } },
	{ n_i_, "<A-S-l>",                            function() M.fn.format() end,                    { desc = "Reformat" } },
	{ _v__, "<A-S-l>",                            function() M.fn.formatSelection() end,           { desc = "Reformat selection" } },
	{ _v__, "<TAB>",                              ">gv",                                           { desc = "Increase indent" } },
	{ _v__, "<S-TAB>",                            "<gv",                                           { desc = "Decrease indent" } },
	{ nv__, "<leader>gl",                         ":diffget REMOTE<CR>",                           { desc = "Diffget remote" } },
	{ nv__, "<leader>gh",                         ":diffget LOCAL<CR>",                            { desc = "Diffget local" } },
	{ n___, "<leader>gb",                         function() M.fn.vcs_blame_line() end,            { desc = "Blame current line" } },
	{ n___, "<leader>gB",                         function() M.fn.vcs_blame() end,                 { desc = "Blame current buffer" } },
	{ n___, "mal",                                function() M.fn.move_argument_next() end,        { desc = "Move argument to next" } },
	{ n___, "mah",                                function() M.fn.move_argument_prev() end,        { desc = "Move argument to previous" } },
	{ n___, "mfl",                                function() M.fn.move_function_next() end,        { desc = "Move function to next" } },
	{ n___, "mfh",                                function() M.fn.move_function_prev() end,        { desc = "Move function to previous" } },
	{ n___, "mcl",                                function() M.fn.move_class_next() end,           { desc = "Move class to next" } },
	{ n___, "mch",                                function() M.fn.move_class_prev() end,           { desc = "Move class to previous" } },
	{ _xo_, "af",                                 function() M.fn.select_around_function() end,    { desc = "Select around function" } },
	{ _xo_, "if",                                 function() M.fn.select_inside_function() end,    { desc = "Select inside function" } },
	{ _xo_, "aa",                                 function() M.fn.select_around_argument() end,    { desc = "Select around argument" } },
	{ _xo_, "ia",                                 function() M.fn.select_inside_argument() end,    { desc = "Select inside argument" } },
	{ _xo_, "ac",                                 function() M.fn.select_around_class() end,       { desc = "Select around class" } },
	{ _xo_, "ic",                                 function() M.fn.select_inside_class() end,       { desc = "Select inside class" } },
	{ _xo_, "ak",                                 function() M.fn.select_around_comment() end,     { desc = "Select around comment" } },
	{ _xo_, "ik",                                 function() M.fn.select_inside_comment() end,     { desc = "Select inside comment" } },
	---------------------------------------------------------------------------- WINDOWS
	{ n_i_, "<A-PageUp>",                         cmd("bnext"),                                    { desc = "Next buffer" } },
	{ n_i_, "<A-PageDown>",                       cmd("bprevious"),                                { desc = "Previous buffer" } },
	{ n_i_, "<C-t>",                              cmd("tabnew"),                                   { desc = "New tab" } },
	{ n_i_, { "<C-F4>", "<F28>" },                cmd("tabclose"),                                 { desc = "Close tab" } },
	{ n_i_, { "<C-S-F4>", "<F40>" },              cmd("tabdo close"),                              { desc = "Close all tabs" } },
	{ n_i_, "<C-PageUp>",                         cmd("tabprevious"),                              { desc = "Previous tab" } },
	{ n_i_, "<C-PageDown>",                       cmd("tabnext"),                                  { desc = "Next tab" } },
	{ n_i_, "<C-S-PageUp>",                       cmd("-tabmove"),                                 { desc = "Move tab to left" } },
	{ n_i_, "<C-S-PageDown>",                     cmd("+tabmove"),                                 { desc = "Move tab to right" } },
	{ n___, "|",                                  function() M.fn.filetree_focus() end,            { desc = "Focus filetree" } },
	{ n__t, { "<A-S-ù>", "<A-§>" },               function() M.fn.terminal() end,                  { desc = "Toggle dropdown terminal" } },
	{ n__t, "<A-ù>",                              function() M.fn.terminal_float() end,            { desc = "Toggle floating terminal" } },
	{ ___t, "<Esc>",                              "<C-\\><C-n>",                                   { desc = "Exit terminal mode" } },
	{ n___, { "<leader><leader>", "<C-p>" },      function() M.fn.find_files() end,                { desc = "Find files" } },
	{ n___, "<A-p>",                              function() M.fn.commands_menu() end,             { desc = "Commands menu" } },
	{ n___, "<leader>:",                          function() M.fn.commands() end,                  { desc = "Commands palette" } },
	{ n___, { "<leader>S", "<C-A-p>" },           function() M.fn.workspace_symbols() end,         { desc = "Find workspace symbols" } },
	{ __i_, "<C-A-p>",                            function() M.fn.workspace_symbols() end,         { desc = "Find workspace symbols" } },
	{ n___, "gO",                                 function() M.fn.document_symbols() end,          { desc = "Find document symbols" } },
	{ n___, { "<leader><tab>", "<A-Tab>" },       function() M.fn.buffers() end,                   { desc = "Buffers" } },
	{ __i_, "<A-Tab>",                            function() M.fn.buffers() end,                   { desc = "Buffers" } },
	{ n___, { "<leader>f", "<C-f>" },             function() M.fn.fuzzy_find() end,                { desc = "Fuzzy find" } },
	{ __i_, "<C-f>",                              function() M.fn.fuzzy_find() end,                { desc = "Fuzzy find" } },
	{ n___, { "<leader>F", "<C-A-F>" },           function() M.fn.live_grep() end,                 { desc = "Live grep" } },
	{ __i_, "<C-A-f>",                            function() M.fn.live_grep() end,                 { desc = "Live grep" } },
	---------------------------------------------------------------------------- UI
	{ n___, "<Leader>ud",                         function() M.fn.toggle_debugger() end,           { desc = "Toggle debugger UI" } },
	{ n___, "<Leader>ul",                         function() M.fn.toggle_list_chars() end,         { desc = "Toggle list chars" } },
	{ n___, "<Leader>uc",                         function() M.fn.toggle_context() end,            { desc = "Toggle code context (scope)" } },
	{ n___, "<Leader>uz",                         function() M.fn.toggle_fold_column() end,        { desc = "Toggle folds column" } },
	{ n___, "<Leader>us",                         function() M.fn.toggle_sign_column() end,        { desc = "Toggle signs column" } },
	{ n___, "<Leader>un",                         function() M.fn.toggle_relative_number() end,    { desc = "Toggle relative number column" } },
	{ n___, "<Leader>uN",                         function() M.fn.toggle_line_number() end,        { desc = "Toggle number column" } },
	{ n___, "<Leader>uh",                         function() M.fn.toggle_inlay_hints() end,        { desc = "Toggle lsp inlay hints" } },
	{ n___, "<Leader>uZ",                         function() M.fn.zen_mode() end,                  { desc = "Toggle folds column" } },
	{ n_i_, "<A-9>",                              function() M.fn.symbols_outline_focus() end,     { desc = "Toggle symbols outline" } },
	{ n_i_, { "<A-S-9>", "<A-)>" },               function() M.fn.symbols_outline_float() end,     { desc = "Toggle symbols outline floating navigation" } },
	{ n___, "<leader>s",                          function() M.fn.symbols_outline_float() end,     { desc = "Toggle symbols outline floating navigation" } },
	---------------------------------------------------------------------------- DEBUGGING
	{ n___, "<F7>",                               function() M.fn.debugger_continue() end,         { desc = "DAP Continue" } },
	{ n___, { "<A-F7>", "<F55>" },                function() M.fn.debugger_terminate() end,        { desc = "DAP Terminate" } },
	{ n___, { "<S-F7>", "<F19>" },                function() M.fn.debugger_rerun() end,            { desc = "DAP Run last" } },
	{ n___, "<F8>",                               function() M.fn.debugger_stepover() end,         { desc = "DAP Step over" } },
	{ n___, { "<C-F8>", "<F32>" },                function() M.fn.debugger_stepin() end,           { desc = "DAP Step into" } },
	{ n___, { "<S-F8>", "<F20>" },                function() M.fn.debugger_stepout() end,          { desc = "DAP Step out" } },
	{ n___, "<F9>",                               function() M.fn.breakpoint_toggle() end,         { desc = "DAP Breakpoint" } },
	{ n___, { "<C-F9>", "<F33>" },                function() M.fn.breakpoint_condition() end,      { desc = "DAP Conditional breakpoint" } },
	{ n___, { "<A-F9>", "<F57>" },                function() M.fn.breakpoint_log() end,            { desc = "DAP Log breakpoint" } },
	{ n___, { "<S-F9>", "<F21>" },                function() M.fn.breapoint_condition_log() end,   { desc = "DAP Conditional log breakpoint" } },
	{ n___, "<A-C-q>",                            function() M.fn.inspect_variable() end,          { desc = "DAP Inspect variable" } },
	---------------------------------------------------------------------------- CODING
	{ n_i_, "<A-i>",                              function() M.fn.organize_imports() end,          { desc = "Organize imports" } },
	{ n_i_, "<F6>",                               function() M.fn.pick_tests() end,                { desc = "Pick test" } },
	{ n_i_, { "<S-F6>", "<F18>" },                function() M.fn.test_class() end,                { desc = "Test class" } },
	{ n_i_, { "<C-F6>", "<F30>" },                function() M.fn.test_method() end,               { desc = "Test method" } },
	{ n_i_, { "<C-S-F7>", "<F43>" },              function() M.fn.setup_debug_config() end,        { desc = "Setup debug launch config" } },
	{ n_i_, { "<C-F7>", "<F31>" },                function() M.fn.hotcode_replace() end,           { desc = "Hotcode replace" } },
	{ n_i_, "<C-A-b>",                            function() M.fn.super_implementation() end,      { desc = "Go to super implementation" } },
	---------------------------------------------------------------------------- Multicursor
	{ n___, { "<leader>cj", "<C-J>", "<C-S-j>" }, function() M.fn.cursors_add_down() end,          { desc = "Add cursor and move down" } },
	{ n___, { "<leader>ck", "<C-K>", "<C-S-K>" }, function() M.fn.cursors_add_up() end,            { desc = "Add cursor and move up" } },
	{ n___, { "<leader>cw", "<C-*>", },           function() M.fn.cursors_add_word() end,          { desc = "Add cursor and do * movement" } },
	{ _v__, { "<leader>cn", },                    function() M.fn.cursors_add_selection() end,     { desc = "Add cursor and move to next selection" } },
	{ _v__, { "<leader>cs", },                    function() M.fn.cursors_skip_selection() end,    { desc = "Move to next selection" } },
	{ n___, { "<leader>ca", "<C-S-A>" },          function() M.fn.cursors_align() end,             { desc = "Align cursors" } },
	{ n___, { "<leader>ct", "<C-S-X>" },          function() M.fn.cursors_toggle() end,            { desc = "Toggle cursors" } },
	{ n___, "<leader>cd",                         function() M.fn.cursors_delete() end,            { desc = "Delete last cursor" } },
	{ n___, { "<leader>cD", "<C-S-D>" },          function() M.fn.cursors_clear() end,             { desc = "Clear cursors" } },
}

-------------------------------------------------------------------------------- PLUGINS
M.plugins = {}

-------------------------------------------------------------------------------- TELESCOPE
M.plugins.telescope = {
}

-------------------------------------------------------------------------------- SNACKS
M.plugins.snacks = {
	input = {
		keys = {
			["<esc>"] = { "close", mode = { "n", "i" } },
			["<A-CR>"] = "qflist",
			["<C-CR>"] = "qflist_all",
		},
	}
}


-------------------------------------------------------------------------------- NVIMTREE
M.plugins.nvimtree = {
	{ n___, "|",                 function() require("nvim-tree.api").tree.toggle() end,                    { desc = "Toggle filetree" } },
	{ n___, "<F5>",              function() require("nvim-tree.api").tree.reload() end,                    { desc = "Refresh filetree" } },
	{ n___, { "l", "<Right>" },  function() M.fn.filetree_expand_or_descend() end,                         { desc = "Expand filetree node or descend" } },
	{ n___, { "h", "<Left>" },   function() M.fn.filetree_collapse_or_ascend() end,                        { desc = "Collapse filetree node or ascend" } },
	{ n___, "g?",                function() require("nvim-tree.api").tree.toggle_help() end,               { desc = "Help" } },
	{ n___, "<C-k>",             function() require("nvim-tree.api").node.show_info_popup() end,           { desc = "Info" } },
	-- opening
	{ n___, "<A-CR>",            function() require("nvim-tree.api").node.open.preview() end,              { desc = "Open: In Place" } },
	{ n___, "<CR>",              function() require("nvim-tree.api").node.open.edit() end,                 { desc = "Open" } },
	{ n___, "<C-v>",             function() require("nvim-tree.api").node.open.vertical() end,             { desc = "Open: Vertical Split" } },
	{ n___, "<C-h>",             function() require("nvim-tree.api").node.open.horizontal() end,           { desc = "Open: Horizontal Split" } },
	{ n___, "<C-t>",             function() require("nvim-tree.api").node.open.tab() end,                  { desc = "Open: New Tab" } },
	-- navigation
	{ n___, "<A-.>",             function() require("nvim-tree.api").tree.change_root_to_parent() end,     { desc = "Up" } },
	{ n___, ".",                 function() require("nvim-tree.api").tree.change_root_to_node() end,       { desc = "cd" } },
	{ n___, "[h",                function() M.fn.filetree_vcs_change_prev() end,                           { desc = "Prev Git" } },
	{ n___, "]h",                function() M.fn.filetree_vcs_change_next() end,                           { desc = "Next Git" } },
	{ n___, "]d",                function() require("nvim-tree.api").node.navigate.diagnostics.next() end, { desc = "Next Diagnostic" } },
	{ n___, "[d",                function() require("nvim-tree.api").node.navigate.diagnostics.prev() end, { desc = "Prev Diagnostic" } },
	{ n___, "H",                 function() require("nvim-tree.api").tree.toggle_hidden_filter() end,      { desc = "Toggle Filter: Dotfiles" } },
	{ n___, "I",                 function() require("nvim-tree.api").tree.toggle_gitignore_filter() end,   { desc = "Toggle Filter: Git Ignore" } },
	{ n___, "zc",                function() require("nvim-tree.api").node.navigate.parent_close() end,     { desc = "Close Directory" } },
	{ n___, "zR",                function() require("nvim-tree.api").tree.expand_all() end,                { desc = "Expand All" } },
	{ n___, "zM",                function() require("nvim-tree.api").tree.collapse_all() end,              { desc = "Collapse" } },
	-- filesystem
	{ n___, { "<C-r>", "<F2>" }, function() require("nvim-tree.api").fs.rename() end,                      { desc = "Rename" } },
	{ n___, "a",                 function() require("nvim-tree.api").fs.create() end,                      { desc = "Create File Or Directory" } },
	{ n___, "c",                 function() require("nvim-tree.api").fs.copy.node() end,                   { desc = "Copy" } },
	{ n___, "d",                 function() require("nvim-tree.api").fs.trash() end,                       { desc = "Trash" } },
	{ n___, "p",                 function() require("nvim-tree.api").fs.paste() end,                       { desc = "Paste" } },
	{ n___, "x",                 function() require("nvim-tree.api").fs.cut() end,                         { desc = "Cut" } },
	{ n___, "y",                 function() require("nvim-tree.api").fs.copy.filename() end,               { desc = "Copy Name" } },
	{ n___, "Y",                 function() require("nvim-tree.api").fs.copy.relative_path() end,          { desc = "Copy Relative Path" } },
	{ n___, "O",                 function() require("nvim-tree.api").node.run.system() end,                { desc = "Run System" } },
}

-------------------------------------------------------------------------------- NEO-TREE
M.plugins.neotree = {
	base = {
		-- window
		["|"]             = "close_window",
		["<F5>"]          = "refresh",
		["<?>"]           = "show_help",
		["<TAB>"]         = "next_source",
		["<S-TAB>"]       = "prev_source",
		-- navigation
		["l"]             = function(state) M.fn.filetree_expand_or_descend(state) end,
		["<RIGHT>"]       = function(state) M.fn.filetree_expand_or_descend(state) end,
		["h"]             = function(state) M.fn.filetree_collapse_or_ascend(state) end,
		["<LEFT>"]        = function(state) M.fn.filetree_collapse_or_ascend(state) end,
		["<A-CR>"]        = { "toggle_preview", config = { use_float = true } },
		["<2-LeftMouse>"] = "open",
		["<CR>"]          = "open",
		-- ["<C-h>"] = "open_split",
		-- ["<C-v>"] = "open_vsplit",
		["<C-h>"]         = "split_with_window_picker",
		["<C-v>"]         = "vsplit_with_window_picker",
		["<C-t>"]         = "open_tabnew",
		["C"]             = "close_node",
		["z"]             = "close_all_nodes",
		["Z"]             = "expand_all_nodes",
		["a"]             = { "add", config = { show_path = "relative" } },
		["<DEL>"]         = "delete",
		["<F2>"]          = { "move", config = { show_path = "relative" } }, -- (rename)
		["<C-r>"]         = { "move", config = { show_path = "relative" } }, -- (rename)
		["y"]             = "copy_to_clipboard",
		["x"]             = "cut_to_clipboard",
		["p"]             = "paste_from_clipboard",
		["c"]             = "copy",
	},
	filesystem = {
		["<A-.>"] = "navigate_up",
		["."]     = "set_root",
		["H"]     = "toggle_hidden",
		["/"]     = "fuzzy_finder",
		["D"]     = "fuzzy_finder_directory",
		["f"]     = "filter_on_submit",
		["<ESC>"] = "clear_filter",
		["[h"]    = "prev_git_modified",
		["]h"]    = "next_git_modified",
	},
	buffers = {
		["bd"]   = "buffer_delete",
		["<bs>"] = "navigate_up",
		["."]    = "set_root",
	},
	gitstatus = {
		["A"]  = "git_add_all",
		["gu"] = "git_unstage_file",
		["ga"] = "git_add_file",
		["gr"] = "git_revert_file",
		["gc"] = "git_commit",
		["gp"] = "git_push",
		["gg"] = "git_commit_and_push",
	}
}

-------------------------------------------------------------------------------- BLINK
M.plugins.blink = {
	preset = "none",

	["<C-Space>"] = { "show", "select_next", "fallback" },

	["<C-y>"] = { "accept", "fallback" },
	["<C-e>"] = { "hide", "fallback" },
	["<C-p>"] = { "select_prev", "fallback" },
	["<C-n>"] = { "select_next", "fallback" },

	["<CR>"] = { "accept", "fallback" },
	-- ["<ESC>"] = { "hide", "fallback" },
	-- ["<Down>"] = { "select_next", "fallback" },
	-- ["<Up>"] = { "select_prev", "fallback" },

	["<C-q>"] = { "show_documentation", "hide_documentation", "fallback" },
	["<C-d>"] = { "scroll_documentation_down", "fallback" },
	["<C-u>"] = { "scroll_documentation_up", "fallback" },

	["<Tab>"] = { "snippet_forward", "fallback" },
	["<S-Tab>"] = { "snippet_backward", "fallback" },

}

-------------------------------------------------------------------------------- NVIM-JDTLS
M.plugins.jdtls = {
	-- TODO: add abstract functions?
	{ n_i_, "<A-i>",                 function() require("jdtls").organize_imports() end,                 { desc = "Organize imports" } },
	{ n_i_, "<F6>",                  function() require("jdtls").pick_test() end,                        { desc = "Pick test" } },
	{ n_i_, { "<S-F6>", "<F18>" },   function() require("jdtls").test_class() end,                       { desc = "Test class" } },
	{ n_i_, { "<C-F6>", "<F30>" },   function() require("jdtls").test_nearest_method() end,              { desc = "Test method" } },
	{ n_i_, { "<C-S-F7>", "<F43>" }, function() require("jdtls.dap").setup_dap_main_class_configs() end, { desc = "Setup debug launch config" } },
	{ n_i_, { "<C-F7>", "<F31>" },   cmd("JdtUpdateHotcode"),                                            { desc = "Hotcode replace" } },
	{ n_i_, "<C-A-b>",               function() require("jdtls").super_implementation() end,             { desc = "Go to super implementation" } },
}

-------------------------------------------------------------------------------- DAPUI
M.plugins.dapui = {
	["edit"]   = "e",
	["expand"] = "<CR>",
	["open"]   = { "o", "p" },
	["remove"] = { "d", "<DEL>" },
	["repl"]   = "r",
	["toggle"] = "t"
}

-------------------------------------------------------------------------------- ALIGN
M.plugins.align = {
	["start"]              = M.leader .. "a",
	["start_with_preview"] = M.leader .. "A",
}

-------------------------------------------------------------------------------- AERIAL
M.plugins.aerial = {
	base = {
		["?"]        = "actions.show_help",
		["g?"]       = false,
		["<CR>"]     = "actions.jump",
		["<C-v>"]    = "actions.jump_vsplit",
		["<C-h>"]    = "actions.jump_split",
		["p"]        = "actions.scroll",
		["<C-j>"]    = "actions.down_and_scroll",
		["<C-k>"]    = "actions.up_and_scroll",
		["{"]        = "actions.prev",
		["}"]        = "actions.next",
		["[["]       = "actions.prev_up",
		["]]"]       = "actions.next_up",
		["q"]        = "actions.close",
		["o"]        = "actions.tree_toggle",
		["za"]       = "actions.tree_toggle",
		["O"]        = "actions.tree_toggle_recursive",
		["zA"]       = "actions.tree_toggle_recursive",
		["l"]        = "actions.tree_open",
		["<RIGHT>"]  = "actions.tree_open",
		["zo"]       = "actions.tree_open",
		["L"]        = "actions.tree_open_recursive",
		["<S-RIGHT"] = "actions.tree_open_recursive",
		["zO"]       = "actions.tree_open_recursive",
		["h"]        = "actions.tree_close",
		["<LEFT>"]   = "actions.tree_close",
		["zc"]       = "actions.tree_close",
		["H"]        = "actions.tree_close_recursive",
		["<S-Left>"] = "actions.tree_close_recursive",
		["zC"]       = "actions.tree_close_recursive",
		["zr"]       = "actions.tree_increase_fold_level",
		["zR"]       = "actions.tree_open_all",
		["zm"]       = "actions.tree_decrease_fold_level",
		["zM"]       = "actions.tree_close_all",
		["zx"]       = "actions.tree_sync_folds",
		["zX"]       = "actions.tree_sync_folds",
	},
	nav = {
		["<CR>"]  = "actions.jump",
		["p"]     = "actions.scroll",
		["<C-v>"] = "actions.jump_vsplit",
		["<C-s>"] = "actions.jump_split",
		["h"]     = "actions.left",
		["l"]     = "actions.right",
		["<Esc>"] = "actions.close",
		["q"]     = "actions.close",
	}
}


function M.set(bindings)
	for _, keybind in ipairs(bindings) do
		if type(keybind[2]) == "string" then
			vim.keymap.set(keybind[1], keybind[2], keybind[3], keybind[4] or {})
		else
			for _, mapping in ipairs(keybind[2]) do
				vim.keymap.set(keybind[1], mapping, keybind[3], keybind[4] or {})
			end
		end
	end
end

function M.set_with_opts(opts, bindings)
	for _, keybind in ipairs(bindings) do
		opts = vim.tbl_deep_extend("keep", keybind[4], opts)
		if type(keybind[2]) == "string" then
			vim.keymap.set(keybind[1], keybind[2], keybind[3], opts)
		else
			for _, mapping in ipairs(keybind[2]) do
				vim.keymap.set(keybind[1], mapping, keybind[3], opts)
			end
		end
	end
end

function M.add_lang_map(mappings)
	for _, mapping in ipairs(mappings) do
		vim.opt.langmap:append(mapping[1] .. mapping[2])
		if mapping[3] or false then
			vim.opt.langmap:append(mapping[2] .. mapping[1])
		end
	end
end

function M.apply()
	vim.g.mapleader = M.leader
	vim.g.maplocalleader = M.localleader
	M.set(M.mappings)
	-- M.add_lang_map(langmaps.italian141)
	-- M.add_lang_map(langmaps.custom)
	-- M.add_lang_map(langmaps.eretic)
end

function M.implement(implementations)
	M.fn = vim.tbl_extend("force", M.fn, implementations)
end

return M
