return function()
	vim.g.neo_tree_remove_legacy_commands = true
	local keybindings = require("simonvic.keybindings")

	require("neo-tree").setup({
		close_if_last_window = false,
		source_selector = {
			winbar = true,
			content_layout = "center",
			sources = {
				{ source = "filesystem", display_name = "󰉓", },
				{ source = "buffers", display_name = "󰈢", },
				{ source = "git_status", display_name = "󰊢", },
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
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "",
				-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
				-- then these will never be used.
				default = "",
				highlight = "NeoTreeFileIcon"
			},
			modified = {
				symbol = "+",
				highlight = "NeoTreeModified",
			},
			name = {
				trailing_slash = false,
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = {
					-- Change type
					added     = "",
					modified  = "",
					deleted   = "",
					renamed   = "",
					-- Status type
					untracked = "",
					ignored   = "",
					unstaged  = "", -- "",
					staged    = "",
					conflict  = "",
				}
			},
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
			window = {
				position = "float",
				mappings = keybindings.plugins.neotree_gitstatus
			}
		}
	})
end
