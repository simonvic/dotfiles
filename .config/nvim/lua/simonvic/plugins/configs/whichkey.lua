return function()
	local glyphs = require("simonvic.glyphs").plugins.whichkey
	require("which-key").setup({
		preset = "helix",
		win = {
			no_overlap = true,
			border = "rounded",
			padding = { 1, 2 },
			title = true,
			zindex = 1000,
		},
		icons = {
			breadcrumb = glyphs.breadcrumb,
			separator = glyphs.separator,
			group = glyphs.group,
			ellipsis = glyphs.ellipsis,
			keys = glyphs.keys
		},
	})
end
