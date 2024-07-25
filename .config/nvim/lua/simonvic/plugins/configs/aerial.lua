return function()
	local keybindings = require("simonvic.keybindings")
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
		attach_mode = "window",
		close_automatic_events = {},
		keymaps = keybindings.plugins.aerial,
		show_guides = true,
		guides = require("simonvic.signs").plugins.aerial,
		nav = {
			keymaps = keybindings.plugins.aerial_nav,
			win_opts = {
				winblend = 0
			}
		}
	})
	require("telescope").load_extension("aerial")
end
