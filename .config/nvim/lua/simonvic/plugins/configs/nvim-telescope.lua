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
		pickers = {
			find_files = {
				hidden = true
			},
			diagnostics = {
				sort_by = "severity"
			},
			buffers = {
				theme = "dropdown"
			}
		}
	})
	local builtin = require("telescope.builtin")
	keybindings.implement({
		find_symbols        = builtin.lsp_dynamic_workspace_symbols,
		fuzzy_find          = builtin.current_buffer_fuzzy_find,
		live_grep           = builtin.live_grep,
		references          = builtin.lsp_references,
		definition          = builtin.lsp_definitions,
		diagnostic_show_all = builtin.diagnostics,
		find_files          = builtin.find_files,
		buffers             = builtin.buffers,
		commands            = builtin.keymaps,
	})
end
