return function()
	local dap = require("dap")
	dap.adapters.lldb = {
		type = 'executable',
		command = '/usr/bin/lldb-dap',
		name = 'lldb'
	}
	dap.configurations.c = {
		{
			name = 'Launch',
			type = 'lldb',
			request = 'launch',
			-- program = vim.fn.getcwd() .. '/target/a.out',
			program = function() return require("dap.utils").pick_file() end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
			args = {},
		}
	}
	local signs = require("simonvic.signs").plugins.dap
	for name, sign in pairs(signs) do
		-- sign.numhl = sign.texthl
		vim.fn.sign_define(name, sign)
	end
end
