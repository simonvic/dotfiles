-- TODO: toggle bool (<C-x> set to false, <C-a> set to true)
-- TODO: surround to gs

local M = {}

---@class simonvic.keybindings.Modes
M.modes = {
	n___ = { "n" },
	_v__ = { "v" },
	_x__ = { "x" },
	__i_ = { "i" },
	___t = { "t" },
	nvi_ = { "n", "v", "i" },
	nsi_ = { "n", "s", "i" },
	nv__ = { "n", "v" },
	nx__ = { "n", "x" },
	n_i_ = { "n", "i" },
	n_it = { "n", "i", "t" },
	n__t = { "n", "t" },
	_vi_ = { "v", "i" },
	_xo_ = { "x", "o" },
	nxo_ = { "n", "x", "o" },
	c___ = { "c" },
}

---@class simonvic.keybindings.Util
M.util = {
	cmd = function(command) return "<Cmd>" .. command .. "<CR>" end,
	cmd_sel = function(command) return "'<,'>" .. command .. "<CR>" end,
	cmd_esc = function(command) return "<Cmd>" .. command .. "<CR><ESC>" end,

	feed = function(keys, termcodes)
		termcodes = termcodes or true
		if termcodes then
			keys = vim.api.nvim_replace_termcodes(keys, true, true, true)
		end
		vim.api.nvim_feedkeys(keys, "n", false)
	end,

	not_implemented = function(name)
		name = name or "Key mapping"
		vim.notify(name .. " not implemented", vim.log.levels.WARN)
	end,
}

-- shortcuts
local m = M.modes
local cmd = M.util.cmd

local foldcolumn = vim.opt.foldcolumn
local signcolumn = vim.opt.signcolumn

---@class simonvic.keybindings.Implementations
M.fn = {

	toggle_list_chars           = function() vim.opt.list = not vim.opt.list:get() end,
	-- TODO: if == "no" then update signcolumn
	toggle_fold_column          = function() vim.opt.foldcolumn = vim.opt.foldcolumn:get() == "0" and foldcolumn or "0" end,
	toggle_sign_column          = function() vim.opt.signcolumn = vim.opt.signcolumn:get() == "no" and signcolumn or "no" end,
	toggle_line_number          = function() vim.opt.number = not vim.opt.number:get() end,
	toggle_relative_number      = function() vim.opt.relativenumber = not vim.opt.relativenumber:get() end,
	toggle_inlay_hints          = function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
	toggle_document_colors      = function() vim.lsp.document_color.enable(not vim.lsp.document_color.is_enabled()) end,

	terminal                    = function() vim.cmd("botright terminal") end,
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
	hover                       = vim.lsp.buf.hover,
	signature_help              = function() vim.lsp.buf.signature_help({ anchor_bias = "above" }) end,
	format                      = vim.lsp.buf.format,
	format_selected             = function()
		vim.lsp.buf.format({
			range = {
				["start"] = vim.api.nvim_buf_get_mark(0, "<"),
				["end"] = vim.api.nvim_buf_get_mark(0, ">")
			}
		})
	end,

	-- plugin abstractions

	commands_menu               = function() M.util.not_implemented("commands_menu") end,

	-- eventually add default implementation with netrw
	filetree_focus              = function() vim.cmd("Lexplore") end,
	filetree_toggle             = function() M.util.not_implemented("filetree_toggle") end,
	filetree_refresh            = function() M.util.not_implemented("filetree_refresh") end,
	filetree_expand_or_descend  = function() M.util.not_implemented("filetree_expand_or_descend") end,
	filetree_collapse_or_ascend = function() M.util.not_implemented("filetree_collapse_or_ascend") end,
	filetree_vcs_change_next    = function() M.util.not_implemented("filetree_vcs_change_next") end,
	filetree_vcs_change_prev    = function() M.util.not_implemented("filetree_vcs_change_prev") end,

	symbols_outline_focus       = function() M.util.not_implemented("symbols_outline_focus") end,
	symbols_outline_float       = function() M.util.not_implemented("symbols_outline_float") end,

	undotree                    = function() M.util.not_implemented("undotree") end,

	zen_mode                    = function()
		local colorcolumns = vim.split(vim.o.colorcolumn, ",")
		local width = tonumber(colorcolumns[#colorcolumns]:gsub("+", ""):gsub("-", "") or "80") + 20
		vim.api.nvim_open_win(0, true, {
			relative = "editor",
			width = width,
			height = math.floor(vim.api.nvim_win_get_height(0) * 0.95),
			focusable = true,
			row = 2,
			col = vim.o.columns / 2 - width / 2,
			zindex = 50,
			title = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t"),
			title_pos = "center",
		})
	end,

	toggle_context              = function() M.util.not_implemented("toggle_context") end,
	find_files                  = function() M.util.feed(":edit **/*") end,
	fuzzy_find                  = function() M.util.feed(":grep %<left><left> ") end,
	live_grep                   = function() M.util.feed(":grep ") end,
	buffers                     = function() M.util.feed(":buffer ") end,

	vcs_change_next             = function() M.util.not_implemented("vcs_change_next") end,
	vcs_change_prev             = function() M.util.not_implemented("vcs_change_prev") end,
	vcs_change_preview          = function() M.util.not_implemented("vcs_change_preview") end,
	vcs_change_preview_inline   = function() M.util.not_implemented("vcs_change_preview_inline") end,
	vcs_change_select           = function() M.util.not_implemented("vcs_change_select") end,
	vcs_blame                   = function() M.util.not_implemented("vcs_blame") end,
	vcs_blame_line              = function() M.util.not_implemented("vcs_blame_line") end,
	vcs_reset                   = function() M.util.not_implemented("vcs_reset") end,
	vcs_reset_buffer            = function() M.util.not_implemented("vcs_reset_buffer") end,

	toggle_debugger             = function() M.util.not_implemented("toggle_debugger") end,
	debugger_continue           = function() M.util.not_implemented("debugger_continue") end,
	debugger_terminate          = function() M.util.not_implemented("debugger_terminate") end,
	debugger_rerun              = function() M.util.not_implemented("debugger_rerun") end,
	debugger_stepover           = function() M.util.not_implemented("debugger_stepover") end,
	debugger_stepin             = function() M.util.not_implemented("debugger_stepin") end,
	debugger_stepout            = function() M.util.not_implemented("debugger_stepout") end,
	breakpoint_toggle           = function() M.util.not_implemented("breakpoint_toggle") end,
	breakpoint_condition        = function() M.util.not_implemented("breakpoint_condition") end,
	breakpoint_log              = function() M.util.not_implemented("breakpoint_log") end,
	breapoint_condition_log     = function() M.util.not_implemented("breapoint_condition_log") end,
	inspect_variable            = function() M.util.not_implemented("inspect_variable") end,

	cursors_add_down            = function() M.util.not_implemented("cursors_add_down") end,
	cursors_add_up              = function() M.util.not_implemented("cursors_add_up") end,
	cursors_add_word            = function() M.util.not_implemented("cursors_add_word") end,
	cursors_add_selection       = function() M.util.not_implemented("cursors_add_selection") end,
	cursors_skip_selection      = function() M.util.not_implemented("cursors_skip_selection") end,
	cursors_align               = function() M.util.not_implemented("cursors_align") end,
	cursors_toggle              = function() M.util.not_implemented("cursors_toggle") end,
	cursors_delete              = function() M.util.not_implemented("cursors_delete") end,
	cursors_clear               = function() M.util.not_implemented("cursors_clear") end,

	color_picker                = function() M.util.not_implemented("color_picker") end,

	notif_history               = function() M.util.not_implemented("notif_history") end,
	notif_dismiss               = function() M.util.not_implemented("notif_dismiss") end,

	-- TODO: builtin implementation?
	move_argument_next          = function() M.util.not_implemented("move_argument_next") end,
	move_argument_prev          = function() M.util.not_implemented("move_argument_prev") end,
	move_function_next          = function() M.util.not_implemented("move_function_next") end,
	move_function_prev          = function() M.util.not_implemented("move_function_prev") end,
	move_class_next             = function() M.util.not_implemented("move_class_next") end,
	move_class_prev             = function() M.util.not_implemented("move_class_prev") end,

	goto_next_function          = function() M.util.not_implemented("goto_next_function") end,
	goto_next_argument          = function() M.util.not_implemented("goto_next_argument") end,
	goto_next_class             = function() M.util.not_implemented("goto_next_class") end,
	goto_next_comment           = function() M.util.not_implemented("goto_next_comment") end,
	goto_prev_function          = function() M.util.not_implemented("goto_prev_function") end,
	goto_prev_argument          = function() M.util.not_implemented("goto_prev_argument") end,
	goto_prev_class             = function() M.util.not_implemented("goto_prev_class") end,
	goto_prev_comment           = function() M.util.not_implemented("goto_prev_comment") end,

	select_around_function      = function() M.util.not_implemented("select_around_function") end,
	select_inside_function      = function() M.util.not_implemented("select_inside_function") end,
	select_around_argument      = function() M.util.not_implemented("select_around_argument") end,
	select_inside_argument      = function() M.util.not_implemented("select_inside_argument") end,
	select_around_class         = function() M.util.not_implemented("select_around_class") end,
	select_inside_class         = function() M.util.not_implemented("select_inside_class") end,
	select_around_comment       = function() M.util.not_implemented("select_around_comment") end,
	select_inside_comment       = function() M.util.not_implemented("select_inside_comment") end,

}

M.leader = " "
M.localleader = " "

---@alias simonvic.keybindings.Mapping [simonvic.keybindings.Modes, string|string[], string|function, vim.keymap.set.Opts]
---@alias simonvic.keybindings.Mappings simonvic.keybindings.Mapping[]

---@type simonvic.keybindings.Mappings
M.mappings = {
	-- modes, lhs,                                  rhs,                                             options
	{ m.nx__, "-",                                  "/",                                             { desc = "Search forward" } },
	{ m.nx__, "_",                                  "?",                                             { desc = "Search backward" } },
	{ m.nx__, "è",                                  "[",                                             { desc = "Backward [ alias", remap = true } },
	{ m.nx__, "+",                                  "]",                                             { desc = "Forward ] alias", remap = true } },
	--------------------------------------------------------------------------- ACTIONS
	{ m.nvi_, "<C-s>",                              cmd("write"),                                    { desc = "Save", silent = true } },
	{ m.n___, "U",                                  cmd("redo"),                                     { desc = "Redo", silent = true } },
	{ m.nx__, { "<A-CR>", "gra" },                  function() M.fn.code_actions() end,              { desc = "Code actions" } },
	{ m.n___, { "<C-b>", "grd" },                   function() M.fn.definition() end,                { desc = "Go to definition" } },
	{ m.__i_, "<C-b>",                              function() M.fn.definition() end,                { desc = "Go to definition" } },
	{ m.n___, { "gri" },                            function() M.fn.implementation() end,            { desc = "Go to implementation" } },
	{ m.n___, { "<A-r>", "grr" },                   function() M.fn.references() end,                { desc = "Find references" } },
	{ m.__i_, "<A-r>",                              function() M.fn.references() end,                { desc = "Find references" } },
	{ m.n___, { "<C-r>", "grn" },                   function() M.fn.rename() end,                    { desc = "Rename" } },
	{ m.__i_, "<C-r>",                              function() M.fn.rename() end,                    { desc = "Rename" } },
	{ m.n___, { "<C-q>", "grq" },                   function() M.fn.hover() end,                     { desc = "Open docs" } },
	{ m.__i_, "<C-q>",                              function() M.fn.hover() end,                     { desc = "Open docs" } },
	{ m.nsi_, "<C-'>",                              function() M.fn.signature_help() end,            { desc = "Signature help" } },
	{ m.n___, "<leader>d",                          function() M.fn.diagnostic_show() end,           { desc = "Show diagnostics" } },
	{ m.__i_, "<C-e>",                              function() M.fn.diagnostic_show() end,           { desc = "Show diagnostics" } },
	{ m.n___, "<leader>D",                          function() M.fn.diagnostic_show_all() end,       { desc = "Show diagnostics for entire project" } },
	--------------------------------------------------------------------------- MOVEMENT
	{ m.nxo_, "]h",                                 function() M.fn.vcs_change_next() end,           { desc = "Go next hunk" } },
	{ m.nxo_, "[h",                                 function() M.fn.vcs_change_prev() end,           { desc = "Go prev hunk" } },
	{ m.n___, "<leader>h",                          function() M.fn.vcs_change_preview_inline() end, { desc = "Preview hunk diff inline" } },
	{ m.n___, "<leader>H",                          function() M.fn.vcs_change_preview() end,        { desc = "Preview hunk diff" } },
	{ m.nxo_, "]d",                                 function() M.fn.diagnostic_next() end,           { desc = "Go next diagnostic" } },
	{ m.nxo_, "[d",                                 function() M.fn.diagnostic_prev() end,           { desc = "Go prev diagnostic" } },
	{ m.nxo_, "]f",                                 function() M.fn.goto_next_function() end,        { desc = "Go to next function" } },
	{ m.nxo_, "]a",                                 function() M.fn.goto_next_argument() end,        { desc = "Go to next argument" } },
	{ m.nxo_, "]c",                                 function() M.fn.goto_next_class() end,           { desc = "Go to next class" } },
	{ m.nxo_, "]k",                                 function() M.fn.goto_next_comment() end,         { desc = "Go to next comment" } },
	{ m.nxo_, "[f",                                 function() M.fn.goto_prev_function() end,        { desc = "Go to previous function" } },
	{ m.nxo_, "[a",                                 function() M.fn.goto_prev_argument() end,        { desc = "Go to previous argument" } },
	{ m.nxo_, "[c",                                 function() M.fn.goto_prev_class() end,           { desc = "Go to previous class" } },
	{ m.nxo_, "[k",                                 function() M.fn.goto_prev_comment() end,         { desc = "Go to previous comment" } },
	---------------------------------------------------------------------------- EDITING
	{ m.n___, "<C-A-l>",                            "gg=G<C-o>",                                     { desc = "Reindent file" } },
	{ m.n_i_, "<A-S-l>",                            function() M.fn.format() end,                    { desc = "Reformat" } },
	{ m._x__, "<A-S-l>",                            function() M.fn.format_selected() end,           { desc = "Reformat selection" } },
	{ m._x__, "<TAB>",                              ">gv",                                           { desc = "Increase indent" } },
	{ m._x__, "<S-TAB>",                            "<gv",                                           { desc = "Decrease indent" } },
	{ m.nv__, "<leader>gl",                         ":diffget REMOTE<CR>",                           { desc = "Diffget remote" } },
	{ m.nv__, "<leader>gh",                         ":diffget LOCAL<CR>",                            { desc = "Diffget local" } },
	{ m.nv__, "<leader>gk",                         ":diffget BASE<CR>",                             { desc = "Diffget base" } },
	{ m.n___, "<leader>gb",                         function() M.fn.vcs_blame_line() end,            { desc = "Blame current line" } },
	{ m.n___, "<leader>gB",                         function() M.fn.vcs_blame() end,                 { desc = "Blame current buffer" } },
	{ m._xo_, "ah",                                 function() M.fn.vcs_change_select() end,         { desc = "Select around hunk" } },
	{ m.n___, "<leader>gr",                         function() M.fn.vcs_reset() end,                 { desc = "VCS reset hunk" } },
	{ m.n___, "<leader>gR",                         function() M.fn.vcs_reset_buffer() end,          { desc = "VCS reset entire buffer" } },
	{ m.n___, "mal",                                function() M.fn.move_argument_next() end,        { desc = "Move argument to next" } },
	{ m.n___, "mah",                                function() M.fn.move_argument_prev() end,        { desc = "Move argument to previous" } },
	{ m.n___, "mfl",                                function() M.fn.move_function_next() end,        { desc = "Move function to next" } },
	{ m.n___, "mfh",                                function() M.fn.move_function_prev() end,        { desc = "Move function to previous" } },
	{ m.n___, "mcl",                                function() M.fn.move_class_next() end,           { desc = "Move class to next" } },
	{ m.n___, "mch",                                function() M.fn.move_class_prev() end,           { desc = "Move class to previous" } },
	{ m._xo_, "af",                                 function() M.fn.select_around_function() end,    { desc = "Select around function" } },
	{ m._xo_, "if",                                 function() M.fn.select_inside_function() end,    { desc = "Select inside function" } },
	{ m._xo_, "aa",                                 function() M.fn.select_around_argument() end,    { desc = "Select around argument" } },
	{ m._xo_, "ia",                                 function() M.fn.select_inside_argument() end,    { desc = "Select inside argument" } },
	{ m._xo_, "ac",                                 function() M.fn.select_around_class() end,       { desc = "Select around class" } },
	{ m._xo_, "ic",                                 function() M.fn.select_inside_class() end,       { desc = "Select inside class" } },
	{ m._xo_, "ak",                                 function() M.fn.select_around_comment() end,     { desc = "Select around comment" } },
	{ m._xo_, "ik",                                 function() M.fn.select_inside_comment() end,     { desc = "Select inside comment" } },
	---------------------------------------------------------------------------- WINDOWS
	{ m.n_i_, "<A-PageUp>",                         cmd("bnext"),                                    { desc = "Next buffer" } },
	{ m.n_i_, "<A-PageDown>",                       cmd("bprevious"),                                { desc = "Previous buffer" } },
	{ m.n_i_, "<C-t>",                              cmd("tabnew"),                                   { desc = "New tab" } },
	{ m.n_i_, { "<C-F4>", "<F28>" },                cmd("tabclose"),                                 { desc = "Close tab" } },
	{ m.n_i_, { "<C-S-F4>", "<F40>" },              cmd("tabdo close"),                              { desc = "Close all tabs" } },
	{ m.n_i_, "<C-PageUp>",                         cmd("tabprevious"),                              { desc = "Previous tab" } },
	{ m.n_i_, "<C-PageDown>",                       cmd("tabnext"),                                  { desc = "Next tab" } },
	{ m.n_i_, "<C-S-PageUp>",                       cmd("-tabmove"),                                 { desc = "Move tab to left" } },
	{ m.n_i_, "<C-S-PageDown>",                     cmd("+tabmove"),                                 { desc = "Move tab to right" } },
	{ m.n___, "|",                                  function() M.fn.filetree_focus() end,            { desc = "Focus filetree" } },
	{ m.n__t, { "<A-S-ù>", "<A-§>" },               function() M.fn.terminal() end,                  { desc = "Toggle dropdown terminal" } },
	{ m.n__t, "<A-ù>",                              function() M.fn.terminal_float() end,            { desc = "Toggle floating terminal" } },
	{ m.___t, "<Esc>",                              "<C-\\><C-n>",                                   { desc = "Exit terminal mode" } },
	{ m.n___, { "<leader><leader>", "<C-p>" },      function() M.fn.find_files() end,                { desc = "Find files" } },
	{ m.n___, "<A-p>",                              function() M.fn.commands_menu() end,             { desc = "Commands menu" } },
	{ m.n___, "<leader>:",                          function() M.fn.commands() end,                  { desc = "Commands palette" } },
	{ m.n___, { "<leader>S", "<C-A-p>" },           function() M.fn.workspace_symbols() end,         { desc = "Find workspace symbols" } },
	{ m.__i_, "<C-A-p>",                            function() M.fn.workspace_symbols() end,         { desc = "Find workspace symbols" } },
	{ m.n___, "gO",                                 function() M.fn.document_symbols() end,          { desc = "Find document symbols" } },
	{ m.n___, { "<leader><tab>", "<A-Tab>" },       function() M.fn.buffers() end,                   { desc = "Buffers" } },
	{ m.__i_, "<A-Tab>",                            function() M.fn.buffers() end,                   { desc = "Buffers" } },
	{ m.n___, "<leader>f",                          function() M.fn.fuzzy_find() end,                { desc = "Fuzzy find" } },
	{ m.__i_, "<C-f>",                              function() M.fn.fuzzy_find() end,                { desc = "Fuzzy find" } },
	{ m.n___, { "<leader>F", "<C-A-F>" },           function() M.fn.live_grep() end,                 { desc = "Live grep" } },
	{ m.__i_, "<C-A-f>",                            function() M.fn.live_grep() end,                 { desc = "Live grep" } },
	---------------------------------------------------------------------------- UI
	{ m.n___, "<Leader>ud",                         function() M.fn.toggle_debugger() end,           { desc = "Toggle debugger UI" } },
	{ m.n___, "<Leader>ul",                         function() M.fn.toggle_list_chars() end,         { desc = "Toggle list chars" } },
	{ m.n___, "<Leader>uk",                         function() M.fn.toggle_context() end,            { desc = "Toggle code context (scope)" } },
	{ m.n___, "<Leader>uz",                         function() M.fn.toggle_fold_column() end,        { desc = "Toggle folds column" } },
	{ m.n___, "<Leader>us",                         function() M.fn.toggle_sign_column() end,        { desc = "Toggle signs column" } },
	{ m.n___, "<Leader>un",                         function() M.fn.toggle_relative_number() end,    { desc = "Toggle relative number column" } },
	{ m.n___, "<Leader>uN",                         function() M.fn.toggle_line_number() end,        { desc = "Toggle number column" } },
	{ m.n___, "<Leader>uh",                         function() M.fn.toggle_inlay_hints() end,        { desc = "Toggle lsp inlay hints" } },
	{ m.n___, "<Leader>uc",                         function() M.fn.toggle_document_colors() end,    { desc = "Toggle lsp document colors" } },
	{ m.n___, "<Leader>uZ",                         function() M.fn.zen_mode() end,                  { desc = "Toggle zen mode" } },
	{ m.n___, "<Leader>uu",                         function() M.fn.undotree() end,                  { desc = "Toggle Undotree" } },
	{ m.n___, "<A-9>",                              function() M.fn.symbols_outline_focus() end,     { desc = "Toggle symbols outline" } },
	{ m.n___, { "<A-S-9>", "<A-)>" },               function() M.fn.symbols_outline_float() end,     { desc = "Toggle symbols outline floating navigation" } },
	{ m.n___, "<leader>s",                          function() M.fn.symbols_outline_float() end,     { desc = "Toggle symbols outline floating navigation" } },
	{ m.n___, "<Leader>nh",                         function() M.fn.notif_history() end,             { desc = "Show notifications history" } },
	{ m.n___, "<Leader>nd",                         function() M.fn.notif_dismiss() end,             { desc = "Dismiss notifications" } },
	---------------------------------------------------------------------------- DEBUGGING
	{ m.n___, "<F7>",                               function() M.fn.debugger_continue() end,         { desc = "DAP Continue" } },
	{ m.n___, { "<A-F7>", "<F55>" },                function() M.fn.debugger_terminate() end,        { desc = "DAP Terminate" } },
	{ m.n___, { "<S-F7>", "<F19>" },                function() M.fn.debugger_rerun() end,            { desc = "DAP Run last" } },
	{ m.n___, "<F8>",                               function() M.fn.debugger_stepover() end,         { desc = "DAP Step over" } },
	{ m.n___, { "<C-F8>", "<F32>" },                function() M.fn.debugger_stepin() end,           { desc = "DAP Step into" } },
	{ m.n___, { "<S-F8>", "<F20>" },                function() M.fn.debugger_stepout() end,          { desc = "DAP Step out" } },
	{ m.n___, "<F9>",                               function() M.fn.breakpoint_toggle() end,         { desc = "DAP Breakpoint" } },
	{ m.n___, { "<C-F9>", "<F33>" },                function() M.fn.breakpoint_condition() end,      { desc = "DAP Conditional breakpoint" } },
	{ m.n___, { "<A-F9>", "<F57>" },                function() M.fn.breakpoint_log() end,            { desc = "DAP Log breakpoint" } },
	{ m.n___, { "<S-F9>", "<F21>" },                function() M.fn.breapoint_condition_log() end,   { desc = "DAP Conditional log breakpoint" } },
	{ m.nx__, "<A-C-q>",                            function() M.fn.inspect_variable() end,          { desc = "DAP Inspect variable" } },
	---------------------------------------------------------------------------- Multicursor
	{ m.n___, { "<leader>cj", "<C-J>", "<C-S-j>" }, function() M.fn.cursors_add_down() end,          { desc = "Add cursor and move down" } },
	{ m.n___, { "<leader>ck", "<C-K>", "<C-S-K>" }, function() M.fn.cursors_add_up() end,            { desc = "Add cursor and move up" } },
	{ m.n___, { "<leader>cw", "<C-*>", },           function() M.fn.cursors_add_word() end,          { desc = "Add cursor and do * movement" } },
	{ m._v__, { "<leader>cn", },                    function() M.fn.cursors_add_selection() end,     { desc = "Add cursor and move to next selection" } },
	{ m._v__, { "<leader>cs", },                    function() M.fn.cursors_skip_selection() end,    { desc = "Move to next selection" } },
	{ m.n___, { "<leader>ca", "<C-S-A>" },          function() M.fn.cursors_align() end,             { desc = "Align cursors" } },
	{ m.n___, { "<leader>ct", "<C-S-X>" },          function() M.fn.cursors_toggle() end,            { desc = "Toggle cursors" } },
	{ m.n___, "<leader>cd",                         function() M.fn.cursors_delete() end,            { desc = "Delete last cursor" } },
	{ m.n___, { "<leader>cD", "<C-S-D>" },          function() M.fn.cursors_clear() end,             { desc = "Clear cursors" } },
	---------------------------------------------------------------------------- Color picker
	{ m.n___, "<leader>C",                          function() M.fn.color_picker() end,              { desc = "Open color picker" } },
	--------------------------------------------------------------------------- OTHER
	{ m.c___, "<C-p>",                              "<Up>",                                          { desc = "Previous command starting with current text" } },
	{ m.c___, "<C-n>",                              "<Down>",                                        { desc = "Next command starting with current text" } },
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

---@type simonvic.keybindings.Mappings
M.plugins.nvimtree = {
	{ m.n___, "|",                 function() require("nvim-tree.api").tree.toggle() end,                    { desc = "Toggle filetree" } },
	{ m.n___, "<F5>",              function() require("nvim-tree.api").tree.reload() end,                    { desc = "Refresh filetree" } },
	{ m.n___, { "l", "<Right>" },  function() M.fn.filetree_expand_or_descend() end,                         { desc = "Expand filetree node or descend" } },
	{ m.n___, { "h", "<Left>" },   function() M.fn.filetree_collapse_or_ascend() end,                        { desc = "Collapse filetree node or ascend" } },
	{ m.n___, "g?",                function() require("nvim-tree.api").tree.toggle_help() end,               { desc = "Help" } },
	{ m.n___, "<C-k>",             function() require("nvim-tree.api").node.show_info_popup() end,           { desc = "Info" } },
	-- opening
	{ m.n___, "<A-CR>",            function() require("nvim-tree.api").node.open.preview() end,              { desc = "Open: In Place" } },
	{ m.n___, "<CR>",              function() require("nvim-tree.api").node.open.edit() end,                 { desc = "Open" } },
	{ m.n___, "<C-v>",             function() require("nvim-tree.api").node.open.vertical() end,             { desc = "Open: Vertical Split" } },
	{ m.n___, "<C-h>",             function() require("nvim-tree.api").node.open.horizontal() end,           { desc = "Open: Horizontal Split" } },
	{ m.n___, "<C-t>",             function() require("nvim-tree.api").node.open.tab() end,                  { desc = "Open: New Tab" } },
	-- navigation
	{ m.n___, "<A-.>",             function() require("nvim-tree.api").tree.change_root_to_parent() end,     { desc = "Up" } },
	{ m.n___, ".",                 function() require("nvim-tree.api").tree.change_root_to_node() end,       { desc = "cd" } },
	{ m.n___, "[h",                function() M.fn.filetree_vcs_change_prev() end,                           { desc = "Prev Git" } },
	{ m.n___, "]h",                function() M.fn.filetree_vcs_change_next() end,                           { desc = "Next Git" } },
	{ m.n___, "]d",                function() require("nvim-tree.api").node.navigate.diagnostics.next() end, { desc = "Next Diagnostic" } },
	{ m.n___, "[d",                function() require("nvim-tree.api").node.navigate.diagnostics.prev() end, { desc = "Prev Diagnostic" } },
	{ m.n___, "H",                 function() require("nvim-tree.api").filter.dotfiles.toggle() end,         { desc = "Toggle Filter: Dotfiles" } },
	{ m.n___, "I",                 function() require("nvim-tree.api").filter.git.ignored.toggle() end,      { desc = "Toggle Filter: Git Ignore" } },
	{ m.n___, "zc",                function() require("nvim-tree.api").node.navigate.parent_close() end,     { desc = "Close Directory" } },
	{ m.n___, "zR",                function() require("nvim-tree.api").tree.expand_all() end,                { desc = "Expand All" } },
	{ m.n___, "zM",                function() require("nvim-tree.api").tree.collapse_all() end,              { desc = "Collapse" } },
	-- filesystem
	{ m.n___, { "<C-r>", "<F2>" }, function() require("nvim-tree.api").fs.rename() end,                      { desc = "Rename" } },
	{ m.n___, "a",                 function() require("nvim-tree.api").fs.create() end,                      { desc = "Create File Or Directory" } },
	{ m.n___, "c",                 function() require("nvim-tree.api").fs.copy.node() end,                   { desc = "Copy" } },
	{ m.n___, "d",                 function() require("nvim-tree.api").fs.trash() end,                       { desc = "Trash" } },
	{ m.n___, "p",                 function() require("nvim-tree.api").fs.paste() end,                       { desc = "Paste" } },
	{ m.n___, "x",                 function() require("nvim-tree.api").fs.cut() end,                         { desc = "Cut" } },
	{ m.n___, "y",                 function() require("nvim-tree.api").fs.copy.filename() end,               { desc = "Copy Name" } },
	{ m.n___, "Y",                 function() require("nvim-tree.api").fs.copy.relative_path() end,          { desc = "Copy Relative Path" } },
	{ m.n___, "O",                 function() require("nvim-tree.api").node.run.system() end,                { desc = "Run System" } },
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

---@type blink.cmp.KeymapConfig
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

---@type simonvic.keybindings.Mappings
M.plugins.jdtls = {
	-- TODO: add abstract functions?
	{ m.n___, "<F5>",                  function() require("jdtls").compile("incremental") end,                               { buf = 0, desc = "Compile (incremental)" } },
	{ m.n___, { "<S-F5>", "<F17>" },   function() require("jdtls").compile("full") end,                                      { buf = 0, desc = "Compile (full)" } },
	{ m.n___, { "<A-F5>", "<F53>" },   function() require("jdtls").build_projects() end,                                     { buf = 0, desc = "Build" } },
	{ m.n___, "<A-i>",                 function() require("jdtls").organize_imports() end,                                   { buf = 0, desc = "Organize imports" } },
	{ m.n___, "<F6>",                  function() require("jdtls").pick_test() end,                                          { buf = 0, desc = "Pick test" } },
	{ m.n___, { "<S-F6>", "<F18>" },   function() require("jdtls").test_class() end,                                         { buf = 0, desc = "Test class" } },
	{ m.n___, { "<C-F6>", "<F30>" },   function() require("jdtls").test_nearest_method() end,                                { buf = 0, desc = "Test method" } },
	{ m.n___, { "<C-S-F7>", "<F43>" }, function() require("jdtls.dap").setup_dap_main_class_configs({ verbose = true }) end, { buf = 0, desc = "Setup debug launch config" } },
	{ m.n___, { "<C-F7>", "<F31>" },   vim.cmd.JdtUpdateHotcode,                                                             { buf = 0, desc = "Hotcode replace" } },
	{ m.n___, { "grI", "<C-A-b>" },    function() require("jdtls").super_implementation() end,                               { buf = 0, desc = "Go to super implementation" } },
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

--------------------------------------------------------------------------------

---Set keymaps
---@param bindings simonvic.keybindings.Mappings
function M.set(bindings)
	for _, keybind in ipairs(bindings) do
		if type(keybind[2]) == "string" then
			vim.keymap.set(keybind[1], keybind[2] --[[@as string]], keybind[3], keybind[4] or {})
		else
			for _, mapping in ipairs(keybind[2] --[[@as string[] ]]) do
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

--- Add a lang mapping
---@param langmap simonvic.keybindings.LangMap
function M.add_lang_map(langmap)
	for _, mapping in ipairs(langmap) do
		vim.opt.langmap:append(mapping[1] .. mapping[2])
		if mapping[3] or false then
			vim.opt.langmap:append(mapping[2] .. mapping[1])
		end
	end
end

---@alias simonvic.keybindings.LangMap [string, string, boolean?]
---@type { [string]: simonvic.keybindings.LangMap[] }
M.langmaps = {
	italian141 = {
		-- from, to, bidirectional
		{ "-", "/" },
		{ "_", "?" },
		{ "è", "[" },
		{ "+", "]" },
		{ "é", "{" },
		{ "*", "}" },
	}
}

--- Apply configured keybindings along with leader and local leader keys
function M.apply()
	vim.g.mapleader = M.leader
	vim.g.maplocalleader = M.localleader
	M.set(M.mappings)
	-- M.add_lang_map(M.langmaps.italian141)
	-- M.add_lang_map(langmaps.custom)
	-- M.add_lang_map(langmaps.eretic)
end

--- Implement keybindings
---@param implementations simonvic.keybindings.Implementations
function M.implement(implementations)
	M.fn = vim.tbl_extend("force", M.fn, implementations)
end

return M
