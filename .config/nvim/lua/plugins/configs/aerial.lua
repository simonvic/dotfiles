return function()
	local keybindings = require("keybindings")
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
		keymaps = keybindings.plugins.aerial,
		show_guides = true,
		guides = {
			mid_item = "├ ",
			last_item = "└ ",
			nested_top = "│ ",
			whitespace = "  ",
		},
		nav = {
			keymaps = keybindings.plugins.aerial_nav,
		}
	})
	require("telescope").load_extension("aerial")
end
