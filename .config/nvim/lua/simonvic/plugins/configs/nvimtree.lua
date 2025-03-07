return function()
	local glyphs = require("simonvic.glyphs")
	require("nvim-tree").setup({
		on_attach = function(bufnr)
			local keybindings = require("simonvic.keybindings")
			keybindings.set_with_opts(
				{ buffer = bufnr, noremap = true, silent = true, nowait = true },
				keybindings.plugins.nvimtree)
		end,
		update_focused_file = {
			enable = true,
		},
		sync_root_with_cwd = true,
		select_prompts = false,
		git = {
			enable = true,
			show_on_dirs = true,
			show_on_open_dirs = false,
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
			show_on_open_dirs = false,
			icons = {
				hint    = glyphs.diagnostics.hint,
				info    = glyphs.diagnostics.info,
				warning = glyphs.diagnostics.warning,
				error   = glyphs.diagnostics.error,
			}
		},
		modified = {
			enable = true,
			show_on_dirs = true,
			show_on_open_dirs = false,
		},
		view = {
			width = {
				max = 30,
				padding = 1,
			},
			signcolumn = "auto",
			float = {
				enable = false, -- TODO: might be handy
			},
		},
		actions = {
			open_file = {
				window_picker = {
					enable = true,
					exclude = {
						filetype = {
							"notify",
							"lazy",
							"qf",
							"diff",
							"aerial",
							"dap-repl",
							"dapui_breakpoints",
							"dapui_console",
							"dapui_stacks",
							"dapui_scopes",
							"dapui_watches",
						},
						buftype = {
							"nofile",
							"terminal",
						},
					},
				}
			},
			file_popup = {
				open_win_config = {
					border = "rounded"
				}
			}
		},
		renderer = {
			full_name = true,
			root_folder_label = function(path)
				return vim.fn.fnamemodify(path, ":t")
					.. " [" .. vim.fn.fnamemodify(path, ":~:.:h") .. "]"
			end,
			hidden_display = "all",
			group_empty = true,
			symlink_destination = true,
			indent_width = 2,
			indent_markers = {
				inline_arrows = true,
				enable = true,
				icons = {
					item = glyphs.fs.indent_markers.edge,
					edge = glyphs.fs.indent_markers.edge,
					bottom = glyphs.fs.indent_markers.bottom,
					corner = glyphs.fs.indent_markers.bottom,
					none = " ",
				}
			},
			highlight_git = "name",
			highlight_diagnostics = "name",
			highlight_opened_files = "none",
			highlight_modified = "name",
			highlight_hidden = "name",
			icons = {
				git_placement = "right_align",
				diagnostics_placement = "right_align",
				modified_placement = "after",
				symlink_arrow = " " .. glyphs.fs.symlink_arrow .. " ",
				show = {
					folder_arrow = false,
					file = true,
					git = true,
					modified = true,
					hidden = false,
					diagnostics = true,
					bookmarks = true,
				},
				glyphs = {
					modified = glyphs.fs.unsaved,
					git = {
						ignored   = glyphs.vcs.ignored,
						staged    = glyphs.vcs.added,
						unstaged  = glyphs.vcs.modified,
						deleted   = glyphs.vcs.removed,
						renamed   = glyphs.vcs.renamed,
						unmerged  = glyphs.vcs.unmerged,
						untracked = glyphs.vcs.untracked,
					}
				}
			}
		},
	})
	local api = require("nvim-tree.api")
	require("simonvic.keybindings").implement({
		filetree_focus = api.tree.focus,
		filetree_toggle = api.tree.toggle,
		filetree_expand_or_descend = function()
			local node = api.tree.get_node_under_cursor()
			if not node then return end
			if node.type == "directory" and not node.open then
				node:expand_or_collapse() -- expand only
			else
				vim.api.nvim_feedkeys("j", "n", false)
			end
		end,
		filetree_collapse_or_ascend = function()
			local node = api.tree.get_node_under_cursor()
			if not node then return end
			if node.type == "directory" and node.open then
				node:expand_or_collapse() -- collapse only
			else
				vim.api.nvim_feedkeys("k", "n", false)
			end
		end,
		filetree_vcs_change_prev = api.node.navigate.git.prev,
		-- filetree_vcs_change_next = api.node.navigate.git.next,
		filetree_vcs_change_next = function() -- directly navigate to file
			api.node.navigate.git.next()
			local node = api.tree.get_node_under_cursor()
			while node.type == "directory" and not node.open do
				if not node then break end
				node:expand_or_collapse() -- expand only
				api.node.navigate.git.next()
				node = api.tree.get_node_under_cursor()
			end
		end
	})
	vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, {
		pattern = "*",
		callback = function()
			if vim.bo.filetype == "NvimTree" then
				vim.wo.winbar = vim.fn.fnamemodify(vim.uv.cwd(), ":~:h") .. "/"
			end
		end,
	})
end
