return function()
	vim.g.neo_tree_remove_legacy_commands = true
	local renderer = require("neo-tree.ui.renderer")

	local function open_dir(state, dir_node)
		local fs = require("neo-tree.sources.filesystem")
		fs.toggle_directory(state, dir_node, nil, true, false)
	end

	require("neo-tree").setup({
		close_if_last_window = false,
		source_selector = {
			winbar = true,
			content_layout = "center",
			tab_labels = {
				filesystem = "",
				buffers = "﬘",
				git_status = "",
			},
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
					added     = "", -- "",
					modified  = "", --""",
					deleted   = "",
					renamed   = "",
					-- Status type
					untracked = "-",
					ignored   = "",
					unstaged  = "",
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
			mappings = {
				-- window
				["<A-Bslash>"] = "close_window",
				["<F5>"] = "refresh",
				["<?>"] = "show_help",
				["<TAB>"] = "next_source",
				["<S-TAB>"] = "prev_source",
				-- navigation
				["<RIGHT>"] = function(state) -- expand or descend
					local node = state.tree:get_node()
					if node.type == "directory" then
						if node:is_expanded() then
							local children = state.tree:get_nodes(node:get_id())
							renderer.focus_node(state, children[1]:get_id())
						else
							open_dir(state, node)
							renderer.redraw(state)
						end
					else
						vim.api.nvim_feedkeys("j", "n", false)
					end
				end,
				["<LEFT>"] = function(state) -- collapse or ascend
					local node = state.tree:get_node()
					if node.type == "directory" then
						if node:is_expanded() then
							node:collapse()
							renderer.redraw(state)
						else
							vim.api.nvim_feedkeys("k", "n", false)
						end
					else
						vim.api.nvim_feedkeys("k", "n", false)
					end
				end,
				["<C-p>"] = { "toggle_preview", config = { use_float = true } },
				["<2-LeftMouse>"] = "open",
				["<CR>"] = "open",
				-- ["<C-h>"] = "open_split",
				-- ["<C-v>"] = "open_vsplit",
				["<C-h>"] = "split_with_window_picker",
				["<C-v>"] = "vsplit_with_window_picker",
				["<C-t>"] = "open_tabnew",
				["<A-CR>"] = "open_with_window_picker",
				["C"] = "close_node",
				["z"] = "close_all_nodes",
				["Z"] = "expand_all_nodes",
				["a"] = { "add", config = { show_path = "none" } },
				["<DEL>"] = "delete",
				["<F2>"] = "move", -- (rename)
				["<C-r>"] = "move", -- (rename)
				["y"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["c"] = "copy",
			}
		},
		filesystem = {
			window = {
				mappings = {
					["<A-.>"] = "navigate_up",
					["."] = "set_root",
					["H"] = "toggle_hidden",
					["/"] = "fuzzy_finder",
					["D"] = "fuzzy_finder_directory",
					["f"] = "filter_on_submit",
					["<ESC>"] = "clear_filter",
					["[g"] = "prev_git_modified",
					["]g"] = "next_git_modified",
				}
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
			follow_current_file = true,
			group_empty_dirs = true,
			hijack_netrw_behavior = "open_default",
			use_libuv_file_watcher = false,
		},
		buffers = {
			follow_current_file = true, -- This will find and focus the file in the active buffer every
			-- ti{me the current file is changed while the tree is open.
			group_empty_dirs = true, -- when true, empty folders will be grouped together
			show_unloaded = true,
			window = {
				mappings = {
					["bd"] = "buffer_delete",
					["<bs>"] = "navigate_up",
					["."] = "set_root",
				}
			},
		},
		git_status = {
			window = {
				position = "float",
				mappings = {
					["A"]  = "git_add_all",
					["gu"] = "git_unstage_file",
					["ga"] = "git_add_file",
					["gr"] = "git_revert_file",
					["gc"] = "git_commit",
					["gp"] = "git_push",
					["gg"] = "git_commit_and_push",
				}
			}
		}
	})
end
