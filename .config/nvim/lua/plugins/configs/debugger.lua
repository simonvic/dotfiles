return function()
	local dap = require("dap")
	dap.configurations.rust = {
		{
			name = 'Launch',
			type = 'rt_lldb',
			request = 'launch',
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
			args = {},
		},
	}
	local signs = {
		DiagnosticSignError    = { text = "", texthl = "DiagnosticSignError" },
		DiagnosticSignWarn     = { text = "", texthl = "DiagnosticSignWarn" },
		DiagnosticSignInfo     = { text = "", texthl = "DiagnosticSignInfo" },
		DiagnosticSignHint     = { text = "", texthl = "DiagnosticSignHint" },
		DapBreakpoint          = { text = "", texthl = "DebugSignBreakpoint" },
		DapStopped             = { text = "", texthl = "DebugSignStopped" },
		DapBreakpointCondition = { text = "", texthl = "DebugSignBreakpointCondition" },
		DapBreakpointRejected  = { text = "", texthl = "DebugSignBreakpointRejected" },
		DapLogPoint            = { text = "", texthl = "DebugSignBreakpointLog" },
	}
	for name, sign in pairs(signs) do
		-- sign.numhl = sign.texthl
		vim.fn.sign_define(name, sign)
	end
end
