local M = {}

M.config = {
	transparent = true,
	italic_comments = true,
	bold_docs = false,
	bold_types = false,
	bold_commandline = true,
}


M.palette = {
	accent_xxdark  = "#4C302F",
	accent_xdark   = "#88302B",
	accent_dark    = "#CC443D",
	accent         = "#F0544C",
	accent_light   = "#F6645D",
	accent_xlight  = "#EF9F9B",
	zdepth__4      = "#000000",
	zdepth__3      = "#111111",
	zdepth__2      = "#222222",
	zdepth__1      = "#252525",
	zdepth_0       = "#333333",
	zdepth_1       = "#3A3A3A",
	zdepth_2       = "#444444",
	zdepth_3       = "#505050",
	text_xxxdark   = "#505050",
	text_xxdark    = "#555555",
	text_xdark     = "#666666",
	text_dark      = "#808080",
	text           = "#CACACA",
	text_light     = "#DADADA",
	text_xxlight   = "#FAFAFA",
	text_xxxlight  = "#FFFFFF",
	disabled       = "#666666",

	constant       = "#9876AA",
	member         = "#9876AA",
	["function"]   = "#FFC66D",
	metakeyword    = "#BBB529",
	keyword        = "#CC7832",
	keyword_light  = "#f98b31",
	literal_string = "#6A8759",
	literal_bool   = "#8CB0CB",
	literal_number = "#6897BB",

	guide          = "#202020",
	code_bg        = "#404040",
	link           = "#6897BB",

	added          = "#2B5640",
	changed        = "#226688",
	deleted        = "#873E41",
	error          = "#E8312E",
	warn           = "#E87B2E",
	note           = "#D8E44C",
	info           = "#C9E9EF",
	hint           = "#CFD2D3",
	ok             = "#A9FF68",
}

local function buildGroups()
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
	return {

		------------------------------------------------------------------------ GENERAL

		------------------------------------------------------------------------ ui
		Normal                                = { bg = p.zdepth_0, fg = p.text },
		NormalNC                              = {}, -- TODO: darken non-focused windows?
		NormalFloat                           = {},
		Visual                                = { bg = p.accent_xxdark },
		Search                                = { bg = p.accent_xxdark },
		CurSearch                             = { bg = p.accent_xdark },
		IncSearch                             = { link = "Search" },
		Substitute                            = { link = "Search" },
		WinBar                                = { bg = p.zdepth_1, fg = p.text, bold = true, sp = "#333333" },
		TabLine                               = { bg = p.zdepth_0 },
		TabLineSel                            = { bg = p.zdepth_1, underline = true, sp = p.accent },
		TabLineFill                           = { bg = p.zdepth__1 },
		StatusLine                            = { bg = p.zdepth_1 },
		MsgArea                               = { bg = p.zdepth_1, bold = M.config.bold_commandline },
		MoreMsg                               = { bg = p.zdepth_1, bold = true },
		Question                              = { bg = p.zepth_1, bold = true },
		WinSeparator                          = { bg = p.zdepth_0, fg = p.text_xdark },
		VertSplit                             = { link = "WinSeparator" },
		FloatBorder                           = { link = "WinSeparator" },
		FloatTitle                            = { link = "Title" },
		Pmenu                                 = { bg = p.zdepth_1 },
		PmenuSel                              = { bg = p.accent_xxdark },
		PmenuSbar                             = { bg = p.zdepth_2 },
		PmenuThumb                            = { bg = p.accent_dark },
		Cursor                                = { bg = p.zdepth0, fg = p.text_dark },
		lCursor                               = { link = "Cursor" },
		CursorIM                              = { link = "Cursor" },
		-- TermCursor                         = {},
		-- TermCursorNC                       = {},
		ColorColumn                           = { bg = p.guide },
		CursorColumn                          = { link = "ColorColumn" },
		CursorLine                            = {},
		CursorLineNr                          = { bg = p.zdepth_1, fg = p.text_xxxlight, bold = true },
		LineNr                                = { bg = p.zdepth_1, fg = p.text_dark },
		SignColumn                            = { bg = p.zdepth_1, fg = p.text_xdark },
		FoldColumn                            = { bg = p.zdepth_1, fg = p.text_xdark },

		------------------------------------------------------------------------ text
		Title                                 = { fg = p.text_light, bold = true },
		Underlined                            = { fg = p.link, underline = true },
		Bold                                  = { bold = true },
		Italic                                = { italic = true },
		Conceal                               = { fg = p.text_xdark },
		NonText                               = { fg = p.text_xxdark, bold = true },
		SpecialKey                            = { bg = p.text_xxxdark, fg = p.text },
		Special                               = { link = "Keyword" },
		MatchParen                            = { bg = p.text_xxxdark, bold = true },
		Folded                                = { bg = p.disabled, fg = p.text_xlight },
		Directory                             = { link = "Normal" },

		------------------------------------------------------------------------ coding
		String                                = { fg = p.literal_string },
		Number                                = { fg = p.literal_number },
		Boolean                               = { fg = p.literal_bool },
		Identifier                            = { link = "Normal" },
		Constant                              = { fg = p.constant, bold = true },
		Function                              = { fg = p["function"] },
		Type                                  = { bg = "none", fg = p.text_xxlight, bold = M.config.bold_types },
		PreProc                               = { fg = p.metakeyword },
		Keyword                               = { fg = p.keyword },
		Statement                             = { link = "Keyword" },
		Delimiter                             = { link = "Keyword" },
		Operator                              = { link = "Keyword" },
		Comment                               = { bg = "none", fg = p.text_dark, italic = M.config.italic_comments },
		SpecialComment                        = { bg = "none", fg = p.text_dark, italic = M.config.italic_comments, bold = M.config.bold_docs },
		Todo                                  = { bg = "none", fg = p.hint, bold = true },
		Error                                 = { fg = p.error, undercurl = true },
		ErrorMsg                              = { link = "Error" },

		------------------------------------------------------------------------ diff
		DiffAdd                               = { bg = p.added, },
		DiffChange                            = { bg = p.changed, },
		DiffDelete                            = { bg = p.deleted, },

		------------------------------------------------------------------------ signs & diagnostics
		DiagnosticError                       = {},
		DiagnosticWarn                        = {},
		DiagnosticInfo                        = {},
		DiagnosticHint                        = {},
		DiagnosticSignError                   = { bg = p.zdepth_1, fg = p.error },
		DiagnosticSignWarn                    = { bg = p.zdepth_1, fg = p.warn },
		DiagnosticSignInfo                    = { bg = p.zdepth_1, fg = p.info },
		DiagnosticSignHint                    = { bg = p.zdepth_1, fg = p.hint },
		DiagnosticUnderlineError              = { sp = p.error, undercurl = true },
		DiagnosticUnderlineWarn               = { sp = p.warn, undercurl = true },
		DiagnosticUnderlineInfo               = { sp = p.info, undercurl = true },
		DiagnosticUnderlineHint               = { sp = p.hint, undercurl = true },
		DebugSignBreakpoint                   = { bg = p.zdepth_1, fg = p.error },
		DebugSignStopped                      = { bg = p.zdepth_1, fg = p.ok },
		DebugSignBreakpointCondition          = { bg = p.zdepth_1, fg = p.warn },
		DebugSignBreakpointRejected           = { bg = p.zdepth_1, fg = p.error },
		DebugSignBreakpointLog                = { bg = p.zdepth_1, fg = p.info },
		GitSignsAdd                           = { bg = p.zdepth_1, fg = p.added },
		GitSignsChange                        = { bg = p.zdepth_1, fg = p.changed },
		GitSignsDelete                        = { bg = p.zdepth_1, fg = p.deleted },
		GitSignsAddNr                         = {},
		GitSignsChangeNr                      = {},
		GitSignsDeleteNr                      = {},

		------------------------------------------------------------------------ PLUGINS

		------------------------------------------------------------------------ DapUI
		DapUINormal                           = { bg = p.zdepth_1 },
		DapUINormalNC                         = { bg = p.zdepth_1 },
		DapUIPlayPause                        = { bg = p.zdepth_1, fg = p.ok },
		DapUIStop                             = { bg = p.zdepth_1, fg = p.error },
		DapUIRestart                          = { bg = p.zdepth_1, fg = p.hint },
		DapUIStepOver                         = { bg = p.zdepth_1, fg = p.hint },
		DapUIStepInto                         = { bg = p.zdepth_1, fg = p.hint },
		DapUIStepBack                         = { bg = p.zdepth_1, fg = p.hint },
		DapUIStepOut                          = { bg = p.zdepth_1, fg = p.hint },
		DapUIPlayPauseNC                      = { link = "DapUIPlayPause" },
		DapUIStopNC                           = { link = "DapUIStop" },
		DapUIRestartNC                        = { link = "DapUIRestart" },
		DapUIStepOverNC                       = { link = "DapUIStepOver" },
		DapUIStepIntoNC                       = { link = "DapUIStepInto" },
		DapUIStepBackNC                       = { link = "DapUIStepBack" },
		DapUIStepOutNC                        = { link = "DapUIStepOut" },
		DapUIType                             = { link = "Type" },
		DapUILineNumber                       = { link = "ColorLine" },
		DapUIWatchesValue                     = { fg = p.text },
		DapUIWatchesError                     = { fg = p.error },
		DapUIWatchesEmpty                     = { fg = p.hint },
		DapUIModifiedValue                    = { bg = p.changed, fg = p.text, bold = true },
		DapUIScope                            = { fg = p.text, bold = true },
		DapUISource                           = { fg = p.text },
		DapUIDecoration                       = { fg = p.text, bold = true },
		DapUIBreakpointsPath                  = { fg = p.text, bold = true },
		DapUIBreakpointsCurrentLine           = { fg = p.text, bold = true },
		DapUIBreakpointsDisabledLine          = { fg = p.disabled },
		DapUIBreakpointsInfo                  = { fg = p.text, bold = true },
		DapUIFloatBorder                      = { fg = p.text },
		DapUIThread                           = { fg = p.text, bold = true },
		DapUIStoppedThread                    = { fg = p.warn },
		DapUIUnavailable                      = { bg = p.zdepth_1, fg = p.disabled },
		DapUIUnavailableNC                    = { link = "DapUIUnavailable" },

		------------------------------------------------------------------------ NeoTree
		NeoTreeNormal                         = { bg = p.zdepth_1, fg = p.text },
		NeoTreeCursorLine                     = { bg = p.accent_xxdark },
		NeoTreeTabInactive                    = { bg = p.zdepth_0, fg = p.text },
		NeoTreeTabActive                      = { bg = "none", underline = true, sp = p.accent },
		NeoTreeTabSeparatorInactive           = { bg = p.zdepth_0, fg = p.zdepth_0 },
		NeoTreeTabSeparatorActive             = { bg = p.zdepth_1, fg = p.zdepth_1 },

		------------------------------------------------------------------------ Scrollbar
		-- These colors are read from the scrollbar plugin config
		ScrollbarHandle                       = { bg = p.accent_xxdark },
		ScrollbarError                        = { fg = p.error },
		ScrollbarWarn                         = { fg = p.warn },
		ScrollbarInfo                         = { fg = p.info },
		ScrollbarHint                         = { fg = p.hint },
		ScrollbarErrorHandle                  = { bg = p.accent_xxdark, fg = p.error },
		ScrollbarWarnHandle                   = { bg = p.accent_xxdark, fg = p.warn },
		ScrollbarInfoHandle                   = { bg = p.accent_xxdark, fg = p.info },
		ScrollbarHintHandle                   = { bg = p.accent_xxdark, fg = p.hint },
		ScrollbarMiscHandle                   = { bg = p.accent_xxdark, fg = "#9876AA" },
		ScrollbarSearchHandle                 = { bg = p.accent_xxdark, fg = p.ok },

		------------------------------------------------------------------------ Noice
		NoiceCursor                           = { bg = p.accent },
		NoiceMini                             = { bg = p.zdepth_2 },

		------------------------------------------------------------------------ TREESITTER GROUPS
		["@comment.todo"]                     = { link = "Todo" },
		-- ["@constant.comment"]              = { fg = p.metakeyword, bold = true },
		["@comment.error"]                    = { fg = p.error, bold = true },
		["@comment.note"]                     = { fg = p.note, bold = true },
		["@comment.warning"]                  = { fg = p.warn, bold = true },
		["@comment.documentation"]            = { link = "SpecialComment" },
		["@boolean"]                          = { link = "Boolean" },
		["@character.printf"]                 = { link = "Keyword" },
		["@type.qualifier"]                   = { link = "Keyword" },
		["@type.builtin"]                     = { link = "Type" },
		["@attribute"]                        = { link = "PreProc" },
		["@markup.heading"]                   = { link = "Title" },
		["@markup.strong"]                    = { fg = p.text, bold = true },
		["@markup.italic"]                    = { fg = p.text, italic = true },
		["@markup.strikethrough"]             = { fg = p.text, strikethrough = true },
		["@markup.raw"]                       = { link = "markdownCode" },
		["@markup.raw.delimiter"]             = { link = "markdownCodeDelimiter" },
		["@markup.list"]                      = { link = "Keyword" },
		["@markup.quote"]                     = { link = "markdownBlockquote" },
		["@markup.link"]                      = { link = "markdownUrl" },
		["@tag.attribute"]                    = { link = "Normal" },
		["@punctuation"]                      = { link = "Keyword" },
		["@punctuation.delimiter"]            = { link = "@punctuation" },
		["@punctuation.bracket"]              = { link = "@punctuation" },
		["@punctuation.special"]              = { link = "@punctuation" },
		["@operator"]                         = { link = "Operator" },
		["@variable"]                         = { link = "Normal" },
		["@variable.member"]                  = { fg = p.member },
		["@module.builtin"]                   = { link = "Keyword" },

		------------------------------------------------------------------------ SEMANTIC GROUPS
		["@lsp.typemod.property.readonly"]    = { link = "Constant" },
		["@lsp.typemod.property.declaration"] = { fg = p.member },

		------------------------------------------------------------------------ LANGUAGES
		------------------------------------------------------------------------ markdown
		markdownCode                          = { bg = p.code_bg },
		markdownCodeBlock                     = { link = "markdownCode" },
		markdownCodeDelimiter                 = { link = "Delimiter" },
		markdownBlockquote                    = { bg = p.code_bg },
		markdownHeadingDelimiter              = { link = "Title" },
		markdownHeadingRule                   = { link = "Title" },
		markdownRule                          = { link = "Keyword" },

		------------------------------------------------------------------------ xml
		xmlTag                                = { link = "Keyword" },
		xmlTagName                            = { link = "Keyword" },
		xmlAttrib                             = { link = "Normal" },
		xmlEqual                              = { link = "Keyword" },

		------------------------------------------------------------------------ html
		htmlTag                               = { link = "xmlTag" },
		htmlEndTag                            = { link = "htmlTag" },
		htmlArg                               = { link = "xmlAttrib" },
		["@string.special.url.html"]          = { link = "String" },

		------------------------------------------------------------------------ css
		cssTagName                            = { link = "Keyword" },
		cssClassName                          = { link = "Type" },
		cssUrl                                = { link = "String" },

		------------------------------------------------------------------------ c
		cCharacter                            = { link = "String" },
		cDataStructure                        = { link = "Type" },
		cDataStructureKeyword                 = { link = "Keyword" },
		["@constant.c"]                       = { link = "PreProc" },
		["@keyword.directive"]                = { link = "PreProc" },
		["@keyword.import"]                   = { link = "PreProc" },

		------------------------------------------------------------------------ rust
		["@keyword.import.rust"]              = { link = "Keyword" },
		["@lsp.type.decorator.rust"]          = { link = "PreProc" },

		------------------------------------------------------------------------ makefile
		makeCommands                          = { link = "Function" },

		------------------------------------------------------------------------ java
		javaExternal                          = { link = "Keyword" },
		javaClassDecl                         = { link = "Keyword" },
		javaStorageClass                      = { link = "Keyword" },
		javaDocComment                        = { link = "SpecialComment" },
		javaDocTag                            = { link = "Keyword" },
		javaDocParam                          = { link = "Keyword" },
		javaCommentTitle                      = { link = "javaDocComment" },
		javaCommentStar                       = { link = "javaDocComment" },

		------------------------------------------------------------------------ lua
		luaTable                              = { link = "Keyword" },
		luaTableBlock                         = { link = "Constant" },
		luaConstant                           = { link = "@constant.builtin" },
		["@variable.member.lua"]              = { link = "@lsp.type.variable" },
		["@lsp.type.variable.lua"]            = { link = "@lsp.type.variable" },

		------------------------------------------------------------------------ shell
		shQuote                               = { link = "String" },
		shDeref                               = { link = "Identifier" },
		shArithRegion                         = { link = "Keyword" },
		shCmdSubRegion                        = { link = "Keyword" },
		["@variable.bash"]                    = { link = "@variable" },

		------------------------------------------------------------------------ ini
		dosiniHeader                          = { link = "Type" },
		dosiniLabel                           = { link = "Type" },
		["@property.ini"]                     = { link = "Type" },
	}
end

M.groups = buildGroups()

function M.apply()
	vim.g.colors_name = "simonvic"
	vim.o.termguicolors = true
	for group, colors in pairs(M.groups) do
		vim.api.nvim_set_hl(0, group, colors)
	end
end

return M
