local M = {}

---@alias Palette table<string, string>

---@alias Groups vim.api.keyset.highlight

---@class Colorscheme
---@field name string
---@field palette Palette
---@field groups Groups
---@field apply fun(colorscheme: Colorscheme)

---@class Overrides
---@field name? string
---@field palette? Palette
---@field groups? Groups|fun(palette:Palette):Groups

---Apply the given colorscheme (fallbacks to default one)
---@param colorscheme Colorscheme
function M.apply(colorscheme)
	vim.g.colors_name = colorscheme.name
	vim.o.termguicolors = true -- TODO: move this out
	for group, colors in pairs(colorscheme.groups) do
		vim.api.nvim_set_hl(0, group, colors)
	end
end

---@type Palette
M.palette = {
	accent_xxxdark = "#3F2727",
	accent_xxdark  = "#4C302F",
	accent_xdark   = "#88302B",
	accent_dark    = "#CC443D",
	accent         = "#F0544C",
	accent_light   = "#F6645D",
	accent_xlight  = "#EF9F9B",
	zdepth__4      = "none",
	zdepth__3      = "none",
	zdepth__2      = "none",
	zdepth__1      = "none",
	zdepth_0       = "none",
	zdepth_1       = "none",
	zdepth_2       = "none",
	zdepth_3       = "none",
	text_xxxdark   = "#505050",
	text_xxdark    = "#555555",
	text_xdark     = "#666666",
	text_dark      = "#808080",
	text           = "#CACACA",
	text_light     = "#DADADA",
	text_xxlight   = "#FAFAFA",
	text_xxxlight  = "#FFFFFF",
	disabled       = "#666666",

	special        = "#CC7832",
	constant       = "#9876AA",
	member         = "#9876AA",
	["function"]   = "#FFC66D",
	metakeyword    = "#BBB529",
	keyword        = "#CC7832",
	keyword_light  = "#DCA537",
	literal_string = "#6A8759",
	literal_bool   = "#8CB0FF",
	literal_number = "#6897BB",

	guide          = "#202020",
	code_bg        = "#404040",
	url            = "#6897BB",

	added          = "#2B5640",
	changed        = "#87663E",
	changed_xdark  = "#635b2b",
	deleted        = "#873E41",
	error          = "#E8312E",
	warn           = "#E87B2E",
	note           = "#D8E44C",
	info           = "#C9E9EF",
	hint           = "#CFD2D3",
	ok             = "#A9FF68",
}

---Build highlight groups
---@param palette Palette
---@return vim.api.keyset.highlight
function M.build_groups(palette)
	local p = palette
	local groups = {

		-- ["@comment.textblock"]             = { bg = "#222222" },
		["@string.textblock"]              = { bg = "#283422" },

		------------------------------------------------------------------------ GENERAL

		------------------------------------------------------------------------ ui
		Normal                             = { bg = p.zdepth_0, fg = p.text },
		NormalNC                           = {},
		NormalFloat                        = {},
		Visual                             = { bg = p.accent_xxdark },
		SnippetTabstop                     = { bg = p.accent_xxdark, italic = true },
		Search                             = { bg = p.accent_xxxdark },
		CurSearch                          = { bg = p.accent_xxxdark },
		IncSearch                          = { link = "Search" },
		Substitute                         = { link = "Search" },
		WinBar                             = { bg = p.zdepth_1, fg = p.text, bold = true, sp = "#333333" },
		WinBarNC                           = { link = "WinBar" },
		TabLine                            = { bg = p.zdepth_0 },
		TabLineSel                         = { bg = p.zdepth_1, underline = true, sp = p.accent_xdark },
		TabLineFill                        = { bg = p.zdepth__1 },
		StatusLine                         = { bg = p.zdepth_1 },
		MsgArea                            = { bg = p.zdepth_1, bold = true },
		MoreMsg                            = { bg = p.zdepth_1, bold = true },
		Question                           = { bg = p.zepth_1, bold = true },
		WinSeparator                       = { bg = p.zdepth_1, fg = p.text_xdark },
		VertSplit                          = { link = "WinSeparator" },
		FloatBorder                        = { link = "WinSeparator" },
		FloatTitle                         = { link = "Title" },
		Pmenu                              = { fg = p.text, bg = p.zdepth_1 },
		PmenuKind                          = { fg = p.text_dark },
		PmenuExtra                         = { fg = p.text_dark },
		PmenuSel                           = { bg = p.accent_xxdark },
		PmenuSbar                          = { bg = p.accent_xxxdark },
		PmenuThumb                         = { bg = p.accent_xdark },
		Cursor                             = { bg = p.zdepth0, fg = p.text_dark },
		lCursor                            = { link = "Cursor" },
		CursorIM                           = { link = "Cursor" },
		-- TermCursor                         = {},
		ColorColumn                        = { bg = p.guide },
		CursorColumn                       = { link = "ColorColumn" },
		CursorLine                         = {},
		CursorLineNr                       = { bg = p.zdepth_1, fg = p.text_xxxlight, bold = true },
		LineNr                             = { bg = p.zdepth_1, fg = p.text_dark },
		SignColumn                         = { bg = p.zdepth_1, fg = p.text_xdark },
		FoldColumn                         = { bg = p.zdepth_1, fg = p.text_xdark },
		QuickFixLine                       = { link = "PmenuSel" },
		qfFileName                         = { fg = p.text_xxdark },
		qfSeparator1                       = { fg = p.accent_xdark },
		qfSeparator2                       = { link = "qfSeparator1" },

		------------------------------------------------------------------------ text
		Title                              = { fg = p.text_light, bold = true },
		Underlined                         = { fg = p.url, underline = true },
		Bold                               = { bold = true },
		Italic                             = { italic = true },
		Conceal                            = { fg = p.text_xdark },
		NonText                            = { fg = p.text_xxdark, bold = true },
		SpecialKey                         = { bg = p.text_xxxdark, fg = p.text },
		Special                            = { fg = p.special },
		helpSpecial                        = { link = "Special" },
		MatchParen                         = { bg = p.text_xxxdark, bold = true },
		Folded                             = { bg = p.text_xxxdark, fg = p.text_xlight },
		Directory                          = { link = "Normal" },

		------------------------------------------------------------------------ coding
		String                             = { fg = p.literal_string },
		Number                             = { fg = p.literal_number },
		Boolean                            = { fg = p.literal_bool },
		Identifier                         = { link = "Normal" },
		Constant                           = { fg = p.constant, bold = true },
		Function                           = { fg = p["function"] },
		Type                               = { bg = "none", fg = p.text_xxlight },
		PreProc                            = { fg = p.metakeyword },
		Keyword                            = { fg = p.keyword },
		Statement                          = { link = "Keyword" },
		Delimiter                          = { link = "Keyword" },
		Operator                           = { link = "Keyword" },
		Comment                            = { bg = "none", fg = p.text_dark, italic = true },
		SpecialComment                     = { bg = "none", fg = p.text_dark, italic = true },
		Todo                               = { bg = "none", fg = p.hint, bold = true },
		Error                              = { fg = p.error, undercurl = true },
		ErrorMsg                           = { fg = p.error },
		WarningMsg                         = { fg = p.warn },

		------------------------------------------------------------------------ diff
		Added                              = { bg = p.added, },
		Changed                            = { bg = p.changed, },
		Removed                            = { bg = p.deleted, },
		DiffAdd                            = { link = "Added" },
		DiffChange                         = { bg = p.changed_xdark },
		DiffText                           = { link = "Changed" },
		DiffDelete                         = { link = "Removed" },

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
		GitSignsAddNr                      = {},
		GitSignsChangeNr                   = {},
		GitSignsDeleteNr                   = {},

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
		LazyProgressTodo                   = { fg = p.accent_xxdark },
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
		DapUIModifiedValue                 = { bg = p.changed, fg = p.text_xxxdark, bold = true },
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
		NvimTreeCursorLine                 = { bg = p.accent_xxdark },
		NvimTreeOpenedHl                   = { bold = true },
		NvimTreeModifiedFileHL             = { italic = true },
		NvimTreeModifiedFolder             = { link = "NvimTreeModifiedFileHL" },
		NvimTreeSymlink                    = { link = "NvimTreeNormal" },
		NvimTreeCopiedHL                   = { bg = p.accent_xdark, underline = true },
		NvimTreeCutHL                      = { bg = p.accent_xdark, strikethrough = true },
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
		NvimTreeWindowPicker               = { bg = p.accent_dark, bold = true },

		------------------------------------------------------------------------ NeoTree
		NeoTreeNormal                      = { bg = p.zdepth_1, fg = p.text },
		NeoTreeCursorLine                  = { bg = p.accent_xxdark },
		NeoTreeTabInactive                 = { link = "TabLine" },
		NeoTreeTabActive                   = { link = "TabLineSel" },
		NeoTreeTabSeparatorInactive        = { bg = p.zdepth_0, fg = p.zdepth_0 },
		NeoTreeTabSeparatorActive          = { bg = p.zdepth_1, fg = p.zdepth_1 },
		NeoTreeTitleBar                    = { link = "WinBar" },

		------------------------------------------------------------------------ Scrollbar
		ScrollbarHandle                    = { bg = p.accent_xxdark },
		ScrollbarError                     = { fg = p.error },
		ScrollbarWarn                      = { fg = p.warn },
		ScrollbarInfo                      = { fg = p.info },
		ScrollbarHint                      = { fg = p.hint },
		ScrollbarErrorHandle               = { bg = p.accent_xxdark, fg = p.error },
		ScrollbarWarnHandle                = { bg = p.accent_xxdark, fg = p.warn },
		ScrollbarInfoHandle                = { bg = p.accent_xxdark, fg = p.info },
		ScrollbarHintHandle                = { bg = p.accent_xxdark, fg = p.hint },
		ScrollbarMiscHandle                = { bg = p.accent_xxdark, fg = "#9876AA" },
		ScrollbarSearchHandle              = { bg = p.accent_xxdark, fg = p.ok },

		------------------------------------------------------------------------ Noice
		NoiceCursor                        = { bg = p.accent },
		NoiceMini                          = { bg = p.zdepth_2 },

		------------------------------------------------------------------------ Multicursor
		MultiCursorCursor                  = { bg = p.accent, fg = "black", underdotted = true, sp = p.accent_xxdark },
		MultiCursorVisual                  = { link = "Visual" },
		MultiCursorDisabledCursor          = { bg = p.accent_xdark, underdotted = true, sp = p.accent_xxdark },
		MultiCursorDisabledVisual          = { link = "Visual" },

		------------------------------------------------------------------------ Undotree
		UndotreeNode                      = { fg = p.accent },
		UndotreeBranch                    = { fg = p.accent_xdark },

		------------------------------------------------------------------------ Treesitter
		TSCurrentScope                     = { bg = "#202020" },

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
		["@tag.attribute"]                 = { fg = p.keyword_light },
		["@punctuation"]                   = { link = "Keyword" },
		["@punctuation.delimiter"]         = { link = "@punctuation" },
		["@punctuation.bracket"]           = { link = "@punctuation" },
		["@punctuation.special"]           = { link = "@punctuation" },
		["@operator"]                      = { link = "Operator" },
		["@variable"]                      = { link = "Normal" },
		["@variable.member"]               = { fg = p.member },
		["@variable.builtin"]              = { link = "Keyword" },
		["@module.builtin"]                = { link = "Keyword" },
		["@keyword.directive"]             = { link = "Keyword" },
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

	}
	return groups
end

---Build a colorscheme
---@param overrides? Overrides
---@return Colorscheme
function M.build_colorscheme(overrides)
	local name = overrides and overrides.name or "simonvic"
	local palette = M.palette
	local groups
	if overrides then
		palette = vim.tbl_deep_extend("force", palette, overrides and overrides.palette or {})
		groups = M.build_groups(palette)
		local groups_type = type(overrides.groups)
		if groups_type == "table" then
			groups = vim.tbl_deep_extend("force", groups, overrides.groups)
		elseif groups_type == "function" then
			groups = vim.tbl_deep_extend("force", groups, overrides.groups(palette))
		end
	else
		groups = M.build_groups(palette)
	end
	return {
		name = name,
		palette = palette,
		groups = groups,
		apply = M.apply
	}
end

return M
