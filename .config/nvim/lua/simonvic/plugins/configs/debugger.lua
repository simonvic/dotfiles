return function()
	local dap = require("dap")
	local signs = require("simonvic.signs").plugins.dap
	for name, sign in pairs(signs) do
		-- sign.numhl = sign.texthl
		vim.fn.sign_define(name, sign)
	end
end
