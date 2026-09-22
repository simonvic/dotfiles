return function()
	vim.g.vimtex_view_general_viewer = "zathura"
	vim.g.vimtex_view_method = "zathura_simple"
	vim.g.vimtex_indent_on_ampersands = 1
	-- vim.g.vimtex_compiler_latexmk = { options = { "-shell-escape" } }
	-- vim.g.vimtex_compiler_latexmk_engines = {
	-- 	['_'] = '-lualatex', -- or '-xelatex' for xelatex
	-- 	['pdflatex'] = '-pdf',
	-- 	['lualatex'] = '-lualatex',
	-- 	['xelatex'] = '-xelatex',
	-- }
end
