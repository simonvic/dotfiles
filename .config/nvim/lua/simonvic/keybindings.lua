M = {}
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

local function cmd(command) return "<Cmd>" .. command .. "<CR>" end
local function cmd_esc(command) return "<Cmd>" .. command .. "<CR><ESC>" end

local terminal = "<A-ò>"; -- just because accented chars mess up the formatter
local terminal_float = "<A-ç>";
local backward = "è";
local forward = "+";

local function breakpoing_log()
	vim.ui.input({ prompt = "Log point message" }, function(input)
		require("dap").set_breakpoint(nil, nil, input)
	end)
end

local function breakpoint_condition()
	vim.ui.input({ prompt = "Breakpoint condition" }, function(input)
		require("dap").set_breakpoint(input)
	end)
end

local function breapoint_condition_log()
	vim.ui.input({ prompt = "Breakpoint condition" }, function(condition)
		vim.ui.input({ prompt = "Log point message" }, function(message)
			require("dap").set_breakpoint(condition, nil, message)
		end)
	end)
end

local function expand_or_descend_filetree(state)
	local node = state.tree:get_node()
	if node.type == "directory" then
		if node:is_expanded() then
			vim.api.nvim_feedkeys("j", "n", false)
		else
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<cr>', true, false, true), 'm', true)
		end
	else
		vim.api.nvim_feedkeys("j", "n", false)
	end
end

local function collapse_or_ascend_filetree(state)
	local node = state.tree:get_node()
	if node.type == "directory" then
		if node:is_expanded() then
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<cr>', true, false, true), 'm', true)
		else
			vim.api.nvim_feedkeys("k", "n", false)
		end
	else
		vim.api.nvim_feedkeys("k", "n", false)
	end
end

local function inspect_variable() require("dapui").eval() end -- require("dap.ui.widgets").hover()
local function code_actions() lsp.code_action() end
local function goto_definition() lsp.definition() end
local function rename() lsp.rename() end
local function open_docs() lsp.hover(); end
local function signature_help() lsp.signature_help(); end
local function show_diagnostics() vim.diagnostic.open_float() end
local function format() lsp.format() end
local function toggle_dapUI() require("dapui").toggle() end
local function toggle_list_chars() vim.opt.list = not vim.opt.list:get() end
local function toggle_fold_column() vim.opt.foldcolumn = vim.opt.foldcolumn:get() == "0" and "auto:9" or "0" end
local function toggle_relative_number() vim.opt.relativenumber = not vim.opt.relativenumber:get() end
local function find_references() require("telescope.builtin").lsp_references() end
local function find_files() require("telescope.builtin").find_files({ hidden = true }) end
local function find_symbols() require("telescope.builtin").lsp_dynamic_workspace_symbols() end
local function fuzzy_find() require("telescope.builtin").current_buffer_fuzzy_find() end
local function live_grep() require("telescope.builtin").live_grep() end
local function buffers() require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({})) end
local function dap_run_last() require("dap").run_last() end
local function jdtls_organize_imports() require("jdtls").organize_imports() end
local function jdtls_pick_tests() require("jdtls").pick_test() end
local function jdtls_test_class() require("jdtls").test_class() end
local function jdtls_test_method() require("jdtls").test_nearest_method() end
local function jdtls_setup_debug_config() require("jdtls.dap").setup_dap_main_class_configs() end
local function jdtls_super_implementation() require("jdtls").super_implementation() end

local keybindings = {
	leader = " ",
	localleader = " ",
	-- { modes, lhs,              rhs,                                  options },
	---------------------------------------------------------------------------- ITALIAN KEYBOARD LAYOUT
	{ n___, "-",                "/",                                    { desc = "Search forward" } },
	{ n___, "_",                "?",                                    { desc = "Search backward" } },
	{ n___, backward,           "[",                                    { desc = "Backward [ alias", remap = true } },
	{ n___, forward,            "]",                                    { desc = "Forward ] alias", remap = true } },
	--------------------------------------------------------------------------- ACTIONS
	{ nvi_, "<C-s>",            cmd("write"),                           { desc = "Save", silent = true } },
	{ nvi_, "<C-z>",            cmd("undo"),                            { desc = "Undo", silent = true } },
	{ nvi_, "<C-y>",            cmd("redo"),                            { desc = "Redo", silent = true } },
	{ n_i_, "<A-CR>",           code_actions,                           { desc = "Code actions" } },
	{ n_i_, "<C-b>",            goto_definition,                        { desc = "Go to definition" } },
	{ n___, "gd",               goto_definition,                        { desc = "Go to definition" } },
	{ n_i_, "<A-r>",            find_references,                        { desc = "Find references" } },
	{ n___, "gr",               find_references,                        { desc = "Find references" } },
	{ n_i_, "<F2>",             rename,                                 { desc = "Rename" } },
	{ n_i_, "<C-r>",            rename,                                 { desc = "Rename" } },
	{ n___, "<leader>r",        rename,                                 { desc = "Rename" } },
	{ n_i_, "<F1>",             open_docs,                              { desc = "Open docs" } },
	{ n_i_, "<C-q>",            open_docs,                              { desc = "Open docs" } },
	{ n___, "<leader>q",        open_docs,                              { desc = "Open docs" } },
	{ __i_, "<A-q>",            signature_help,                         { desc = "Signature help" } },
	{ n_i_, "<C-e>",            show_diagnostics,                       { desc = "Show diagnostics" } },
	{ n___, "<leader>e",        show_diagnostics,                       { desc = "Show diagnostics" } },
	{ n___, "<leader>E",        cmd("Telescope diagnostics"),           { desc = "Show telescope diagnostics" } },
	--------------------------------------------------------------------------- MOVEMENT
	{ nv__, "<C-LEFT>",         "b",                                    { desc = "Previous end" } },
	{ __i_, "<C-LEFT>",         "<C-o>b",                               { desc = "Previous end" } },
	{ nv__, "<C-RIGHT>",        "e",                                    { desc = "Next word" } },
	{ __i_, "<C-RIGHT>",        "<C-o>e<RIGHT>",                        { desc = "Next word" } },
	{ nv__, "<HOME>",           "^",                                    { desc = "First character" } },
	{ __i_, "<HOME>",           "<C-o>^",                               { desc = "First character" } },
	{ nv__, "<A-HOME>",         "0",                                    { desc = "Start of line" } },
	{ __i_, "<A-HOME>",         "<C-o>0",                               { desc = "Start of line" } },
	{ nv__, "<END>",            "g_",                                   { desc = "Last character" } },
	{ nv__, "<A-END>",          "$",                                    { desc = "Last character" } },
	{ __i_, "<A-END>",          "<C-o>$",                               { desc = "End of line" } },
	{ n___, "<leader>nh",       cmd("Gitsigns next_hunk"),              { desc = "Go next hunk" } },
	{ n___, "]h",               cmd("Gitsigns next_hunk"),              { desc = "Go next hunk" } },
	{ n___, "<leader>Nh",       cmd("Gitsigns prev_hunk"),              { desc = "Go prev hunk" } },
	{ n___, "[h",               cmd("Gitsigns prev_hunk"),              { desc = "Go prev hunk" } },
	{ n___, "<leader>nd",       vim.diagnostic.goto_next,               { desc = "Go next diagnostic" } },
	{ n___, "]d",               vim.diagnostic.goto_next,               { desc = "Go next diagnostic" } },
	{ n___, "<leader>Nd",       vim.diagnostic.goto_prev,               { desc = "Go prev diagnostic" } },
	{ n___, "[d",               vim.diagnostic.goto_prev,               { desc = "Go prev diagnostic" } },
	---------------------------------------------------------------------------- SELECTION
	{ n___, "<S-LEFT>",         "v<LEFT>",                              { desc = "Select left" } },
	{ _v__, "<S-LEFT>",         "<LEFT>",                               { desc = "Select left" } },
	{ __i_, "<S-LEFT>",         "<LEFT><C-o>v",                         { desc = "Select left" } },
	{ n___, "<S-RIGHT>",        "v<RIGHT>",                             { desc = "Select right" } },
	{ _v__, "<S-RIGHT>",        "<RIGHT>",                              { desc = "Select right" } },
	{ __i_, "<S-RIGHT>",        "<C-o>v",                               { desc = "Select right" } },
	{ n___, "<S-UP>",           "v<UP>",                                { desc = "Select up" } },
	{ _v__, "<S-UP>",           "<UP>",                                 { desc = "Select up" } },
	{ __i_, "<S-UP>",           "<LEFT><C-o>v<UP><RIGHT>",              { desc = "Select up" } },
	{ n___, "<S-DOWN>",         "v<DOWN>",                              { desc = "Select down" } },
	{ _v__, "<S-DOWN>",         "<DOWN>",                               { desc = "Select down" } },
	{ __i_, "<S-DOWN>",         "<C-o>v<DOWN><LEFT>",                   { desc = "Select down" } },
	{ n___, "<S-C-LEFT>",       "vb",                                   { desc = "Select word left" } },
	{ _v__, "<S-C-LEFT>",       "b",                                    { desc = "Select word left" } },
	{ __i_, "<S-C-LEFT>",       "<LEFT><C-o>vb",                        { desc = "Select word left" } },
	{ n___, "<S-C-RIGHT>",      "ve",                                   { desc = "Select word right" } },
	{ _v__, "<S-C-RIGHT>",      "e",                                    { desc = "Select word right" } },
	{ __i_, "<S-C-RIGHT>",      "<C-o>ve",                              { desc = "Select word right" } },
	{ n___, "<S-HOME>",         "v^",                                   { desc = "Select to first character" } },
	{ _v__, "<S-HOME>",         "^",                                    { desc = "Select to first character" } },
	{ __i_, "<S-HOME>",         "<LEFT><C-o>v^",                        { desc = "Select to first character" } },
	{ n___, "<S-A-HOME>",       "v0",                                   { desc = "Select to start of line" } },
	{ _v__, "<S-A-HOME>",       "0",                                    { desc = "Select to start of line" } },
	{ __i_, "<S-A-HOME>",       "<LEFT><C-o>v0",                        { desc = "Select to start of line" } },
	{ n___, "<S-END>",          "vg_",                                  { desc = "Select to last character" } },
	{ _v__, "<S-END>",          "g_",                                   { desc = "Select to last character" } },
	{ __i_, "<S-END>",          "<C-o>vg_",                             { desc = "Select to last character" } },
	{ n___, "<S-A-END>",        "v$",                                   { desc = "Select to end of line" } },
	{ _v__, "<S-A-END>",        "$",                                    { desc = "Select to end of line" } },
	{ __i_, "<S-A-END>",        "<C-o>v$",                              { desc = "Select to end of line" } },
	{ n___, "<S-C-HOME>",       "vgg0",                                 { desc = "Select to start of file" } },
	{ _v__, "<S-C-HOME>",       "gg0",                                  { desc = "Select to start of file" } },
	{ __i_, "<S-C-HOME>",       "<LEFT><C-o>vgg0",                      { desc = "Select to start of file" } },
	{ n___, "<S-C-END>",        "vG$",                                  { desc = "Select to end of file" } },
	{ _v__, "<S-C-END>",        "G$",                                   { desc = "Select to end of file" } },
	{ __i_, "<S-C-END>",        "<C-o>vG$",                             { desc = "Select to end of file" } },
	---------------------------------------------------------------------------- EDITING
	{ n_i_, "<C-A-DOWN>",       cmd("move +1"),                         { desc = "Move line down", silent = true } },
	{ n___, "<leader>JJ",       cmd("move +1"),                         { desc = "Move line down", silent = true } },
	{ _v__, "<C-A-DOWN>",       ":move '>+1<CR>gv",                     { desc = "Move line down", silent = true } },
	{ _v__, "<leader>JJ",       ":move '>+1<CR>gv",                     { desc = "Move line down", silent = true } },
	{ n_i_, "<C-A-UP>",         cmd("move -2"),                         { desc = "Move line up", silent = true } },
	{ n___, "<leader>KK",       cmd("move -2"),                         { desc = "Move line up", silent = true } },
	{ _v__, "<C-A-UP>",         ":move '<-2<CR>gv",                     { desc = "Move line up", silent = true } },
	{ _v__, "<leader>KK",       ":move '<-2<CR>gv",                     { desc = "Move line up", silent = true } },
	{ n_i_, "<C-S-DOWN>",       cmd("copy +0"),                         { desc = "Copy line down", silent = true } },
	{ n___, "<leader>jj",       cmd("copy +0"),                         { desc = "Copy line down", silent = true } },
	{ _v__, "<C-S-DOWN>",       ":copy '<-1<CR>gv",                     { desc = "Copy line down", silent = true } },
	{ _v__, "<leader>jj",       ":copy '<-1<CR>gv",                     { desc = "Copy line down", silent = true } },
	{ n_i_, "<C-S-UP>",         cmd("copy -1"),                         { desc = "Copy line up", silent = true } },
	{ n___, "<C-S-UP>",         cmd("copy -1"),                         { desc = "Copy line up", silent = true } },
	{ n___, "<leader>kk",       cmd("copy -1"),                         { desc = "Copy line up", silent = true } },
	{ _v__, "<C-S-UP>",         ":copy '>+0<CR>gv",                     { desc = "Copy line up", silent = true } },
	{ n___, "<C-A-l>",          "magg=G`a",                             { desc = "Reindent file" } },
	{ __i_, "<C-A-l>",          "<ESC>magg=G`aa",                       { desc = "Reindent file" } },
	{ _v__, "<C-A-l>",          "<ESC>ma'<='>`a",                       { desc = "Reindent selection" } },
	{ n_i_, "<A-L>",            format,                                 { desc = "Reformat" } },
	{ n___, "<leader>ll",       format,                                 { desc = "Reformat" } },
	{ n_i_, "<C-A-c>",          cmd("CommentToggle"),                   { desc = "Comment toggle" } },
	{ n___, "<leader>cc",       cmd("CommentToggle"),                   { desc = "Comment toggle" } },
	{ _v__, "<C-A-c>",          ":CommentToggle<CR>",                   { desc = "Comment toggle" } },
	{ _v__, "<leader>cc",       ":CommentToggle<CR>",                   { desc = "Comment toggle" } },
	{ _v__, "<TAB>",            ">gv",                                  { desc = "Increase indent" } },
	{ _v__, "<S-TAB>",          "<gv",                                  { desc = "Decrease indent" } },
	{ _v__, ">",                ">gv",                                  { desc = "Decrease indent" } },
	{ _v__, "<",                "<gv",                                  { desc = "Decrease indent" } },
	{ n_i_, "<A-->",            cmd("foldclose"),                       { desc = "Fold close" } },
	{ n_i_, "<A-+>",            cmd("foldopen"),                        { desc = "Fold open" } },
	---------------------------------------------------------------------------- WINDOWS
	{ n_it, "<A-LEFT>",         cmd("wincmd h"),                        { desc = "Focus window left" } },
	{ n_it, "<A-DOWN>",         cmd("wincmd j"),                        { desc = "Focus window down" } },
	{ n_it, "<A-UP>",           cmd("wincmd k"),                        { desc = "Focus window up" } },
	{ n_it, "<A-RIGHT>",        cmd("wincmd l"),                        { desc = "Focus window right" } },
	{ n_i_, "<A-S-LEFT>",       cmd("wincmd H"),                        { desc = "Move window left" } },
	{ n_i_, "<A-S-DOWN>",       cmd("wincmd J"),                        { desc = "Move window down" } },
	{ n_i_, "<A-S-UP>",         cmd("wincmd K"),                        { desc = "Move window up" } },
	{ n_i_, "<A-S-RIGHT>",      cmd("wincmd L"),                        { desc = "Move window right" } },
	{ n_i_, "<A-PageUp>",       cmd("bnext"),                           { desc = "Next buffer" } },
	{ n_i_, "<A-PageDown>",     cmd("bprevious"),                       { desc = "Previous buffer" } },
	{ n_i_, "<C-t>",            cmd("tabnew"),                          { desc = "New tab" } },
	{ n_i_, "<F28>",            cmd("tabclose"),                        { desc = "Close tab [Ctrl + F4]" } },
	{ n_i_, "<F40>",            cmd("tabdo close"),                     { desc = "Close all tabs [Ctrl + Shift + F4]" } },
	{ n_i_, "<C-PageUp>",       cmd("tabprevious"),                     { desc = "Previous tab" } },
	{ n_i_, "<C-PageDown>",     cmd("tabnext"),                         { desc = "Next tab" } },
	{ n_i_, "<C-S-PageUp>",     cmd("-tabmove"),                        { desc = "Move tab to left" } },
	{ n_i_, "<C-S-PageDown>",   cmd("+tabmove"),                        { desc = "Move tab to right" } },
	{ n__t, "<A-\\>",           cmd("Neotree focus"),                   { desc = "Focus filetree" } },
	{ __i_, "<A-\\>",           cmd_esc("Neotree focus"),               { desc = "Focus filetree" } },
	{ n__t, terminal,           cmd("ToggleTerm direction=horizontal"), { desc = "Toggle dropdown terminal" } },
	{ n__t, terminal_float,     cmd("ToggleTerm direction=float"),      { desc = "Toggle floating terminal" } },
	{ ___t, "<Esc>",            "<C-\\><C-n>",                          { desc = "Exit terminal mode" } },
	{ n_i_, "<C-p>",            find_files,                             { desc = "Find files" } },
	{ n___, "<leader><leader>", find_files,                             { desc = "Find files" } },
	{ n___, "<A-p>",            cmd("Telescope"),                       { desc = "Telescope" } },
	{ n_i_, "<C-A-p>",          find_symbols,                           { desc = "Find symbols" } },
	{ n___, "<leader>s",        find_symbols,                           { desc = "Find symbols" } },
	{ n_i_, "<A-Tab>",          buffers,                                { desc = "Buffers" } },
	{ n___, "<leader><tab>",    buffers,                                { desc = "Buffers" } },
	{ n_i_, "<C-f>",            fuzzy_find,                             { desc = "Fuzzy find" } },
	{ n___, "<leader>f",        fuzzy_find,                             { desc = "Fuzzy find" } },
	{ n_i_, "<C-A-f>",          live_grep,                              { desc = "Live grep" } },
	{ n___, "<leader>F",        live_grep,                              { desc = "Live grep" } },
	---------------------------------------------------------------------------- UI
	{ n___, "<Leader>ud",       toggle_dapUI,                           { desc = "Toggle DapUI" } },
	{ n___, "<Leader>ul",       toggle_list_chars,                      { desc = "Toggle list chars" } },
	{ n___, "<Leader>uz",       toggle_fold_column,                     { desc = "Toggle folds column" } },
	{ n___, "<Leader>un",       toggle_relative_number,                 { desc = "Toggle number column" } },
	{ nvi_, "<A-9>",            cmd("AerialToggle"),                    { desc = "Toggle symbols outline" } },
	{ nvi_, "<A-)>",            cmd("AerialNavToggle"),                 { desc = "Toggle symbols outline floating navigation" } },
	{ n___, "<leader>S",        cmd("AerialNavToggle"),                 { desc = "Toggle symbols outline floating navigation" } },
	---------------------------------------------------------------------------- DEBUGGING
	{ n___, "<F7>",             cmd("DapContinue"),                     { desc = "DAP Continue [F7]" } },
	{ n___, "<F55>",            cmd("DapTerminate"),                    { desc = "DAP Terminate [Alt + F7]" } },
	{ n___, "<F19>",            dap_run_last,                           { desc = "DAP Run last [Shift + F7]" } },
	{ n___, "<F8>",             cmd("DapStepOver"),                     { desc = "DAP Step over [F8]" } },
	{ n___, "<F32>",            cmd("DapStepInto"),                     { desc = "DAP Step into [Ctrl + F8]" } },
	{ n___, "<F20>",            cmd("DapStepOut"),                      { desc = "DAP Step out [Shift + F8]" } },
	{ n___, "<F9>",             cmd("DapToggleBreakpoint"),             { desc = "DAP Breakpoint [F9]" } },
	{ n___, "<F33>",            breakpoint_condition,                   { desc = "DAP Conditional breakpoint [Ctrl + F9]" } },
	{ n___, "<F57>",            breakpoing_log,                         { desc = "DAP Log breakpoint [Alt + F9]" } },
	{ n___, "<F21>",            breapoint_condition_log,                { desc = "DAP Conditional log breakpoint [Shift + F9]" } },
	{ n___, "<A-q>",            inspect_variable,                       { desc = "DAP Inspect variable" } },
	---------------------------------------------------------------------------- PLUGINS
	plugins = {
		------------------------------------------------------------------------ TREESITTER
		treesitter         = {
			init_selection = false,
			node_incremental = "<A-v>",
			scope_incremental = false,
			node_decremental = "<A-V>",
		},
		------------------------------------------------------------------------ NEO-TREE
		neotree            = {
			-- window
			["<A-Bslash>"]    = "close_window",
			["<F5>"]          = "refresh",
			["<?>"]           = "show_help",
			["<TAB>"]         = "next_source",
			["<S-TAB>"]       = "prev_source",
			-- navigation
			["l"]             = expand_or_descend_filetree,
			["<RIGHT>"]       = expand_or_descend_filetree,
			["h"]             = collapse_or_ascend_filetree,
			["<LEFT>"]        = collapse_or_ascend_filetree,
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
		neotree_filesystem = {
			["<A-.>"] = "navigate_up",
			["."]     = "set_root",
			["H"]     = "toggle_hidden",
			["/"]     = "fuzzy_finder",
			["D"]     = "fuzzy_finder_directory",
			["f"]     = "filter_on_submit",
			["<ESC>"] = "clear_filter",
			["[g"]    = "prev_git_modified",
			["]g"]    = "next_git_modified",
		},
		neotree_buffers    = {
			["bd"]   = "buffer_delete",
			["<bs>"] = "navigate_up",
			["."]    = "set_root",
		},
		neotree_gitstatus  = {
			["A"]  = "git_add_all",
			["gu"] = "git_unstage_file",
			["ga"] = "git_add_file",
			["gr"] = "git_revert_file",
			["gc"] = "git_commit",
			["gp"] = "git_push",
			["gg"] = "git_commit_and_push",
		},
		------------------------------------------------------------------------ NVIM-JDTLS
		jdtls              = {
			{ n_i_, "<A-i>",   jdtls_organize_imports,     { desc = "Organize imports" } },
			{ n_i_, "<F6>",    jdtls_pick_tests,           { desc = "Pick test [F6]" } },
			{ n_i_, "<F18>",   jdtls_test_class,           { desc = "Test class [Shift + F6]" } },
			{ n_i_, "<F30>",   jdtls_test_method,          { desc = "Test method [Ctrl + F6]" } },
			{ n_i_, "<F43>",   jdtls_setup_debug_config,   { desc = "Setup debug launch config [Ctrl + Shift + F7]" } },
			{ n_i_, "<F31>",   cmd("JdtUpdateHotcode"),    { desc = "Hotcode replace [Ctrl + F7]" } },
			{ n_i_, "<C-A-b>", jdtls_super_implementation, { desc = "Go to super implementation" } },
		},
		------------------------------------------------------------------------ DAPUI
		dapui              = {
			edit = "e",
			expand = "<CR>",
			open = { "o", "p" },
			remove = { "d", "<DEL>" },
			repl = "r",
			toggle = "t"
		},
		------------------------------------------------------------------------ ALIGN
		align              = {
			start = " a",
			start_with_preview = " A",
		},
		------------------------------------------------------------------------ AERIAL
		aerial             = {
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
		aerial_nav         = {
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
}



M = keybindings

M.set = function(bindings)
	for _, keybind in ipairs(bindings) do
		vim.keymap.set(keybind[1], keybind[2], keybind[3], keybind[4] or {})
	end
end

M.apply = function()
	vim.g.mapleader = keybindings.leader
	vim.g.maplocalleader = keybindings.localleader
	M.set(keybindings)
end

return M
