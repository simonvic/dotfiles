return function()
	local npairs = require("nvim-autopairs")
	npairs.setup({
		enable_check_bracket_line = false,
		check_ts = true
	})
	local Rule = require("nvim-autopairs.rule")
	local cond = require("nvim-autopairs.conds")
	npairs.add_rules({
		Rule('"""', '"""', { "java" }):with_pair(cond.not_before_char('"', 3)),
		Rule('$', '$', { "tex", "latex" }),
		Rule('\\[', '\\]', { "tex", "latex" }),
		Rule("<", ">", { "giovi" }):with_pair(cond.before_text(".")),
		Rule("#{?", "}#", { "giovi" }):with_pair(cond.not_after_text("}#")),
		Rule("#{", "}#", { "giovi" }),
	})
end
