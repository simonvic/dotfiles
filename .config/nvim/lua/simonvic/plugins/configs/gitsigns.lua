return function()
	require('gitsigns').setup({
		preview_config = {
			border = "rounded",
		},
		signs = {
			changedelete = { text = "┣"},
		},
	})
end
