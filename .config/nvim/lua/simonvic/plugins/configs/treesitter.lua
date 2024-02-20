return function()
	require("nvim-treesitter.configs").setup {
		-- ensure_installed = "all",
		highlight = {
			enable = true,
			disable = { "gitcommit" },
		},
		indent = {
			enable = true,
		},
		autotag = {
			enable = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = require("simonvic.keybindings").plugins.treesitter,
		},
	}
end
