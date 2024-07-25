return function()
	vim.g.neo_tree_remove_legacy_commands = true
	local keybindings = require("simonvic.keybindings")
	local signs = require("simonvic.signs").plugins.neotree
	local diag_signs = require("simonvic.signs").diagnostic
	require("neo-tree").setup({
		close_if_last_window = false,
		source_selector = {
			winbar = true,
			content_layout = "center",
			sources = {
				{ source = "filesystem", display_name = signs.sources.filesystem, },
				{ source = "buffers",    display_name = signs.sources.buffers, },
				{ source = "git_status", display_name = signs.sources.git_status, },
			},
			separator = { left = "", right = "" },
			separator_active = nil,
		},
		enable_git_status = true,
		enable_diagnostics = true,
		default_component_configs = {
			container = {
				enable_character_fade = true
			},
			indent = {
				indent_size = 2,
				padding = 1,
				with_markers = true,
				indent_marker = signs.indent_marker,
				last_indent_marker = signs.last_indent_marker,
				highlight = "NeoTreeIndentMarker",
				with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = signs.expander_collapsed,
				expander_expanded = signs.expander_expanded,
				expander_highlight = "NeoTreeExpander",
			},
			icon = {
				folder_closed = signs.icon.folder_closed,
				folder_open = signs.icon.folder_open,
				folder_empty = signs.icon.folder_empty,
				-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
				-- then these will never be used.
				default = signs.icon.default,
				highlight = "NeoTreeFileIcon"
			},
			modified = {
				symbol = signs.modified,
				highlight = "NeoTreeModified",
			},
			name = {
				trailing_slash = false,
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = signs.git_status
			},
			diagnostics = {
				symbols = {
					error = diag_signs.DiagnosticSignError.text,
					warn  = diag_signs.DiagnosticSignWarn.text,
					info  = diag_signs.DiagnosticSignInfo.text,
					hint  = diag_signs.DiagnosticSignHint.text,
				},
				highlights = {
					error = diag_signs.DiagnosticSignError.texthl,
					warn  = diag_signs.DiagnosticSignWarn.texthl,
					info  = diag_signs.DiagnosticSignInfo.texthl,
					hint  = diag_signs.DiagnosticSignHint.texthl,
				},
			}
		},
		nesting_rules = {},
		window = {
			position = "left",
			width = 40,
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = keybindings.plugins.neotree
		},
		filesystem = {
			window = {
				mappings = keybindings.plugins.neotree_filesystem
			},
			filtered_items = {
				visible = false, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = true,
				hide_gitignored = false,
				hide_hidden = true, -- only works on Windows for hidden files/directories
				hide_by_name = {},
				hide_by_pattern = {},
				always_show = {},
				never_show = {},
				never_show_by_pattern = {},
			},
			follow_current_file = {
				enabled = true
			},
			group_empty_dirs = true,
			hijack_netrw_behavior = "open_default",
			use_libuv_file_watcher = true,
		},
		buffers = {
			follow_current_file = {
				enabled = true
			},
			group_empty_dirs = true,
			show_unloaded = true,
			window = keybindings.plugins.neotree_buffers,
		},
		git_status = {
			group_empty_dirs = true,
			window = {
				position = "float",
				mappings = keybindings.plugins.neotree_gitstatus
			}
		}
	})
end
