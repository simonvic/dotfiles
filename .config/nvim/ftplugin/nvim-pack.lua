local groups = {
	DiagnosticWarn = { link = "Title" },
	DiagnosticInfo = { link = "String" },
	DiagnosticHint = { link = "Comment" },
	-- Added          = { link = "Special" }
}
for group, colors in pairs(groups) do
	vim.api.nvim_set_hl(0, group, colors)
end

function NvimPackFoldExpr()
	local line = vim.fn.getline(vim.v.lnum)
	if line:find("# Update ─") then
		return ">1"
	end
	if line:find("## ") then
		return ">2"
	end
	if line:find("Path:") then
		return ">4" -- NOTE: intenionally higher than 3, so with foldlevel=3 this remains folded
	end
	if line:find("Pending updates:") then
		return ">3"
	end
	if line:find("# Same ─") then
		return ">1"
	end
	return "="
end

vim.wo.foldexpr = "v:lua.NvimPackFoldExpr()"
vim.wo.foldlevel = 3
