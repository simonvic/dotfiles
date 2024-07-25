M = {
	diagnostic = {
		DiagnosticSignError = { text = "", texthl = "DiagnosticSignError" },
		DiagnosticSignWarn  = { text = "", texthl = "DiagnosticSignWarn" },
		DiagnosticSignInfo  = { text = "", texthl = "DiagnosticSignInfo" },
		DiagnosticSignHint  = { text = "", texthl = "DiagnosticSignHint" },
	},
	plugins = {
		dap = {
			DapBreakpoint          = { text = "", texthl = "DebugSignBreakpoint" },
			DapStopped             = { text = "", texthl = "DebugSignStopped" },
			DapBreakpointCondition = { text = "", texthl = "DebugSignBreakpointCondition" },
			DapBreakpointRejected  = { text = "", texthl = "DebugSignBreakpointRejected" },
			DapLogPoint            = { text = "", texthl = "DebugSignBreakpointLog" },
		},
		dapui = {
			expanded = "",
			collapsed = "",
			current_frame = ""
		},
		gitsigns = {
			add          = { text = '┃' },
			change       = { text = '┃' },
			delete       = { text = '▁' },
			topdelete    = { text = '▔' },
			changedelete = { text = "┣" },
			untracked    = { text = '┆' },
		},
		mason = {
			package_installed = "✓",
			package_uninstalled = "·",
			package_pending = "↻",
		},
		neotree = {
			sources = {
				filesystem = "󰉓",
				buffers = "󰈢",
				git_status = "󰊢",
			},
			indent_marker = "│",
			last_indent_marker = "└",
			expander_collapsed = "",
			expander_expanded = "",
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "",
				default = "",
			},
			modified = "+",
			git_status = {
				added     = "",
				modified  = "",
				deleted   = "",
				renamed   = "",
				untracked = "",
				ignored   = "",
				unstaged  = "", -- "",
				staged    = "",
				conflict  = "",
			}
		},
		aerial = {
			mid_item = "├ ",
			last_item = "└ ",
			nested_top = "│ ",
			whitespace = "  ",
		},
		cmp = {
			Text = "󰉿",
			Method = "󰆧",
			Function = "󰊕",
			Constructor = "",
			Field = "",
			Variable = "󰀫",
			Class = "",
			Interface = "",
			Module = "",
			Property = "",
			Unit = "󰑭",
			Value = "󰎠",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "󰈇",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "󰙅",
			Event = "",
			Operator = "",
			TypeParameter = "",
		},
		colorizer = {
			virtualtext = "██",
		}
	}
}

return M
