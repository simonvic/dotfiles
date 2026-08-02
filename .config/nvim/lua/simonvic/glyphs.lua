local M = {}

---General-purpose UI glyphs
---@class simonvic.glyphs.UI
M.ui = {
	unselected = "",
	selected   = "󰄲",
	disabled   = "",
	enabled    = "",
	collapsed  = "",
	expanded   = "",
	caret      = ">",
	here       = "",
	color_pill = "██",
	filter     = "󰈲",
	play       = "",
	pause      = "",
	stop       = "",
}

M.listchars = {
	eol      = "¬",
	tab      = "> ", -- NOTE: tab char 2nd char is repeated
	trail    = "⋅",
	extends  = ">",
	precedes = "<",
	space    = "⋅",
}

M.fillchars = {
	-- stl       = " ",
	-- stlnc     = " ",
	-- wbr       = " ",
	fold      = " ",
	foldopen  = "",
	-- foldsep   = "│",
	foldinner = "║",
	foldclose = "",
	eob       = " ",
}

---Glyphs for the tabline
---@class simonvic.glyphs.Tabline
M.tabline = {
	close = ""
}

---Glyphs for the statusline
---@class simonvic.glyphs.Statusline
M.statusline = {
	separator = " |"
}

---Diagnostic related glyphs
---@class simonvic.glyphs.Diagnostics
M.diagnostics = {
	prefix = "• ",
	hint   = "",
	info   = "",
	warn   = "",
	error  = "",
}

---LSP symbols kinds related glyphs
---See: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.18/specification/#symbolKind
---@class simonvic.glyphs.Diagnostics
M.symbols = {
	Text          = "󰉿",
	Method        = "󰆧",
	Function      = "󰊕",
	Constructor   = "",
	Field         = "",
	Variable      = "󰀫",
	Class         = "",
	Interface     = "",
	Module        = "",
	Property      = "",
	Unit          = "󰑭",
	Value         = "󰎠",
	Enum          = "",
	Keyword       = "",
	Snippet       = "",
	Color         = "",
	File          = "",
	Reference     = "󰈇",
	Folder        = "󰉋",
	EnumMember    = "",
	Constant      = "󰏿",
	Struct        = "󰙅",
	Event         = "",
	Operator      = "",
	TypeParameter = "",
}

---Debugger related glyphs
---@class simonvic.glyphs.Dap
M.dap = {
	stopped              = M.ui.here,
	breakpoint           = "",
	breakpoint_condition = "",
	breakpoint_rejected  = "",
	log_point            = "",
	current_frame        = M.ui.here,
	controls             = {
		play       = M.ui.play,
		pause      = M.ui.pause,
		stop       = M.ui.stop,
		disconnect = "",
		run_last   = "",
		step_back  = "",
		step_into  = "",
		step_out   = "",
		step_over  = "",
	}
}

---VCS (git) related glyphs
---@class simonvic.glyphs.Vcs
M.vcs = {
	commit    = "",
	ignored   = "",
	staged    = "",
	added     = "",
	modified  = "",
	removed   = "",
	renamed   = "",
	unmerged  = "-",
	untracked = "-",
	conflict  = "",
}

---Filesystem related glyphs
---@class simonvic.glyphs.Fs
M.fs = {
	default        = "",
	unsaved        = "󰏫",
	hidden         = " ",
	symlink_arrow  = "󱦰",
	dir            = {
		collapsed    = M.ui.collapsed,
		expanded     = M.ui.expanded,
		default      = "",
		open         = "",
		empty        = "",
		empty_open   = "",
		symlink      = "",
		symlink_open = "",
	},
	indent_markers = {
		edge   = "│",
		item   = "├",
		bottom = "└",
	},
}

---Glyphs for the statuscolumn
---@class simonvic.glyphs.Statuscolumn
M.statuscolumn = {
	vcs = {
		addded          = "┃",
		changed         = "┃",
		deleted         = "▁",
		topdeleted      = "▔",
		changed_deleted = "┣",
		untracked       = "┆",
	},
}

---Plugins specific glyphs
---@class simonvic.glyphs.Plugins
M.plugins = {
	mason = {
		package_installed   = "✓",
		package_uninstalled = "·",
		package_pending     = "󰇚",
	},
	neotree = {
		sources = {
			filesystem = "󰉓",
			buffers    = "󰈢",
			git_status = "󰊢",
		},
	},
	whichkey = {
		breadcrumb = " ",
		separator = "➜",
		group = "+",
		ellipsis = "…",
		keys = {
			Up = " ",
			Down = " ",
			Left = " ",
			Right = " ",
			C = "󰘴 ",
			M = "󰘵 ",
			D = "󰘳 ",
			S = "󰘶 ",
			CR = "󰌑 ",
			Esc = "󱊷 ",
			ScrollWheelDown = "󱕐 ",
			ScrollWheelUp = "󱕑 ",
			NL = "󰌑 ",
			BS = "󰁮",
			Space = "󱁐 ",
			Tab = "󰌒 ",
			F1 = "󱊫",
			F2 = "󱊬",
			F3 = "󱊭",
			F4 = "󱊮",
			F5 = "󱊯",
			F6 = "󱊰",
			F7 = "󱊱",
			F8 = "󱊲",
			F9 = "󱊳",
			F10 = "󱊴",
			F11 = "󱊵",
			F12 = "󱊶",
		},
	}
}

return M
