-- TODO: toggle bool (<C-x> set to false, <C-a> set to true)

local M = {}

M.modes = {
	n___ = { "n" },
	_v__ = { "v" },
	__i_ = { "i" },
	___t = { "t" },
	nvi_ = { "n", "v", "i" },
	nv__ = { "n", "v" },
	n_i_ = { "n", "i" },
	n_it = { "n", "i", "t" },
	n__t = { "n", "t" },
	_vi_ = { "v", "i" },
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
local n_it = M.modes.n_it
local n__t = M.modes.n__t
local cmd = M.util.cmd
local cmd_sel = M.util.cmd_sel

function M.not_implemented(name)
	name = name or "Key mapping"
	vim.notify(name .. " not implemented", vim.log.levels.WARN)
end

local foldcolumn = vim.opt.foldcolumn

local function feed(keys, termcodes)
	termcodes = termcodes or true
	if termcodes then
		keys = vim.api.nvim_replace_termcodes(keys, true, true, true)
	end
	vim.api.nvim_feedkeys(keys, "n", false)
end

M.fn = {

	toggle_list_chars           = function() vim.opt.list = not vim.opt.list:get() end,
	toggle_fold_column          = function() vim.opt.foldcolumn = vim.opt.foldcolumn:get() == "0" and foldcolumn or "0" end,
	toggle_line_number          = function() vim.opt.number = not vim.opt.number:get() end,
	toggle_relative_number      = function() vim.opt.relativenumber = not vim.opt.relativenumber:get() end,
	toggle_inlay_hints          = function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,

	terminal                    = function() vim.cmd("terminal") end,
	terminal_float              = function() vim.cmd("terminal") end,

	commands                    = function() vim.cmd("map") end,

	diagnostic_show             = vim.diagnostic.open_float,
	diagnostic_show_all         = vim.diagnostic.setqflist,
	diagnostic_next             = vim.diagnostic.goto_next,
	diagnostic_prev             = vim.diagnostic.goto_prev,

	-- TODO: add other vim.lsp.buf. functions
	code_actions                = vim.lsp.buf.code_action,
	definition                  = vim.lsp.buf.definition,
	references                  = vim.lsp.buf.references,
	rename                      = vim.lsp.buf.rename,
	open_docs                   = vim.lsp.buf.hover,
	signature_help              = vim.lsp.buf.signature_help,
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

	-- eventually add default implementation with netrw
	filetree_focus              = function() vim.cmd("Explore") end,
	filetree_toggle             = function() M.not_implemented("filetree_toggle") end,
	filetree_refresh            = function() M.not_implemented("filetree_refresh") end,
	filetree_expand_or_descend  = function() M.not_implemented("filetree_expand_or_descend") end,
	filetree_collapse_or_ascend = function() M.not_implemented("filetree_collapse_or_ascend") end,

	symbols_outline_focus       = function() M.not_implemented("symbols_outline_focus") end,
	symbols_outline_float       = function() M.not_implemented("symbols_outline_float") end,

	toggle_context              = function() M.not_implemented("toggle_context") end,
	find_files                  = function() feed(":edit **/*") end,
	find_symbols                = function() M.not_implemented("find_symbols") end,
	fuzzy_find                  = function() feed(":grep %<left><left> ") end,
	live_grep                   = function() feed(":grep ") end,
	buffers                     = function() vim.cmd("buffers") end,

	vcs_change_next             = function() M.not_implemented("vcs_change_next") end,
	vcs_change_prev             = function() M.not_implemented("vcs_change_prev") end,
	vcs_change_preview          = function() M.not_implemented("vcs_change_preview") end,
	vcs_change_preview_inline   = function() M.not_implemented("vcs_change_preview_inline") end,
	-- TODO: add blame line and some other goodies

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

	toggle_comment              = function() M.not_implemented("toggle_comment") end,
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
	{ nvi_, "<C-z>",                              cmd("undo"),                                     { desc = "Undo", silent = true } },
	{ nvi_, "<C-y>",                              cmd("redo"),                                     { desc = "Redo", silent = true } },
	{ n_i_, "<A-CR>",                             function() M.fn.code_actions() end,              { desc = "Code actions" } },
	{ n___, { "<C-b>", "gd" },                    function() M.fn.definition() end,                { desc = "Go to definition" } },
	{ __i_, "<C-b>",                              function() M.fn.definition() end,                { desc = "Go to definition" } },
	{ n___, { "<A-r>", "gr" },                    function() M.fn.references() end,                { desc = "Find references" } },
	{ __i_, "<A-r>",                              function() M.fn.references() end,                { desc = "Find references" } },
	{ n___, { "<C-r>", "<leader>r" },             function() M.fn.rename() end,                    { desc = "Rename" } },
	{ __i_, "<C-r>",                              function() M.fn.rename() end,                    { desc = "Rename" } },
	{ n___, { "<C-q>", "<leader>q" },             function() M.fn.open_docs() end,                 { desc = "Open docs" } },
	{ __i_, "<C-q>",                              function() M.fn.open_docs() end,                 { desc = "Open docs" } },
	{ n_i_, "<A-q>",                              function() M.fn.signature_help() end,            { desc = "Signature help" } },
	{ n___, { "<C-e>", "<leader>e" },             function() M.fn.diagnostic_show() end,           { desc = "Show diagnostics" } },
	{ __i_, "<C-e>",                              function() M.fn.diagnostic_show() end,           { desc = "Show diagnostics" } },
	{ n___, "<leader>E",                          function() M.fn.diagnostic_show_all() end,       { desc = "Show telescope diagnostics" } },
	--------------------------------------------------------------------------- MOVEMENT
	{ nv__, "<C-LEFT>",                           "b",                                             { desc = "Previous end" } },
	{ __i_, "<C-LEFT>",                           "<C-o>b",                                        { desc = "Previous end" } },
	{ nv__, "<C-RIGHT>",                          "e",                                             { desc = "Next word" } },
	{ __i_, "<C-RIGHT>",                          "<C-o>e<RIGHT>",                                 { desc = "Next word" } },
	{ nv__, "<HOME>",                             "^",                                             { desc = "First character" } },
	{ __i_, "<HOME>",                             "<C-o>^",                                        { desc = "First character" } },
	{ nv__, "<A-HOME>",                           "0",                                             { desc = "Start of line" } },
	{ __i_, "<A-HOME>",                           "<C-o>0",                                        { desc = "Start of line" } },
	{ nv__, "<END>",                              "g_",                                            { desc = "Last character" } },
	{ nv__, "<A-END>",                            "$",                                             { desc = "Last character" } },
	{ __i_, "<A-END>",                            "<C-o>$",                                        { desc = "End of line" } },
	{ n___, "]h",                                 function() M.fn.vcs_change_next() end,           { desc = "Go next hunk" } },
	{ n___, "[h",                                 function() M.fn.vcs_change_prev() end,           { desc = "Go prev hunk" } },
	{ n___, "<leader>gh",                         function() M.fn.vcs_change_preview_inline() end, { desc = "Preview hunk diff inline" } },
	{ n___, "<leader>gH",                         function() M.fn.vcs_change_preview() end,        { desc = "Preview hunk diff" } },
	{ n___, "]d",                                 function() M.fn.diagnostic_next() end,           { desc = "Go next diagnostic" } },
	{ n___, "[d",                                 function() M.fn.diagnostic_prev() end,           { desc = "Go prev diagnostic" } },
	{ n___, "]q",                                 cmd("cnext"),                                    { desc = "Go next quickfix list entry" } },
	{ n___, "[q",                                 cmd("cprevious"),                                { desc = "Go prev quickfix list entry" } },
	---------------------------------------------------------------------------- SELECTION
	{ n___, "<S-LEFT>",                           "v<LEFT>",                                       { desc = "Select left" } },
	{ _v__, "<S-LEFT>",                           "<LEFT>",                                        { desc = "Select left" } },
	{ __i_, "<S-LEFT>",                           "<LEFT><C-o>v",                                  { desc = "Select left" } },
	{ n___, "<S-RIGHT>",                          "v<RIGHT>",                                      { desc = "Select right" } },
	{ _v__, "<S-RIGHT>",                          "<RIGHT>",                                       { desc = "Select right" } },
	{ __i_, "<S-RIGHT>",                          "<C-o>v",                                        { desc = "Select right" } },
	{ n___, "<S-UP>",                             "v<UP>",                                         { desc = "Select up" } },
	{ _v__, "<S-UP>",                             "<UP>",                                          { desc = "Select up" } },
	{ __i_, "<S-UP>",                             "<LEFT><C-o>v<UP><RIGHT>",                       { desc = "Select up" } },
	{ n___, "<S-DOWN>",                           "v<DOWN>",                                       { desc = "Select down" } },
	{ _v__, "<S-DOWN>",                           "<DOWN>",                                        { desc = "Select down" } },
	{ __i_, "<S-DOWN>",                           "<C-o>v<DOWN><LEFT>",                            { desc = "Select down" } },
	{ n___, "<S-C-LEFT>",                         "vb",                                            { desc = "Select word left" } },
	{ _v__, "<S-C-LEFT>",                         "b",                                             { desc = "Select word left" } },
	{ __i_, "<S-C-LEFT>",                         "<LEFT><C-o>vb",                                 { desc = "Select word left" } },
	{ n___, "<S-C-RIGHT>",                        "ve",                                            { desc = "Select word right" } },
	{ _v__, "<S-C-RIGHT>",                        "e",                                             { desc = "Select word right" } },
	{ __i_, "<S-C-RIGHT>",                        "<C-o>ve",                                       { desc = "Select word right" } },
	{ n___, "<S-HOME>",                           "v^",                                            { desc = "Select to first character" } },
	{ _v__, "<S-HOME>",                           "^",                                             { desc = "Select to first character" } },
	{ __i_, "<S-HOME>",                           "<LEFT><C-o>v^",                                 { desc = "Select to first character" } },
	{ n___, "<S-A-HOME>",                         "v0",                                            { desc = "Select to start of line" } },
	{ _v__, "<S-A-HOME>",                         "0",                                             { desc = "Select to start of line" } },
	{ __i_, "<S-A-HOME>",                         "<LEFT><C-o>v0",                                 { desc = "Select to start of line" } },
	{ n___, "<S-END>",                            "vg_",                                           { desc = "Select to last character" } },
	{ _v__, "<S-END>",                            "g_",                                            { desc = "Select to last character" } },
	{ __i_, "<S-END>",                            "<C-o>vg_",                                      { desc = "Select to last character" } },
	{ n___, "<S-A-END>",                          "v$",                                            { desc = "Select to end of line" } },
	{ _v__, "<S-A-END>",                          "$",                                             { desc = "Select to end of line" } },
	{ __i_, "<S-A-END>",                          "<C-o>v$",                                       { desc = "Select to end of line" } },
	{ n___, "<S-C-HOME>",                         "vgg0",                                          { desc = "Select to start of file" } },
	{ _v__, "<S-C-HOME>",                         "gg0",                                           { desc = "Select to start of file" } },
	{ __i_, "<S-C-HOME>",                         "<LEFT><C-o>vgg0",                               { desc = "Select to start of file" } },
	{ n___, "<S-C-END>",                          "vG$",                                           { desc = "Select to end of file" } },
	{ _v__, "<S-C-END>",                          "G$",                                            { desc = "Select to end of file" } },
	{ __i_, "<S-C-END>",                          "<C-o>vG$",                                      { desc = "Select to end of file" } },
	---------------------------------------------------------------------------- EDITING
	{ n_i_, "<C-A-DOWN>",                         cmd("move +1"),                                  { desc = "Move line down", silent = true } },
	{ n___, "<leader>JJ",                         cmd("move +1"),                                  { desc = "Move line down", silent = true } },
	{ _v__, "<C-A-DOWN>",                         ":move '>+1<CR>gv",                              { desc = "Move line down", silent = true } },
	{ _v__, "<leader>JJ",                         ":move '>+1<CR>gv",                              { desc = "Move line down", silent = true } },
	{ n_i_, "<C-A-UP>",                           cmd("move -2"),                                  { desc = "Move line up", silent = true } },
	{ n___, "<leader>KK",                         cmd("move -2"),                                  { desc = "Move line up", silent = true } },
	{ _v__, "<C-A-UP>",                           ":move '<-2<CR>gv",                              { desc = "Move line up", silent = true } },
	{ _v__, "<leader>KK",                         ":move '<-2<CR>gv",                              { desc = "Move line up", silent = true } },
	{ n_i_, "<C-S-DOWN>",                         cmd("copy +0"),                                  { desc = "Copy line down", silent = true } },
	{ n___, "<leader>jj",                         cmd("copy +0"),                                  { desc = "Copy line down", silent = true } },
	{ _v__, "<C-S-DOWN>",                         ":copy '<-1<CR>gv",                              { desc = "Copy line down", silent = true } },
	{ _v__, "<leader>jj",                         ":copy '<-1<CR>gv",                              { desc = "Copy line down", silent = true } },
	{ n_i_, "<C-S-UP>",                           cmd("copy -1"),                                  { desc = "Copy line up", silent = true } },
	{ n___, "<C-S-UP>",                           cmd("copy -1"),                                  { desc = "Copy line up", silent = true } },
	{ n___, "<leader>kk",                         cmd("copy -1"),                                  { desc = "Copy line up", silent = true } },
	{ _v__, "<C-S-UP>",                           ":copy '>+0<CR>gv",                              { desc = "Copy line up", silent = true } },
	{ n___, "<C-A-l>",                            "gg=G<C-o>",                                     { desc = "Reindent file" } },
	{ n_i_, "<A-S-l>",                            function() M.fn.format() end,                    { desc = "Reformat" } },
	{ _v__, "<A-S-l>",                            function() M.fn.formatSelection() end,           { desc = "Reformat selection" } },
	{ nv__, "<leader>cc",                         function() M.fn.toggle_comment() end,            { desc = "Comment toggle" } },
	{ _v__, "<TAB>",                              ">gv",                                           { desc = "Increase indent" } },
	{ _v__, "<S-TAB>",                            "<gv",                                           { desc = "Decrease indent" } },
	{ n_i_, "<A-->",                              cmd("foldclose"),                                { desc = "Fold close" } },
	{ n_i_, "<A-+>",                              cmd("foldopen"),                                 { desc = "Fold open" } },
	---------------------------------------------------------------------------- WINDOWS
	{ n_it, "<A-LEFT>",                           cmd("wincmd h"),                                 { desc = "Focus window left" } },
	{ n_it, "<A-DOWN>",                           cmd("wincmd j"),                                 { desc = "Focus window down" } },
	{ n_it, "<A-UP>",                             cmd("wincmd k"),                                 { desc = "Focus window up" } },
	{ n_it, "<A-RIGHT>",                          cmd("wincmd l"),                                 { desc = "Focus window right" } },
	{ n_i_, "<A-S-LEFT>",                         cmd("wincmd H"),                                 { desc = "Move window left" } },
	{ n_i_, "<A-S-DOWN>",                         cmd("wincmd J"),                                 { desc = "Move window down" } },
	{ n_i_, "<A-S-UP>",                           cmd("wincmd K"),                                 { desc = "Move window up" } },
	{ n_i_, "<A-S-RIGHT>",                        cmd("wincmd L"),                                 { desc = "Move window right" } },
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
	{ __i_, "<C-p>",                              function() M.fn.find_files() end,                { desc = "Find files" } },
	{ n___, "<A-p>",                              cmd("Telescope"),                                { desc = "Telescope" } },
	{ n___, "<leader>:",                          function() M.fn.commands() end,                  { desc = "Commands palette" } },
	{ n___, { "<leader>s", "<C-A-p>" },           function() M.fn.find_symbols() end,              { desc = "Find symbols" } },
	{ __i_, "<C-A-p>",                            function() M.fn.find_symbols() end,              { desc = "Find symbols" } },
	{ n___, { "<leader><tab>", "<A-Tab>" },       function() M.fn.buffers() end,                   { desc = "Buffers" } },
	{ __i_, "<A-Tab>",                            function() M.fn.buffers() end,                   { desc = "Buffers" } },
	{ n___, { "<leader>f", "<C-f>" },             function() M.fn.fuzzy_find() end,                { desc = "Fuzzy find" } },
	{ __i_, "<C-f>",                              function() M.fn.fuzzy_find() end,                { desc = "Fuzzy find" } },
	{ n___, { "<leader>F", "<C-A-F>" },           function() M.fn.live_grep() end,                 { desc = "Live grep" } },
	{ __i_, "<C-A-f>",                            function() M.fn.live_grep() end,                 { desc = "Live grep" } },
	---------------------------------------------------------------------------- UI
	{ n___, "<Leader>ud",                         function() M.fn.toggle_debugger() end,           { desc = "Toggle debugger UI" } },
	{ n___, "<Leader>ul",                         function() M.fn.toggle_list_chars() end,         { desc = "Toggle list chars" } },
	{ n___, "<Leader>uz",                         function() M.fn.toggle_fold_column() end,        { desc = "Toggle folds column" } },
	{ n___, "<Leader>un",                         function() M.fn.toggle_relative_number() end,    { desc = "Toggle relative number column" } },
	{ n___, "<Leader>uN",                         function() M.fn.toggle_line_number() end,        { desc = "Toggle number column" } },
	{ n___, "<Leader>uh",                         function() M.fn.toggle_inlay_hints() end,        { desc = "Toggle lsp inlay hints" } },
	{ n_i_, "<A-9>",                              function() M.fn.symbols_outline_focus() end,     { desc = "Toggle symbols outline" } },
	{ n_i_, { "<A-S-9>", "<A-)>" },               function() M.fn.symbols_outline_float() end,     { desc = "Toggle symbols outline floating navigation" } },
	{ n___, "<leader>S",                          function() M.fn.symbols_outline_float() end,     { desc = "Toggle symbols outline floating navigation" } },
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

-------------------------------------------------------------------------------- TREESITTER
M.plugins.treesitter = {
	init_selection    = false,
	node_incremental  = "<A-v>",
	scope_incremental = false,
	node_decremental  = "<A-V>",
}

-------------------------------------------------------------------------------- TELESCOPE
M.plugins.telescope = {
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
	{ n___, "[h",                function() require("nvim-tree.api").node.navigate.git.prev() end,         { desc = "Prev Git" } },
	{ n___, "]h",                function() require("nvim-tree.api").node.navigate.git.next() end,         { desc = "Next Git" } },
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
