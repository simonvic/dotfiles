return function()
	require("mason").setup({
		ui = {
			border = "rounded",
			icons = {
				package_installed = "✓",
				package_uninstalled = "·",
				package_pending = "ﮮ",
			},
		}
	})
end
