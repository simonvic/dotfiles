local M = {}

M.listchars = {
	eol      = "¬",
	tab      = "> ", -- TODO: why a space?
	trail    = "⋅",
	extends  = ">",
	precedes = "<",
	space    = "⋅",
}

M.fillchars = {
	fold      = " ",
	foldopen  = "",
	foldclose = "",
	eob       = " ",
}

M.tabline = {
	close = ""
}

M.statusline = {
	separator = " |"
}

M.diagnostics = {
	prefix = "• ",
	hint   = "",
	info   = "",
	warn   = "",
	error  = "",
}

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
	TypeParameter = "",
}

M.dap = {
	stopped             = "",
	breakpoint          = "",
	breakpointCondition = "",
	breakpointRejected  = "",
	logPoint            = "",
	current_frame       = "",
}

M.vcs = {
	ignored   = "",
	added     = "",
	modified  = "",
	removed   = "",
	renamed   = "",
	unmerged  = "-",
	untracked = "-",
	conflict  = "",
}

M.fs = {
	default        = "",
	unsaved        = "󰏫",
	hidden         = " ",
	symlink_arrow  = "󱦰",
	dir            = {
		collapsed    = "",
		expanded     = "",
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
	colorizer = {
		virtualtext = "██",
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
