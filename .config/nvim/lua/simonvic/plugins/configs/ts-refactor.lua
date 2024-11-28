return function()
	---@diagnostic disable-next-line: missing-fields
	require("nvim-treesitter.configs").setup({
		refactor = {
			highlight_definitions = {
				enable = false
			},
			highlight_current_scope = {
				enable = false
			},
			navigation = {
				enable = false,
			}
		}
	})
end
