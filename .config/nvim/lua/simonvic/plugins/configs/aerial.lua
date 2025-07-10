return function()
	local keybindings = require("simonvic.keybindings")
	local glyphs = require("simonvic.glyphs")
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
		filter_kind = false,
		attach_mode = "window",
		close_automatic_events = {},
		keymaps = keybindings.plugins.aerial.base,
		show_guides = true,
		guides = {
			mid_item = glyphs.fs.indent_markers.item .. " ",
			nested_top = glyphs.fs.indent_markers.edge .. " ",
			last_item = glyphs.fs.indent_markers.bottom .. " ",
			whitespace = "  ",
		},
		nav = {
			keymaps = keybindings.plugins.aerial.nav,
			win_opts = {
				winblend = 0
			}
		}
	})
	local ok, telescope = pcall(require, "telescope")
	if ok then telescope.load_extension("aerial") end
	keybindings.implement({
		symbols_outline_focus = function() vim.cmd("AerialToggle") end,
		symbols_outline_float = function() vim.cmd("AerialNavToggle") end
	})
end
