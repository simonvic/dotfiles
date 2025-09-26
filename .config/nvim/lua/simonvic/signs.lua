local M = {}

local glyphs = require("simonvic.glyphs")

M.diagnostic = {
	DiagnosticSignError = { text = glyphs.diagnostics.error, texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" },
	DiagnosticSignWarn  = { text = glyphs.diagnostics.warn,  texthl = "DiagnosticSignWarn",  numhl = "DiagnosticSignWarn" },
	DiagnosticSignInfo  = { text = glyphs.diagnostics.info,  texthl = "DiagnosticSignInfo",  numhl = "DiagnosticSignInfo" },
	DiagnosticSignHint  = { text = glyphs.diagnostics.hint,  texthl = "DiagnosticSignHint",  numhl = "DiagnosticSignHint" },
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
