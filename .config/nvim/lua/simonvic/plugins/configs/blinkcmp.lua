-- TODO: reverse order
return function()
	require("blink-cmp").setup({
		keymap = require("simonvic.keybindings").plugins.blink,

		snippets = {
			expand = function(snippet) vim.snippet.expand(snippet) end,
			active = function(filter) return vim.snippet.active(filter) end,
			jump = function(direction) vim.snippet.jump(direction) end,
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		completion = {

			trigger = {
				show_in_snippet = false,
				show_on_keyword = false,
				show_on_trigger_character = false,
			},

			list = {
				selection = {
					preselect = false,
					auto_insert = true
				},
			},

			accept = {
				auto_brackets = {
					enabled = true,
				},
			},

			menu = {
				auto_show = false,
				border = "rounded",
				max_height = 32,
				scrolloff = 8,
				scrollbar = false,
				draw = {
					padding = { 0, 1 }, -- padding for scrollbar
					gap = 1,
					columns = {
						{ "kind_icon" },
						{ "label", "label_description",  gap = 1},
						{ "source_name" },
					},
					treesitter = { "lsp" },
				},
			},

			documentation = {
				auto_show = false,
				window = {
					border = "rounded",
					max_height = 64,
					scrollbar = true,
				},
			},

			ghost_text = {
				enabled = true,
			},

		},

		-- Experimental signature help support
		signature = {
			enabled = true,
			window = {
				border = "rounded",
				treesitter_highlighting = true,
			},
			trigger = {
				enabled = false,
			}
		},

		cmdline = {
			enabled = false,
		},

		appearance = {
			kind_icons = require("simonvic.glyphs").symbols
		}

	})
end
