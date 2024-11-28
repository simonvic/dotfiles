return function()
	vim.g.neo_tree_remove_legacy_commands = true
	local keybindings = require("simonvic.keybindings")
	local glyphs = require("simonvic.glyphs")
	local diag_signs = require("simonvic.signs").diagnostic
	require("neo-tree").setup({
		close_if_last_window = false,
		source_selector = {
			winbar = true,
			content_layout = "center",
			sources = {
				{ source = "filesystem", display_name = glyphs.plugins.neotree.sources.filesystem, },
				{ source = "buffers",    display_name = glyphs.plugins.neotree.sources.buffers, },
				{ source = "git_status", display_name = glyphs.plugins.neotree.sources.git_status, },
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
				indent_marker = glyphs.fs.indent_markers.edge,
				last_indent_marker = glyphs.fs.indent_markers.corner,
				highlight = "NeoTreeIndentMarker",
				with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = glyphs.fs.dir.collapsed,
				expander_expanded = glyphs.fs.dir.expanded,
				expander_highlight = "NeoTreeExpander",
			},
			icon = {
				folder_closed = glyphs.fs.dir.default,
				folder_open = glyphs.fs.dir.open,
				folder_empty = glyphs.fs.dir.empty_open,
				-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
				-- then these will never be used.
				default = glyphs.fs.default,
				highlight = "NeoTreeFileIcon"
			},
			modified = {
				symbol = glyphs.fs.unsaved,
				highlight = "NeoTreeModified",
			},
			name = {
				trailing_slash = false,
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = {
					added     = glyphs.vcs.added,
					deleted   = glyphs.vcs.removed,
					modified  = glyphs.vcs.modified,
					renamed   = glyphs.vcs.renamed,
					untracked = glyphs.vcs.untracked,
					ignored   = glyphs.vcs.ignored,
					unstaged  = glyphs.vcs.untracked,
					staged    = glyphs.vcs.added,
					conflict  = glyphs.vcs.conflict,
				}
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
			mappings = keybindings.plugins.neotree.base
		},
		filesystem = {
			window = {
				mappings = keybindings.plugins.neotree.filesystem
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
			window = keybindings.plugins.neotree.buffers,
		},
		git_status = {
			group_empty_dirs = true,
			window = {
				position = "float",
				mappings = keybindings.plugins.neotree.gitstatus
			}
		}
	})
	local execute = require("neo-tree.command").execute
	keybindings.implement({
		filetree_focus = function() execute({ action = "focus" }) end,
		filetree_toggle = function() execute({ action = "toggle" }) end,
		filetree_refresh = function() execute({ action = "refresh" }) end,
		filetree_expand_or_descend = function(state)
			local node = state.tree:get_node()
			if node.type == "directory" and not node:is_expanded() then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<cr>', true, false, true), 'm', true)
			else
				vim.api.nvim_feedkeys("j", "n", false)
			end
		end,
		filetree_collapse_or_ascend = function(state)
			local node = state.tree:get_node()
			if node.type == "directory" and node:is_expanded() then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<cr>', true, false, true), 'm', true)
			else
				vim.api.nvim_feedkeys("k", "n", false)
			end
		end
	})
end
