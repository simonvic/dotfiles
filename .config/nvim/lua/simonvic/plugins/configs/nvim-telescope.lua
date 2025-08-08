return function()
	local glyphs = require("simonvic.glyphs")
	local keybindings = require("simonvic.keybindings")
	local actions = require("telescope.actions")
	require("telescope").setup({
		defaults = {
			dynamic_preview_title = true,
			selection_caret = glyphs.ui.caret .. " ",
			multi_icon = glyphs.ui.selected .. " ",
			sorting_strategy = "ascending",
			path_display = {
				"filename_first"
			},
			layout_config = {
				prompt_position = "top",
			},
			-- TODO: move to keybindings
			mappings = {
				i = {
					["<esc>"] = actions.close,
					["<C-h>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-q>"] = actions.smart_send_to_qflist,
					-- TODO: send to loclist?
					-- ["<A-CR>"] = actions.send_selected_to_qflist,
					-- ["<C-CR>"] = actions.send_to_qflist,
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
		commands_menu       = function() vim.cmd("Telescope") end,
		workspace_symbols   = builtin.lsp_dynamic_workspace_symbols,
		document_symbols    = builtin.lsp_document_symbols,
		fuzzy_find          = builtin.current_buffer_fuzzy_find,
		live_grep           = builtin.live_grep,
		references          = builtin.lsp_references,
		implementation      = builtin.lsp_implementations,
		definition          = builtin.lsp_definitions,
		diagnostic_show_all = builtin.diagnostics,
		find_files          = builtin.find_files,
		buffers             = builtin.buffers,
		commands            = builtin.keymaps,
	})
end
