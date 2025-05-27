return function()
	-- Use nvim-treesitter indentation expr
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "*" },
		callback = function(args)
			local lang = vim.treesitter.language.get_lang(args.match)
			if lang and vim.treesitter.language.add(lang) then
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end,
	})
end
