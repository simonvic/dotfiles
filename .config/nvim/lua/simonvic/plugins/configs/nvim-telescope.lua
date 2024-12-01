return function()
	local keybindings = require("simonvic.keybindings")
	local actions = require("telescope.actions")
	require("telescope").setup({
		defaults = {
			mappings = {
				i = {
					["<esc>"] = actions.close,
					["<C-h>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<A-CR>"] = actions.send_selected_to_qflist,
					["<C-CR>"] = actions.send_to_qflist,
				}
			}
		},
	})
	local builtin = require("telescope.builtin")
	local themes = require("telescope.themes")
	keybindings.implement({
		find_symbols        = builtin.lsp_dynamic_workspace_symbols,
		fuzzy_find          = builtin.current_buffer_fuzzy_find,
		live_grep           = builtin.live_grep,
		references          = builtin.lsp_references,
		definition          = builtin.lsp_definitions,
		diagnostic_show_all = function() builtin.diagnostics({ sort_by = "severity" }) end,
		find_files          = function() builtin.find_files({ hidden = true }) end,
		buffers             = function() builtin.buffers(themes.get_dropdown({})) end,
		commands            = builtin.keymaps,
	})
end
