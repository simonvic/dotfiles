local M = {}

---@alias Palette table<string, string>

---@alias Groups vim.api.keyset.highlight

---@class Colorscheme
---@field name string
---@field palette Palette
---@field groups Groups
---@field build fun(colorscheme: Colorscheme, overrides: Overrides): Colorscheme
---@field apply fun(colorscheme: Colorscheme)

---@class Overrides
---@field name? string
---@field palette? Palette
---@field groups? Groups|fun(palette:Palette):Groups

---Build a new colorscheme
---@param colorscheme Colorscheme
---@param overrides? Overrides
---@return Colorscheme
function M.build(colorscheme, overrides)
	local name = overrides and overrides.name or colorscheme.name
	local palette = vim.tbl_deep_extend("force", colorscheme.palette, overrides and overrides.palette or {})
	local groups = M.build_groups(palette)
	if overrides then
		local groups_type = type(overrides.groups)
		if groups_type == "table" then
			groups = vim.tbl_deep_extend("force", groups, overrides.groups)
		elseif groups_type == "function" then
			groups = vim.tbl_deep_extend("force", groups, overrides.groups(palette))
		end
	end
	return { ---@type Colorscheme
		name = name,
		palette = palette,
		groups = groups,
		build = M.build,
		apply = M.apply,
	}
end

---Apply the given colorscheme
---@param colorscheme Colorscheme
function M.apply(colorscheme)
	vim.g.colors_name = colorscheme.name
	for group, colors in pairs(colorscheme.groups) do
		vim.api.nvim_set_hl(0, group, colors)
	end
end

---@type Palette
--- color__n: base color - n, blends more with background
--- color_0: base color
--- color_n: base color + n, stands out more from the background
M.palette = {

	accent__4         = "#3F2727",
	accent__3         = "#4C302F",
	accent__2         = "#88302B",
	accent__1         = "#CC443D",
	accent            = "#F0544C",
	accent_1          = "#F6645D",
	accent_2          = "#F27F79",
	accent_3          = "#EF9F9B",
	accent_4          = "#F7B3AF",

	zdepth__4         = "none",
	zdepth__3         = "none",
	zdepth__2         = "none",
	zdepth__1         = "none",
	zdepth_0          = "none",
	zdepth_1          = "none",
	zdepth_2          = "none",
	zdepth_3          = "none",
	zdepth_4          = "none",

	text__4           = "#505050",
	text__3           = "#555555",
	text__2           = "#666666",
	text__1           = "#808080",
	text              = "#CACACA",
	text_1            = "#DADADA",
	text_2            = "#EEEEEE",
	text_3            = "#FAFAFA",
	text_4            = "#FFFFFF",

	guide             = "#202020",
	code_bg           = "#404040",
	url               = "#6897BB",

	disabled          = "#666666",
	special           = "#CC7832",
	constant          = "#9876AA",
	member            = "#9876AA",
	func              = "#FFC66D",
	metakeyword       = "#BBB529",
	keyword           = "#CC7832",
	keyword_1         = "#DCA537",
	literal_string__4 = "#283422",
	literal_string    = "#6A8759",
	literal_bool      = "#8CB0FF",
	literal_number    = "#6897BB",

	added__2          = "#2B5640",
	added             = "#3A8C62",
	changed__2        = "#635B2B",
	changed           = "#D3954A",
	deleted__2        = "#873E41",
	deleted           = "#C13C40",
	error             = "#E8312E",
	warn              = "#E87B2E",
	note              = "#D8E44C",
	info              = "#C9E9EF",
	hint              = "#CFD2D3",
	ok                = "#A9FF68",

}

---Build highlight groups
---@param palette Palette
---@return vim.api.keyset.highlight
function M.build_groups(palette)
	local p = palette
	local groups = {

		------------------------------------------------------------------------ GENERAL

		------------------------------------------------------------------------ ui
		Normal                             = { bg = p.zdepth_0, fg = p.text },
		NormalNC                           = {},
		NormalFloat                        = {},
		Visual                             = { bg = p.accent__3 },
		SnippetTabstop                     = { bg = p.accent__3, italic = true },
		Search                             = { bg = p.accent__4 },
		CurSearch                          = { bg = p.accent__4 },
		IncSearch                          = { link = "Search" },
		Substitute                         = { link = "Search" },
		WinBar                             = { bg = p.zdepth_1, fg = p.text, bold = true, sp = "#333333" },
		WinBarNC                           = { link = "WinBar" },
		TabLine                            = { bg = p.zdepth_0 },
		TabLineSel                         = { bg = p.zdepth_1, underline = true, sp = p.accent__2 },
		TabLineFill                        = { bg = p.zdepth__1 },
		StatusLine                         = { bg = p.zdepth_1 },
		MsgArea                            = { bg = p.zdepth_1, bold = true },
		MoreMsg                            = { bg = p.zdepth_1, bold = true },
		Question                           = { bg = p.zepth_1, bold = true },
		WinSeparator                       = { bg = p.zdepth_1, fg = p.text__2 },
		VertSplit                          = { link = "WinSeparator" },
		FloatBorder                        = { link = "WinSeparator" },
		FloatTitle                         = { link = "Title" },
		Pmenu                              = { fg = p.text, bg = p.zdepth_1 },
		PmenuKind                          = { fg = p.text__1 },
		PmenuExtra                         = { fg = p.text__1 },
		PmenuSel                           = { bg = p.accent__3 },
		PmenuSbar                          = { bg = p.accent__4 },
		PmenuThumb                         = { bg = p.accent__2 },
		Cursor                             = { bg = p.zdepth0, fg = p.text__1 },
		lCursor                            = { link = "Cursor" },
		CursorIM                           = { link = "Cursor" },
		-- TermCursor                         = {},
		ColorColumn                        = { bg = p.guide },
		CursorColumn                       = { link = "ColorColumn" },
		CursorLine                         = { bg = p.guide },
		CursorLineNr                       = { bg = p.zdepth_1, fg = p.text_4, bold = true },
		LineNr                             = { bg = p.zdepth_1, fg = p.text__1 },
		SignColumn                         = { bg = p.zdepth_1, fg = p.text__2 },
		FoldColumn                         = { bg = p.zdepth_1, fg = p.text__2 },
		QuickFixLine                       = { link = "PmenuSel" },
		qfFileName                         = { fg = p.text__3 },
		qfSeparator1                       = { fg = p.accent__2 },
		qfSeparator2                       = { link = "qfSeparator1" },

		------------------------------------------------------------------------ text
		Title                              = { fg = p.text_1, bold = true },
		Underlined                         = { fg = p.url, underline = true },
		Bold                               = { bold = true },
		Italic                             = { italic = true },
		Conceal                            = { fg = p.text__2 },
		NonText                            = { fg = p.text__3, bold = true },
		SpecialKey                         = { bg = p.text__4, fg = p.text },
		Special                            = { fg = p.special },
		helpSpecial                        = { link = "Special" },
		MatchParen                         = { bg = p.text__4, bold = true },
		Folded                             = { bg = p.text__4, fg = p.text_2 },
		Directory                          = { link = "Normal" },

		------------------------------------------------------------------------ coding
		String                             = { fg = p.literal_string },
		Number                             = { fg = p.literal_number },
		Boolean                            = { fg = p.literal_bool },
		Identifier                         = { link = "Normal" },
		Constant                           = { fg = p.constant, bold = true },
		Function                           = { fg = p.func },
		Type                               = { bg = "none", fg = p.text_3 },
		PreProc                            = { fg = p.metakeyword },
		Keyword                            = { fg = p.keyword },
		Statement                          = { link = "Keyword" },
		Delimiter                          = { link = "Keyword" },
		Operator                           = { link = "Keyword" },
		Comment                            = { bg = "none", fg = p.text__1, italic = true },
		SpecialComment                     = { bg = "none", fg = p.text__1, italic = true },
		Todo                               = { bg = "none", fg = p.hint, bold = true },
		Error                              = { fg = p.error, undercurl = true },
		ErrorMsg                           = { fg = p.error },
		WarningMsg                         = { fg = p.warn },

		------------------------------------------------------------------------ diff
		Added                              = { bg = p.added__2, },
		Changed                            = { bg = p.changed__2, },
		Removed                            = { bg = p.deleted__2, },
		DiffAdd                            = { bg = p.added__2 },
		DiffChange                         = { bg = p.changed__2 },
		DiffText                           = { bg = p.changed__2 },
		DiffDelete                         = { bg = p.deleted__2 },

		------------------------------------------------------------------------ signs & diagnostics
		DiagnosticOk                       = {},
		DiagnosticError                    = {},
		DiagnosticWarn                     = {},
		DiagnosticInfo                     = {},
		DiagnosticHint                     = {},
		DiagnosticSignError                = { bg = p.zdepth_1, fg = p.error },
		DiagnosticSignWarn                 = { bg = p.zdepth_1, fg = p.warn },
		DiagnosticSignInfo                 = { bg = p.zdepth_1, fg = p.info },
		DiagnosticSignHint                 = { bg = p.zdepth_1, fg = p.hint },
		DiagnosticUnderlineError           = { sp = p.error, undercurl = true },
		DiagnosticUnderlineWarn            = { sp = p.warn, undercurl = true },
		DiagnosticUnderlineInfo            = { sp = p.info, undercurl = true },
		DiagnosticUnderlineHint            = { sp = p.hint, undercurl = true },
		DebugSignBreakpoint                = { bg = p.zdepth_1, fg = p.error },
		DebugSignStopped                   = { bg = p.zdepth_1, fg = p.ok },
		DebugSignBreakpointCondition       = { bg = p.zdepth_1, fg = p.warn },
		DebugSignBreakpointRejected        = { bg = p.zdepth_1, fg = p.error },
		DebugSignBreakpointLog             = { bg = p.zdepth_1, fg = p.info },
		GitSignsAdd                        = { bg = p.zdepth_1, fg = p.added },
		GitSignsChange                     = { bg = p.zdepth_1, fg = p.changed },
		GitSignsDelete                     = { bg = p.zdepth_1, fg = p.deleted },
		GitSignsAddNr                      = { bg = p.added__2 },
		GitSignsChangeNr                   = { bg = p.changed__2 },
		GitSignsDeleteNr                   = { bg = p.deleted__2 },
		GitSignsAddInline                  = { bg = p.added__2 },
		GitSignsChangeInline               = { bg = p.changed__2 },
		GitSignsDeleteInline               = { bg = p.deleted__2 },

		------------------------------------------------------------------------ PLUGINS

		------------------------------------------------------------------------ Lsp
		LspInfoBorder                      = { link = "FloatBorder" },

		------------------------------------------------------------------------ cmp
		CmpItemMenu                        = { fg = p.text },
		CmpItemAbbr                        = { fg = p.text },
		CmpItemAbbrMatch                   = { fg = p.text, bold = true },
		CmpItemAbbrDeprecated              = { link = "DiagnosticDeprecated" },
		CmpItemKind                        = { fg = p.text },
		CmpItemKindFunction                = { link = "Function" },
		CmpItemKindMethod                  = { link = "Function" },
		CmpItemKindConstructor             = { link = "Function" },
		CmpItemKindVariable                = { link = "@variable" },
		CmpItemKindField                   = { link = "@variable.member" },
		CmpItemKindProperty                = { link = "@variable.member" },
		CmpItemKindClass                   = { link = "Type" },
		CmpItemKindInterface               = { link = "Type" },
		CmpItemKindModule                  = { link = "Type" },
		CmpItemKindEnum                    = { link = "Type" },
		CmpItemKindEnumMember              = { link = "Constant" },
		CmpItemKindConstant                = { link = "Constant" },
		CmpItemKindStruct                  = { link = "Type" },

		------------------------------------------------------------------------ blink
		BlinkCmpMenu                       = { fg = p.text },
		BlinkCmpLabelDeprecated            = { link = "DiagnosticDeprecated" },
		BlinkCmpKindFunction               = { link = "Function" },
		BlinkCmpKindMethod                 = { link = "Function" },
		BlinkCmpKindConstructor            = { link = "Function" },
		BlinkCmpKindVariable               = { link = "@variable" },
		BlinkCmpKindField                  = { link = "@variable.member" },
		BlinkCmpKindProperty               = { link = "@variable.member" },
		BlinkCmpKindClass                  = { link = "Type" },
		BlinkCmpKindInterface              = { link = "Type" },
		BlinkCmpKindModule                 = { link = "Type" },
		BlinkCmpKindEnum                   = { link = "Type" },
		BlinkCmpKindEnumMember             = { link = "Constant" },
		BlinkCmpKindConstant               = { link = "Constant" },
		BlinkCmpKindStruct                 = { link = "Type" },

		------------------------------------------------------------------------ Telescope
		TelescopeMatching                  = { underdotted = true, sp = p.accent },

		------------------------------------------------------------------------ Telescope
		SnacksPickerPrompt                 = { fg = p.accent },
		SnacksPickerMatch                  = { underdotted = true, sp = p.accent },
		SnacksPickerSelected               = { fg = p.accent },

		------------------------------------------------------------------------ Lazy
		LazyH1                             = { link = "TabLineSel" },
		LazyButton                         = { link = "TabLine" },
		LazyButtonActive                   = { link = "TabLineSel" },
		LazyProgressDone                   = { fg = p.accent },
		LazyProgressTodo                   = { fg = p.accent__3 },
		LazySpecial                        = { link = "Special" },

		------------------------------------------------------------------------ Mason
		MasonHighlightBlockBold            = { link = "TabLineSel" },
		MasonMutedBlock                    = { link = "TabLine" },
		MasonHighlight                     = { fg = p.accent },

		------------------------------------------------------------------------ DapUI
		DapUINormal                        = { bg = p.zdepth_1 },
		DapUINormalNC                      = { bg = p.zdepth_1 },
		DapUIPlayPause                     = { bg = p.zdepth_1, fg = p.ok },
		DapUIStop                          = { bg = p.zdepth_1, fg = p.error },
		DapUIRestart                       = { bg = p.zdepth_1, fg = p.hint },
		DapUIStepOver                      = { bg = p.zdepth_1, fg = p.hint },
		DapUIStepInto                      = { bg = p.zdepth_1, fg = p.hint },
		DapUIStepBack                      = { bg = p.zdepth_1, fg = p.hint },
		DapUIStepOut                       = { bg = p.zdepth_1, fg = p.hint },
		DapUIPlayPauseNC                   = { link = "DapUIPlayPause" },
		DapUIStopNC                        = { link = "DapUIStop" },
		DapUIRestartNC                     = { link = "DapUIRestart" },
		DapUIStepOverNC                    = { link = "DapUIStepOver" },
		DapUIStepIntoNC                    = { link = "DapUIStepInto" },
		DapUIStepBackNC                    = { link = "DapUIStepBack" },
		DapUIStepOutNC                     = { link = "DapUIStepOut" },
		DapUIType                          = { link = "Type" },
		DapUILineNumber                    = { link = "ColorLine" },
		DapUIWatchesValue                  = { fg = p.text },
		DapUIWatchesError                  = { fg = p.error },
		DapUIWatchesEmpty                  = { fg = p.hint },
		DapUIModifiedValue                 = { bg = p.changed, fg = p.text__4, bold = true },
		DapUIScope                         = { fg = p.text, bold = true },
		DapUISource                        = { fg = p.text },
		DapUIDecoration                    = { fg = p.text, bold = true },
		DapUIBreakpointsPath               = { fg = p.text, bold = true },
		DapUIBreakpointsCurrentLine        = { fg = p.text, bold = true },
		DapUIBreakpointsDisabledLine       = { fg = p.disabled },
		DapUIBreakpointsInfo               = { fg = p.text, bold = true },
		DapUIFloatBorder                   = { fg = p.text },
		DapUIThread                        = { fg = p.text, bold = true },
		DapUIStoppedThread                 = { fg = p.warn },
		DapUIUnavailable                   = { bg = p.zdepth_1, fg = p.disabled },
		DapUIUnavailableNC                 = { link = "DapUIUnavailable" },

		------------------------------------------------------------------------ NvimTree
		NvimTreeFolderIcon                 = {},
		NvimTreeIndentMarker               = { link = "NonText" },
		NvimTreeCursorLine                 = { bg = p.accent__3 },
		NvimTreeOpenedHl                   = { bold = true },
		NvimTreeModifiedFileHL             = { italic = true },
		NvimTreeModifiedFolder             = { link = "NvimTreeModifiedFileHL" },
		NvimTreeSymlink                    = { link = "NvimTreeNormal" },
		NvimTreeCopiedHL                   = { bg = p.accent__2, underline = true },
		NvimTreeCutHL                      = { bg = p.accent__2, strikethrough = true },
		NvimTreeGitFileNewHL               = { fg = p.warn },
		NvimTreeGitFolderNewHL             = { link = "NvimTreeGitFileNewHL" },
		NvimTreeGitFileIgnoredHL           = { fg = p.disabled },
		NvimTreeGitFileChangedHL           = { fg = p.changed },
		NvimTreeGitDirtyIcon               = { fg = p.changed },
		NvimTreeGitRenamedIcon             = { fg = p.changed },
		NvimTreeGitDeletedHl               = { fg = p.deleted },
		NvimTreeGitDeletedIcon             = { fg = p.deleted },
		NvimTreeGitFileStagedHL            = { fg = p.added },
		NvimTreeGitStagedIcon              = { fg = p.added },
		NvimTreeDiagnosticHintIcon         = { fg = p.hint },
		NvimTreeDiagnosticInfoIcon         = { fg = p.info },
		NvimTreeDiagnosticWarnIcon         = { fg = p.warn },
		NvimTreeDiagnosticErrorIcon        = { fg = p.error },
		NvimTreeDiagnosticHintFileHL       = {},
		NvimTreeDiagnosticInfoFileHL       = {},
		NvimTreeDiagnosticWarnFileHL       = {},
		NvimTreeDiagnosticErrorFileHL      = {},
		NvimTreeWindowPicker               = { bg = p.accent__1, bold = true },

		------------------------------------------------------------------------ NeoTree
		NeoTreeNormal                      = { bg = p.zdepth_1, fg = p.text },
		NeoTreeCursorLine                  = { bg = p.accent__3 },
		NeoTreeTabInactive                 = { link = "TabLine" },
		NeoTreeTabActive                   = { link = "TabLineSel" },
		NeoTreeTabSeparatorInactive        = { bg = p.zdepth_0, fg = p.zdepth_0 },
		NeoTreeTabSeparatorActive          = { bg = p.zdepth_1, fg = p.zdepth_1 },
		NeoTreeTitleBar                    = { link = "WinBar" },

		------------------------------------------------------------------------ Scrollbar
		ScrollbarHandle                    = { bg = p.accent__3 },
		ScrollbarError                     = { fg = p.error },
		ScrollbarWarn                      = { fg = p.warn },
		ScrollbarInfo                      = { fg = p.info },
		ScrollbarHint                      = { fg = p.hint },
		ScrollbarErrorHandle               = { bg = p.accent__3, fg = p.error },
		ScrollbarWarnHandle                = { bg = p.accent__3, fg = p.warn },
		ScrollbarInfoHandle                = { bg = p.accent__3, fg = p.info },
		ScrollbarHintHandle                = { bg = p.accent__3, fg = p.hint },
		ScrollbarMiscHandle                = { bg = p.accent__3, fg = "#9876AA" },
		ScrollbarSearchHandle              = { bg = p.accent__3, fg = p.ok },

		------------------------------------------------------------------------ Noice
		NoiceCursor                        = { bg = p.accent },
		NoiceMini                          = { bg = p.zdepth_2 },

		------------------------------------------------------------------------ Multicursor
		MultiCursorCursor                  = { bg = p.accent, fg = "black", underdotted = true, sp = p.accent__3 },
		MultiCursorVisual                  = { link = "Visual" },
		MultiCursorDisabledCursor          = { bg = p.accent__2, underdotted = true, sp = p.accent__3 },
		MultiCursorDisabledVisual          = { link = "Visual" },

		------------------------------------------------------------------------ Undotree
		UndotreeNode                       = { fg = p.accent },
		UndotreeBranch                     = { fg = p.accent__2 },

		------------------------------------------------------------------------ Treesitter
		TSCurrentScope                     = { bg = p.guide },

		------------------------------------------------------------------------ TREESITTER GROUPS
		["@comment.todo"]                  = { link = "Todo" },
		["@comment.error"]                 = { fg = p.error, bold = true },
		["@comment.note"]                  = { fg = p.note, bold = true },
		["@comment.warning"]               = { fg = p.warn, bold = true },
		["@comment.documentation"]         = { link = "SpecialComment" },
		["@boolean"]                       = { link = "Boolean" },
		["@character.printf"]              = { link = "Keyword" },
		["@string.special.url"]            = { link = "Underlined" },
		["@type.qualifier"]                = { link = "Keyword" },
		["@type.builtin"]                  = { link = "Type" },
		["@attribute"]                     = { link = "PreProc" },
		["@markup.heading"]                = { link = "Title" },
		["@markup.strong"]                 = { fg = p.text, bold = true },
		["@markup.italic"]                 = { fg = p.text, italic = true },
		["@markup.strikethrough"]          = { fg = p.text, strikethrough = true },
		["@markup.raw"]                    = { link = "markdownCode" },
		["@markup.raw.delimiter"]          = { link = "markdownCodeDelimiter" },
		["@markup.list"]                   = { link = "Keyword" },
		["@markup.quote"]                  = { link = "markdownBlockquote" },
		["@markup.link"]                   = { link = "Underlined" },
		["@markup.link.label"]             = { link = "String" },
		["@tag.attribute"]                 = { fg = p.keyword_1 },
		["@punctuation"]                   = { link = "Keyword" },
		["@punctuation.delimiter"]         = { link = "@punctuation" },
		["@punctuation.bracket"]           = { link = "@punctuation" },
		["@punctuation.special"]           = { link = "@punctuation" },
		["@operator"]                      = { link = "Operator" },
		["@variable"]                      = { link = "Normal" },
		["@variable.member"]               = { fg = p.member },
		["@variable.builtin"]              = { link = "Keyword" },
		["@module.builtin"]                = { link = "Keyword" },
		["@keyword.directive"]             = { link = "PreProc" },
		["@keyword.import"]                = { link = "Keyword" },

		------------------------------------------------------------------------ SEMANTIC GROUPS
		["@lsp.typemod.property.readonly"] = { link = "Constant" },
		["@lsp.typemod.variable.readonly"] = { link = "Constant" },
		["@lsp.typemod.property"]          = { fg = p.member },
		["@lsp.typemod.annotation"]        = { link = "PreProc" },
		-- ["@lsp.typemod.property.public"]    = { fg = p.member },
		-- ["@lsp.typemod.property.protected"] = { fg = p.member },
		-- ["@lsp.typemod.property.private"]   = { fg = p.member },

		------------------------------------------------------------------------ LANGUAGES

		------------------------------------------------------------------------ markdown
		markdownCode                       = { bg = p.code_bg },
		markdownCodeBlock                  = { link = "markdownCode" },
		markdownCodeDelimiter              = { link = "Delimiter" },
		markdownBlockquote                 = { bg = p.code_bg },
		markdownHeadingDelimiter           = { link = "Title" },
		markdownHeadingRule                = { link = "Title" },
		markdownRule                       = { link = "Keyword" },

		------------------------------------------------------------------------ latex
		["@module.latex"]                  = { link = "Statement" },
		["@markup.environment.latex"]      = { link = "Statement" },

		------------------------------------------------------------------------ xml
		xmlTag                             = { link = "Keyword" },
		xmlTagName                         = { link = "Keyword" },
		xmlAttrib                          = { link = "@tag.attribute" },
		xmlEqual                           = { link = "Keyword" },

		------------------------------------------------------------------------ json
		["@property.json"]                 = { link = "@variable.member" },

		------------------------------------------------------------------------ jsonc
		["@property.jsonc"]                = { link = "@variable.member" },

		------------------------------------------------------------------------ html
		htmlTag                            = { link = "xmlTag" },
		htmlEndTag                         = { link = "htmlTag" },
		htmlArg                            = { link = "xmlAttrib" },
		["@string.special.url.html"]       = { link = "String" },

		------------------------------------------------------------------------ css
		cssUrl                             = { link = "String" },
		cssTagName                         = { link = "Keyword" },
		cssClassName                       = { link = "Type" },
		cssPseudoClassId                   = { link = "PreProc" },
		cssSelectorOp                      = { link = "@punctuation" },
		cssClassNameDot                    = { link = "@punctuation" },
		cssDeprecated                      = { link = "DiagnosticDeprecated" },
		["@type.tag.css"]                  = { link = "cssTagName" },
		["@property.class.css"]            = { link = "Type" },

		------------------------------------------------------------------------ c
		cCharacter                         = { link = "String" },
		cDataStructure                     = { link = "Type" },
		cDataStructureKeyword              = { link = "Keyword" },
		cTypedef                           = { link = "Statement" },
		cFunction                          = { link = "Function" },
		cConstant                          = { link = "PreProc" },
		["@constant.c"]                    = { link = "cConstant" },
		["@keyword.directive.c"]           = { link = "PreProc" },
		["@keyword.directive.define.c"]    = { link = "@keyword.directive.c" },
		["@keyword.import.c"]              = { link = "@keyword.directive.c" },

		------------------------------------------------------------------------ rust
		rustSelf                           = { link = "Keyword" },
		["@keyword.import.rust"]           = { link = "Keyword" },
		["@lsp.type.decorator.rust"]       = { link = "PreProc" },

		------------------------------------------------------------------------ makefile
		makeCommands                       = { link = "Function" },

		------------------------------------------------------------------------ java
		javaExternal                       = { link = "Keyword" },
		javaClassDecl                      = { link = "Keyword" },
		javaStorageClass                   = { link = "Keyword" },
		javaDocComment                     = { link = "SpecialComment" },
		javaDocTag                         = { link = "Keyword" },
		javaDocParam                       = { link = "Keyword" },
		javaParen                          = { link = "@punctuation" },
		javaParen1                         = { link = "javaParen" },
		javaCommentTitle                   = { link = "javaDocComment" },
		javaCommentStar                    = { link = "javaDocComment" },

		------------------------------------------------------------------------ lua
		luaTable                           = { link = "Keyword" },
		luaTableBlock                      = { link = "Constant" },
		luaFunction                        = { link = "Statement" },
		luaConstant                        = { link = "@constant.builtin" },
		["@variable.member.lua"]           = { link = "@lsp.type.variable" },
		["@lsp.type.variable.lua"]         = { link = "@lsp.type.variable" },
		["@constructor.lua"]               = { link = "@punctuation" },

		------------------------------------------------------------------------ shell
		shQuote                            = { link = "String" },
		shDeref                            = { link = "Identifier" },
		shDerefSimple                      = { link = "Keyword" },
		shArithRegion                      = { link = "Keyword" },
		shCmdSubRegion                     = { link = "Keyword" },
		["@variable.bash"]                 = { link = "@variable" },

		------------------------------------------------------------------------ ini
		dosiniHeader                       = { link = "Type" },
		dosiniLabel                        = { link = "@variable.member" },
		["@property.ini"]                  = { link = "dosiniLabel" },

		------------------------------------------------------------------------ gitcommit
		gitcommitSummary                   = { link = "Title" },
		gitcommitHeader                    = { link = "Title" },
		gitcommitSelectedType              = { link = "Keyword" },
		gitcommitSelectedArrow             = { link = "Keyword" },
		gitcommitDiscardedType             = { link = "Keyword" },
		gitcommitSelectedFile              = { link = "Underlined" },
		gitcommitUntrackedFile             = { link = "Underlined" },
		gitcommitDiscardedFile             = { link = "Underlined" },

		------------------------------------------------------------------------ treesitter-test
		["@punctuation.delimiter.test"]    = { link = "NonText" },


		["@string.textblock"] = { bg = p.literal_string__4 },

	}
	return groups
end

return M
