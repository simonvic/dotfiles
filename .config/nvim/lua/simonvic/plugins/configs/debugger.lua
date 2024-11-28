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

	require("simonvic.keybindings").implement({
		-- TODO: eventually replace with dap functions
		debugger_continue       = function() vim.cmd("DapContinue") end,
		debugger_terminate      = function() vim.cmd("DapTerminate") end,
		debugger_rerun          = dap.run_last,
		debugger_stepover       = function() vim.cmd("DapStepOver") end,
		debugger_stepin         = function() vim.cmd("DapStepIn") end,
		debugger_stepout        = function() vim.cmd("DapStepOut") end,
		breakpoint_toggle       = function() vim.cmd("DapToggleBreakpoint") end,
		breakpoint_log          = function()
			vim.ui.input({ prompt = "Log point message" }, function(message)
				dap.set_breakpoint(nil, nil, message)
			end)
		end,

		breakpoint_condition    = function()
			vim.ui.input({ prompt = "Breakpoint condition" }, function(condition)
				dap.set_breakpoint(condition)
			end)
		end,

		breapoint_condition_log = function()
			vim.ui.input({ prompt = "Breakpoint condition" }, function(condition)
				vim.ui.input({ prompt = "Log point message" }, function(message)
					dap.set_breakpoint(condition, nil, message)
				end)
			end)
		end,
	})
end
