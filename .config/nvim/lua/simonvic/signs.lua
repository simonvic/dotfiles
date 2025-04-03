local M = {}

M.diagnostic = {
	DiagnosticSignError = { text = "", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" },
	DiagnosticSignWarn  = { text = "", texthl = "DiagnosticSignWarn",  numhl = "DiagnosticSignWarn" },
	DiagnosticSignInfo  = { text = "", texthl = "DiagnosticSignInfo",  numhl = "DiagnosticSignInfo" },
	DiagnosticSignHint  = { text = "", texthl = "DiagnosticSignHint",  numhl = "DiagnosticSignHint" },
}

M.plugins = {}

M.plugins.dap = {
	DapBreakpoint          = { text = "", texthl = "DebugSignBreakpoint" },
	DapStopped             = { text = "", texthl = "DebugSignStopped" },
	DapBreakpointCondition = { text = "", texthl = "DebugSignBreakpointCondition" },
	DapBreakpointRejected  = { text = "", texthl = "DebugSignBreakpointRejected" },
	DapLogPoint            = { text = "", texthl = "DebugSignBreakpointLog" },
}

return M
