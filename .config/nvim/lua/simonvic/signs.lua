local M = {}

M.diagnostic = {
	DiagnosticSignError = { text = "", texthl = "DiagnosticSignError", linehl = "DiagnosticSignError" },
	DiagnosticSignWarn  = { text = "", texthl = "DiagnosticSignWarn",  linehl = "DiagnosticSignWarn" },
	DiagnosticSignInfo  = { text = "", texthl = "DiagnosticSignInfo",  linehl = "DiagnosticSignInfo" },
	DiagnosticSignHint  = { text = "", texthl = "DiagnosticSignHint",  linehl = "DiagnosticSignHint" },
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
