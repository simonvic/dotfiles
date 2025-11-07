-------------------------------------------------------------------------------- FILETYPES
vim.filetype.add({
	pattern = {
		[".*/scripts/.*/.*%.c"] = "enforce",
	},
	filename = {
		["config.cpp"] = "rvparam",
	},
	extension = {
		giovi = "giovi",
	},
})

-------------------------------------------------------------------------------- PARSERS
vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		local parsers = require("nvim-treesitter.parsers")

		-- parsers.enforce.install_info = {
		-- 	path = "~/Documents/Productivity/Programming/treesitter/tree-sitter-enforce",
		-- 	queries = "queries",
		-- 	generate = true,
		-- }

		parsers.rvparam = {
			install_info = {
				url = "https://github.com/simonvic/tree-sitter-rvparam",
				-- path = "~/Documents/Productivity/Programming/treesitter/tree-sitter-rvparam",
				queries = "queries",
				generate = true,
			},
		}

		parsers.textblock = {
			install_info = {
				url = "https://github.com/simonvic/tree-sitter-textblock",
				-- path = "~/Documents/Productivity/Programming/treesitter/tree-sitter-textblock",
				queries = "queries",
				generate = true,
			},
		}

		parsers.giovi = {
			install_info = {
				path = "~/Documents/Productivity/Programming/treesitter/tree-sitter-giovi",
				url = "https://github.com/simonvic/tree-sitter-giovi",
				queries = "queries",
				generate = true,
			},
		}

	end
})

-------------------------------------------------------------------------------- LSP
-- vim.lsp.enable({
-- 	"enforcels",
-- 	"giovils",
-- })
