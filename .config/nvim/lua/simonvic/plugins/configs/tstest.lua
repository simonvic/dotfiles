return function()
	-- mkdir parser && tree-sitter build -o parser/test.so
	vim.g.tstest_fullwidth_rules = false
	vim.g.tstest_rule_hlgroup = "FoldColumn"
end
