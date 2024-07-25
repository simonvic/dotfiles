return function()
	local snippet = require("luasnip") -- TODO: replace with vim.snippet
	local lspkind = require("lspkind")
	local cmp = require("cmp")
	cmp.setup({
		snippet = {
			expand = function(args)
				-- vim.snippet.expand(args.body)
				snippet.lsp_expand(args.body)
			end,
		},
		view = {
			entries = { name = "custom", selection_order = "near_cursor" },
			docs = {
				auto_open = false
			}
		},
		window = {
			completion = {
				border = "rounded",
				col_offset = -3,
			},
			documentation = {
				border = "rounded",
			},
		},
		experimental = {
			ghost_text = true
		},
		formatting = {
			fields = { "kind", "abbr", "menu", },
			format = lspkind.cmp_format({
				mode = "symbol",
				maxwidth = 50,
				ellipsis_char = '…',
				show_labelDetails = true,
				symbol_map = require("simonvic.signs").plugins.cmp,
				-- before = function(entry, vim_item)
				-- 	vim_item.menu = string.sub(vim_item.menu, 1, 20)
				-- 	return vim_item
				-- end
			})
		},
		sources = {
			{ group_index = 1, name = "nvim_lsp" },
			{ group_index = 1, name = "nvim_lsp_signature_help" },
			{ group_index = 1, name = "luasnip" },
			{ group_index = 2, name = "buffer" },
			{ group_index = 2, name = "path" },
		},
		-- TODO: cmp-git
		preselect = cmp.PreselectMode.None,
		completion = {
			autocomplete = false
		},
		mapping = {
			["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
			["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
			["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
			["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
			["<C-q>"] = function()
				if cmp.visible_docs() then
					cmp.close_docs()
				else
					cmp.open_docs()
				end
			end,
			["<ESC>"] = cmp.mapping.abort(),
			["<C-Space>"] = cmp.mapping(function()
				if cmp.visible() then
					cmp.select_next_item()
				else
					cmp.complete()
				end
			end, { "i", "c" }),
			["<CR>"] = cmp.mapping.confirm({ select = false }),
			["<Tab>"] = cmp.mapping(function(fallback)
				-- if vim.snippet.active({ direction = 1 }) then
				-- 	vim.snippet.jump(1)
				-- else
				-- 	fallback()
				-- end
				if snippet.in_snippet() and snippet.jumpable(1) then
					snippet.jump(1)
				else
					fallback()
				end
			end, { "i", "s", }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				-- if vim.snippet.active({direction = -1}) then
				-- 	vim.snippet.jump(-1)
				-- else
				-- 	fallback()
				-- end
				if snippet.in_snippet() and snippet.jumpable(-1) then
					snippet.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		},
	})
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end
