local vim = vim
local M = {}

M.config = {
	transparent = true,
	italic_comments = true
}

M.palette = {
	accent_xxdark = "#4C302F",
	accent_xdark  = "#88302B",
	accent_dark   = "#CC443D",
	accent        = "#F0544C",
	accent_light  = "#F6645D",
	accent_xlight = "#EF9F9B",
	zdepth__4     = "#000000",
	zdepth__3     = "#111111",
	zdepth__2     = "#222222",
	zdepth__1     = "#252525",
	zdepth_0      = "#333333",
	zdepth_1      = "#3A3A3A",
	zdepth_2      = "#444444",
	zdepth_3      = "#505050",
	disabled      = "#666666",
	text_xdark    = "#666666",
	text_dark     = "#808080",
	text          = "#CACACA",
	text_light    = "#DADADA",
	text_xxlight  = "#FAFAFA",
	text_xxxlight = "#FFFFFF",
	added         = "#2B5640",
	changed       = "#226688",
	deleted       = "#873E41",
	error         = "#E8312E",
	warn          = "#E87B2E",
	info          = "#C9E9EF",
	hint          = "#CFD2D3",
	ok            = "#A9FF68",
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
	Visual                       = { bg = p.accent_xxdark },
	Search                       = { bg = p.accent_xdark },
	CursorLine                   = { bg = p.zdepth__1 },
	ColorColumn                  = { bg = p.zdepth_1 },
	WinBar                       = { bg = p.zdepth_1, fg = p.text, bold = true },
	StatusLine                   = { bg = p.zdepth_1 },
	TabLine                      = { bg = p.zdepth_0 },
	TabLineSel                   = { bg = p.zdepth_1, underline = true, sp = p.accent },
	TabLineFill                  = { bg = p.zdepth__1 },
	Normal                       = { bg = p.zdepth_0, fg = p.text },
	-- NormalNC                     = { bg = p.zdepth__1, fg = p.text },
	MsgArea                      = { bg = p.zdepth_1 },
	VertSplit                    = { bg = p.zdepth_1, fg = p.text_xdark },
	Pmenu                        = { bg = p.zdepth_1 },
	PmenuSel                     = { bg = p.accent_xxdark },
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
	LineNr                       = { bg = p.zdepth_1, fg = p.text_dark },
	CursorLineNr                 = { bg = p.zdepth_1, fg = p.text_xxxlight, bold = true },
	SignColumn                   = { bg = p.zdepth_1, fg = p.text_xdark },
	FoldColumn                   = { bg = p.zdepth_1, fg = p.text_xdark },
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
	DiagnosticUnderlineError     = { sp = p.error, undercurl = true },
	DiagnosticUnderlineWarn      = { sp = p.warn, undercurl = true },
	DiagnosticUnderlineInfo      = { sp = p.info, undercurl = true },
	DiagnosticUnderlineHint      = { sp = p.hint, undercurl = true },
	-- DAP UI
	DapUINormal                  = { bg = p.zdepth_1 },
	DapUINormalNC                = { bg = p.zdepth_1 },
	DapUIPlayPause               = { bg = p.zdepth_1, fg = p.ok },
	DapUIStop                    = { bg = p.zdepth_1, fg = p.error },
	DapUIRestart                 = { bg = p.zdepth_1, fg = p.hint },
	DapUIStepOver                = { bg = p.zdepth_1, fg = p.hint },
	DapUIStepInto                = { bg = p.zdepth_1, fg = p.hint },
	DapUIStepBack                = { bg = p.zdepth_1, fg = p.hint },
	DapUIStepOut                 = { bg = p.zdepth_1, fg = p.hint },
	DapUIPlayPauseNC             = { link = "DapUIPlayPause" },
	DapUIStopNC                  = { link = "DapUIStop" },
	DapUIRestartNC               = { link = "DapUIRestart" },
	DapUIStepOverNC              = { link = "DapUIStepOver" },
	DapUIStepIntoNC              = { link = "DapUIStepInto" },
	DapUIStepBackNC              = { link = "DapUIStepBack" },
	DapUIStepOutNC               = { link = "DapUIStepOut" },
	DapUIType                    = { link = "Type" },
	DapUILineNumber              = { link = "ColorLine" },
	DapUIWatchesValue            = { fg = p.text },
	DapUIWatchesError            = { fg = p.error },
	DapUIWatchesEmpty            = { fg = p.hint },
	DapUIModifiedValue           = { bg = p.changed, fg = p.text, bold = true },
	DapUIScope                   = { fg = p.text, bold = true },
	DapUISource                  = { fg = p.text },
	DapUIDecoration              = { fg = p.text, bold = true },
	DapUIBreakpointsPath         = { fg = p.text, bold = true },
	DapUIBreakpointsCurrentLine  = { fg = p.text, bold = true },
	DapUIBreakpointsDisabledLine = { fg = p.disabled },
	DapUIBreakpointsInfo         = { fg = p.text, bold = true },
	DapUIFloatBorder             = { fg = p.text },
	DapUIThread                  = { fg = p.text, bold = true },
	DapUIStoppedThread           = { fg = p.warn },
	DapUIUnavailable             = { bg = p.zdepth_1, fg = p.disabled },
	DapUIUnavailableNC           = { link = "DapUIUnavailable" },
	-- Neo tree plugin
	NeoTreeNormal                = { bg = p.zdepth_1, fg = p.text },
	NeoTreeCursorLine            = { bg = p.accent_xxdark },
	NeoTreeTabInactive           = { bg = p.zdepth_0 },
	NeoTreeTabActive             = { bg = p.zdepth_1, underline = true, sp = p.accent },
	NeoTreeTabSeparatorInactive  = { bg = p.zdepth_0, fg = p.zdepth_0 },
	NeoTreeTabSeparatorActive    = { bg = p.zdepth_1, fg = p.zdepth_1 },
	-- These colors are read from the scrollbar plugin config
	ScrollbarHandle              = { bg = p.accent_xxdark },
	ScrollbarError               = { fg = p.error },
	ScrollbarWarn                = { fg = p.warn },
	ScrollbarInfo                = { fg = p.info },
	ScrollbarHint                = { fg = p.hint },
	ScrollbarErrorHandle         = { bg = p.accent_xxdark, fg = p.error },
	ScrollbarWarnHandle          = { bg = p.accent_xxdark, fg = p.warn },
	ScrollbarInfoHandle          = { bg = p.accent_xxdark, fg = p.info },
	ScrollbarHintHandle          = { bg = p.accent_xxdark, fg = p.hint },
	ScrollbarMiscHandle          = { bg = p.accent_xxdark, fg = "#9876AA" },
	ScrollbarSearchHandle        = { bg = p.accent_xxdark, fg = p.ok },
	-- Noice
	NoiceCursor                  = { bg = p.accent },
	NoiceMini                    = { bg = p.zdepth_2 },
	-- Aerial
	AerialLine                   = { bg = p.accent_xxdark },
	--
	Comment                      = { bg = "none", fg = "#808080", italic = M.config.italic_comments },
	Type                         = { bg = "none", fg = "#FAFAFA", bold = false },
	Todo                         = { bg = "none", fg = p.hint, bold = true },
	Constant                     = { fg = "#9876AA" },
	["@parameter"]               = { bg = "none", fg = "#CACACA", bold = false },
	["@variable"]                = { bg = "none", fg = "#CACACA", bold = false },
	["@field"]                   = { bg = "none", fg = "#9876AA", bold = false },
	["@constant.comment"]        = { bg = "none", fg = "#BBB529", bold = true },
	["@attribute"]               = { bg = "none", fg = "#BBB529", bold = false },
	["@punctuation.bracket"]     = { bg = "none", fg = "#CACACA", bold = false },
	["@punctuation.delimiter"]   = { bg = "none", fg = "#CC7832", bold = false },
	["@type.qualifier"]          = { bg = "none", fg = "#CC7832", bold = false },
	["@type.builtin"]            = { bg = "none", fg = "#f98b31", bold = false },
	["@variable.builtin"]        = { bg = "none", fg = "#f98b31", bold = false },
	["@text.todo"]               = { link = "Todo" },
	["@text.danger"]             = { bg = "none", fg = p.warn, bold = true },
	["@lsp.type.property.lua"]   = { link = "@field" }
}

function M.apply()
	if M.config.transparent then
		M.groups.ColorColumn = { bg = "#202020" }
		M.groups.NonText = { fg = "#555555", bold = true }
	end
	vim.cmd("colorscheme darcula")
	for group, colors in pairs(M.groups) do
		vim.api.nvim_set_hl(0, group, colors)
	end
end

return M
