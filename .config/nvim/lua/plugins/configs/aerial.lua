return function()
	require("aerial").setup({
		layout = {
			max_width = { 40, 0.2 },
			width = 20,
			min_width = 10,
			win_opts = {
				winbar = " "
			},
			default_direction = "right",
			placement = "window",
		},
		backends = { "lsp", "treesitter", "markdown" },
		attach_mode = "global",
		close_automatic_events = {},
		keymaps = {
			["?"] = "actions.show_help",
			["g?"] = false,
			["<CR>"] = "actions.jump",
			["<2-LeftMouse>"] = "actions.jump",
			["<C-v>"] = "actions.jump_vsplit",
			["<C-h>"] = "actions.jump_split",
			["p"] = "actions.scroll",
			["<C-j>"] = "actions.down_and_scroll",
			["<C-k>"] = "actions.up_and_scroll",
			["{"] = "actions.prev",
			["}"] = "actions.next",
			["[["] = "actions.prev_up",
			["]]"] = "actions.next_up",
			["q"] = "actions.close",
			["o"] = "actions.tree_toggle",
			["za"] = "actions.tree_toggle",
			["O"] = "actions.tree_toggle_recursive",
			["zA"] = "actions.tree_toggle_recursive",
			["l"] = "actions.tree_open",
			["zo"] = "actions.tree_open",
			["L"] = "actions.tree_open_recursive",
			["zO"] = "actions.tree_open_recursive",
			["h"] = "actions.tree_close",
			["zc"] = "actions.tree_close",
			["H"] = "actions.tree_close_recursive",
			["zC"] = "actions.tree_close_recursive",
			["zr"] = "actions.tree_increase_fold_level",
			["zR"] = "actions.tree_open_all",
			["zm"] = "actions.tree_decrease_fold_level",
			["zM"] = "actions.tree_close_all",
			["zx"] = "actions.tree_sync_folds",
			["zX"] = "actions.tree_sync_folds",
		},
		show_guides = true,
		guides = {
			mid_item = "├ ",
			last_item = "└ ",
			nested_top = "│ ",
			whitespace = "  ",
		}
	})
	require("telescope").load_extension("aerial")
end
