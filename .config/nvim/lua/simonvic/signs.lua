local M = {}

local glyphs = require("simonvic.glyphs")

M.diagnostic = {
	DiagnosticSignError = { text = glyphs.diagnostics.Error, texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" },
	DiagnosticSignWarn  = { text = glyphs.diagnostics.Warn,  texthl = "DiagnosticSignWarn",  numhl = "DiagnosticSignWarn" },
	DiagnosticSignInfo  = { text = glyphs.diagnostics.Info,  texthl = "DiagnosticSignInfo",  numhl = "DiagnosticSignInfo" },
	DiagnosticSignHint  = { text = glyphs.diagnostics.Hint,  texthl = "DiagnosticSignHint",  numhl = "DiagnosticSignHint" },
}

M.plugins = {}

M.plugins.dap = {
	DapBreakpoint          = { text = glyphs.dap.breakpoint,           texthl = "DebugSignBreakpoint" },
	DapStopped             = { text = glyphs.dap.stopped,              texthl = "DebugSignStopped" },
	DapBreakpointCondition = { text = glyphs.dap.breakpoint_condition, texthl = "DebugSignBreakpointCondition" },
	DapBreakpointRejected  = { text = glyphs.dap.breakpoint_rejected,  texthl = "DebugSignBreakpointRejected" },
	DapLogPoint            = { text = glyphs.dap.log_point,            texthl = "DebugSignBreakpointLog" },
}

return M
