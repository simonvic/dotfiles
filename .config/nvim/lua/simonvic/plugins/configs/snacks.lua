return function()
	local glyphs = require("simonvic.glyphs")
	local snacks = require("snacks")
	snacks.setup({
		styles = {
			notification = {
				title_pos = "left"
			},
			input = {
				relative = "cursor",
				row = 1,
				col = -5,
				title_pos = "left"
			},
		},
		input = {
			enabled = true
		},
		notifier = {
			enabled = true,
		},

		picker = {
			enabled = true,
			ui_select = true,
			matcher = {
				frecency = true
			},
			win = {
				input = {
					keys = require("simonvic.keybindings").plugins.snacks.input.keys
				}
			},
			icons = {
				ui = {
					unselected = glyphs.ui.unselected .. " ",
					selected = glyphs.ui.selected .. " ",
				},
				git = {
					enabled   = true,
					commit    = glyphs.vcs.commit,
					staged    = glyphs.vcs.staged,
					added     = glyphs.vcs.added,
					deleted   = glyphs.vcs.removed,
					ignored   = glyphs.vcs.ignored,
					modified  = glyphs.vcs.modified,
					renamed   = glyphs.vcs.renamed,
					unmerged  = glyphs.vcs.unmerged,
					untracked = glyphs.vcs.untracked,
				},
				diagnostics = {
					Error = glyphs.diagnostics.error .. " ",
					Warn  = glyphs.diagnostics.warn .. " ",
					Hint  = glyphs.diagnostics.hint .. " ",
					Info  = glyphs.diagnostics.info .. " ",
				},
				kinds = glyphs.symbols,
			}
		}
	})
	require("simonvic.keybindings").implement({
		commands_menu       = snacks.picker.pick,
		workspace_symbols   = snacks.picker.lsp_workspace_symbols,
		document_symbols    = snacks.picker.lsp_symbols,
		-- fuzzy_find          = snacks.picker.current_buffer_fuzzy_find,
		live_grep           = snacks.picker.grep,
		references          = snacks.picker.lsp_references,
		implementation      = snacks.picker.lsp_implementations,
		definition          = snacks.picker.lsp_definitions,
		diagnostic_show_all = snacks.picker.diagnostics,
		find_files          = snacks.picker.files,
		buffers             = snacks.picker.buffers,
		commands            = snacks.picker.keymaps,
		zen_mode            = snacks.zen,
	})
end
