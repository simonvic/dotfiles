local vim = vim
local M = {}

M.config = {
	transparent = false,
	italic_comments = true
}

M.palette = {
	accent_xdark  = "#4C302F",
	accent_dark   = "#CC443D",
	accent        = "#F0544C",
	accent_light  = "#F6645D",
	accent_xlight = "#EF9F9B",

	zdepth__4 = "#000000",
	zdepth__3 = "#111111",
	zdepth__2 = "#222222",
	zdepth__1 = "#252525",
	zdepth_0  = "#333333",
	zdepth_1  = "#3A3A3A",
	zdepth_2  = "#444444",
	zdepth_3  = "#505050",

	disabled = "#666666",

	text_xdark    = "#666666",
	text_dark     = "#808080",
	text          = "#CACACA",
	text_light    = "#DADADA",
	text_xxlight  = "#FAFAFA",
	text_xxxlight = "#FFFFFF",

	added   = "#2B5640",
	changed = "#303C47",
	deleted = "#873E41",

	error = "#E8312E",
	warn  = "#E87B2E",
	info  = "#C9E9EF",
	hint  = "#CFD2D3",
	ok    = "#A9FF68",

}
local p = M.palette
if M.config.transparent then
	p.zdepth__4 = "none"
	p.zdepth__3 = "none"
	p.zdepth__2 = "none"
	p.zdepth__1 = "none"
	p.zdepth_0  = "none"
	p.zdepth_1  = "none"
	p.zdepth_2  = "none"
	p.zdepth_3  = "none"
end

-- @TODO darken non-focused windows?
M.groups = {
	NonText                      = { fg = p.zdepth_0, bold = true },
	Visual                       = { bg = p.accent_xdark },
	CursorLine                   = { bg = p.zdepth__1 },
	ColorColumn                  = { bg = p.zdepth_1 },
	WinBar                       = { bg = p.zdepth_1, fg = p.text, bold = true },
	StatusLine                   = { bg = p.zdepth_1 },
	Normal                       = { bg = p.zdepth_0, fg = p.text },
	-- NormalNC                     = { bg = p.zdepth__1, fg = p.text },
	MsgArea                      = { bg = p.zdepth_1 },
	VertSplit                    = { bg = p.zdepth_1, fg = p.text_xdark },
	Pmenu                        = { bg = p.zdepth_1 },
	PmenuSel                     = { bg = p.accent_xdark },
	PmenuSbar                    = { bg = p.zdepth_2 },
	PmenuThumb                   = { bg = p.accent_dark },
	NormalFloat                  = {},
	DiffAdd                      = { bg = p.added, },
	DiffChange                   = { bg = p.changed, },
	DiffDelete                   = { bg = p.deleted, },
	DiagnosticError              = {},
	DiagnosticWarn               = {},
	DiagnosticInfo               = {},
	DiagnosticHint               = {},
	DapUIPlayPause               = { bg = p.zdepth_1, fg = p.ok },
	DapUIStop                    = { bg = p.zdepth_1, fg = p.error },
	DapUIRestart                 = { bg = p.zdepth_1, fg = p.hint },
	DapUIStepOver                = { bg = p.zdepth_1, fg = p.hint },
	DapUIStepInto                = { bg = p.zdepth_1, fg = p.hint },
	DapUIStepBack                = { bg = p.zdepth_1, fg = p.hint },
	DapUIStepOut                 = { bg = p.zdepth_1, fg = p.hint },
	LineNr                       = { bg = p.zdepth_1, fg = p.text_dark },
	CursorLineNr                 = { bg = p.zdepth_1, fg = p.text_xxxlight, bold = true },
	SignColumn                   = { bg = p.zdepth_1, fg = p.text_xdark },
	FoldColumn                   = { bg = p.zdepth_1, fg = p.text_xdark },
	DapUIUnavailable             = { bg = p.zdepth_1, fg = p.disabled },
	DiagnosticSignError          = { bg = p.zdepth_1, fg = p.error },
	DiagnosticSignWarn           = { bg = p.zdepth_1, fg = p.warn },
	DiagnosticSignInfo           = { bg = p.zdepth_1, fg = p.info },
	DiagnosticSignHint           = { bg = p.zdepth_1, fg = p.hint },
	DebugSignBreakpoint          = { bg = p.zdepth_1, fg = p.error },
	DebugSignStopped             = { bg = p.zdepth_1, fg = p.ok },
	DebugSignBreakpointCondition = { bg = p.zdepth_1, fg = p.warn },
	DebugSignBreakpointRejected  = { bg = p.zdepth_1, fg = p.error },
	DebugSignBreakpointLog       = { bg = p.zdepth_1, fg = p.info },
	GitSignsAdd                  = { bg = p.zdepth_1, fg = p.added },
	GitSignsChange               = { bg = p.zdepth_1, fg = p.changed },
	GitSignsDelete               = { bg = p.zdepth_1, fg = p.deleted },
	GitSignsAddNr                = {},
	GitSignsChangeNr             = {},
	GitSignsDeleteNr             = {},
	DiagnosticUnderlineError     = { undercurl = true },
	DiagnosticUnderlineWarn      = { undercurl = true },
	DiagnosticUnderlineInfo      = { undercurl = true },
	DiagnosticUnderlineHint      = { undercurl = true },


	-- Neo tree plugin
	NeoTreeNormal     = { bg = p.zdepth_1, fg = p.text },
	NeoTreeCursorLine = { bg = p.accent_xdark },

	-- These colors are read from the scrollbar plugin config
	ScrollbarHandle       = { bg = p.accent_xdark },
	ScrollbarError        = { fg = p.error },
	ScrollbarWarn         = { fg = p.warn },
	ScrollbarInfo         = { fg = p.info },
	ScrollbarHint         = { fg = p.hint },
	ScrollbarErrorHandle  = { bg = p.accent_xdark, fg = p.error },
	ScrollbarWarnHandle   = { bg = p.accent_xdark, fg = p.warn },
	ScrollbarInfoHandle   = { bg = p.accent_xdark, fg = p.info },
	ScrollbarHintHandle   = { bg = p.accent_xdark, fg = p.hint },
	ScrollbarMiscHandle   = { bg = p.accent_xdark, fg = "#9876AA" },
	ScrollbarSearchHandle = { bg = p.accent_xdark, fg = p.ok },

	-- PreProc      = { fg = "#BBB529" },
	Comment                    = { fg = "#808080", italic = M.config.italic_comments },
	Type                       = { fg = "#FAFAFA", bold = false },
	["@parameter"]             = { fg = "#CACACA", bold = false },
	["@variable"]              = { fg = "#CACACA", bold = false },
	["@field"]                 = { fg = "#9876AA", bold = false },
	["@constant.comment"]      = { fg = "#BBB529", bold = true },
	["@attribute"]             = { fg = "#BBB529", bold = false },
	["@punctuation.bracket"]   = { fg = "#CACACA", bold = false },
	["@punctuation.delimiter"] = { fg = "#CC7832", bold = false },
	["@type.builtin"]          = { fg = "#f98b31", bold = false },
	["@variable.builtin"]      = { fg = "#f98b31", bold = false },
}


function M.apply()
	vim.cmd("colorscheme darcula")
	for group, colors in pairs(M.groups) do
		vim.api.nvim_set_hl(0, group, colors)
	end
end

return M