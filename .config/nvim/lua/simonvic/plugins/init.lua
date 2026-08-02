local M = {}

---@class simonvic.PluginSpec.Data
---@field on_setup? function Callback to configure the plugin. Invoked after all plugins are installed

---@class simonvic.PluginSpec: vim.pack.Spec
---@field data? simonvic.PluginSpec.Data Plugin data

---@type simonvic.PluginSpec[]
M.plugins = {
	---------------------------------------------------------------------------
	--                                                      LIBS / DEPENDENCIES
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/kyazdani42/nvim-web-devicons" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	---------------------------------------------------------------------------
	--                                                                  UI / UX
	{ src = "https://github.com/rcarriga/nvim-notify",                        data = { on_setup = require("simonvic.plugins.configs.notify") } },
	{ src = "https://github.com/nvim-telescope/telescope.nvim",               data = { on_setup = require("simonvic.plugins.configs.nvim-telescope") } },
	{ src = "https://github.com/stevearc/dressing.nvim",                      data = { on_setup = require("simonvic.plugins.configs.dressing") } },
	{ src = "https://github.com/akinsho/toggleterm.nvim",                     data = { on_setup = require("simonvic.plugins.configs.toggleterm") } },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua",                     data = { on_setup = require("simonvic.plugins.configs.nvimtree") } },
	{ src = "https://github.com/petertriho/nvim-scrollbar",                   data = { on_setup = require("simonvic.plugins.configs.scrollbar") } },
	-- { src = "https://github.com/onsails/lspkind.nvim" },
	-- { src = "https://github.com/folke/which-key.nvim",                        data = { on_setup = require("simonvic.plugins.configs.whichkey") } },
	{ src = "https://github.com/mbbill/undotree",                             data = { on_setup = require("simonvic.plugins.configs.undotree") } },
	---------------------------------------------------------------------------
	--                                                                   CODING
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter",             data = { on_setup = require("simonvic.plugins.configs.treesitter") } },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", data = { on_setup = require("simonvic.plugins.configs.ts-textobjects") } },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context",     data = { on_setup = require("simonvic.plugins.configs.ts-context") } },
	{ src = "https://github.com/windwp/nvim-ts-autotag",                      data = { on_setup = require("simonvic.plugins.configs.ts-autotag") } },
	-- { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	-- { src = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help" },
	-- { src = "https://github.com/hrsh7th/cmp-buffer" },
	-- { src = "https://github.com/hrsh7th/cmp-path" },
	-- { src = "https://github.com/hrsh7th/nvim-cmp",                            data = { on_setup = require("simonvic.plugins.configs.cmp") } },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/Saghen/blink.cmp",                            data = { on_setup = require("simonvic.plugins.configs.blinkcmp") },       version = vim.version.range("v1.*") },
	{ src = "https://github.com/neovim/nvim-lspconfig", },
	{ src = "https://github.com/mason-org/mason.nvim",                        data = { on_setup = require("simonvic.plugins.configs.mason") } },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim",              data = { on_setup = require("simonvic.plugins.configs.mason-lspconfig") } },
	{ src = "https://github.com/stevearc/aerial.nvim",                        data = { on_setup = require("simonvic.plugins.configs.aerial") } },
	{ src = "https://github.com/windwp/nvim-autopairs",                       data = { on_setup = require("simonvic.plugins.configs.autopairs") } },
	{ src = "https://github.com/jake-stewart/multicursor.nvim",               data = { on_setup = require("simonvic.plugins.configs.multicursor") } },
	{ src = "https://github.com/lewis6991/gitsigns.nvim",                     data = { on_setup = require("simonvic.plugins.configs.gitsigns") } },
	{ src = "https://github.com/nvim-mini/mini.align",                        data = { on_setup = require("simonvic.plugins.configs.align") } },
	{ src = "https://github.com/catgoose/nvim-colorizer.lua",                 data = { on_setup = require("simonvic.plugins.configs.colorizer") } },
	-- { src = "https://github.com/max397574/colortils.nvim",                    data = { on_setup = require("simonvic.plugins.configs.colortils") } },
	{ src = "https://github.com/uga-rosa/ccc.nvim",                           data = { on_setup = require("simonvic.plugins.configs.ccc") } },
	{ src = "https://github.com/kylechui/nvim-surround",                      data = { on_setup = require("simonvic.plugins.configs.surround") } },
	---------------------------------------------------------------------------
	--                                                          ADVANCED CODING
	{ src = "https://github.com/mfussenegger/nvim-dap",                       data = { on_setup = require("simonvic.plugins.configs.debugger") } },
	{ src = "https://github.com/rcarriga/nvim-dap-ui",                        data = { on_setup = require("simonvic.plugins.configs.dap_ui") } },
	-- { src = "https://github.com/igorlfs/nvim-dap-view",                       data = { on_setup = require("simonvic.plugins.configs.dap_view") } },
	{ src = "https://github.com/mfussenegger/nvim-jdtls",                     data = { on_setup = require("simonvic.plugins.configs.nvim_jdtls") } },
	{ src = "https://github.com/mrcjkb/rustaceanvim",                         data = { on_setup = require("simonvic.plugins.configs.rustacean") } },
	{ src = "https://github.com/lervag/vimtex",                               data = { on_setup = require("simonvic.plugins.configs.vimtex") } },
	{ src = "https://github.com/iamcco/markdown-preview.nvim",                data = { on_setup = require("simonvic.plugins.configs.mdpreview") } },
	{ src = "https://github.com/tree-sitter-grammars/tree-sitter-test",       data = { on_setup = require("simonvic.plugins.configs.tstest") } },
	---------------------------------------------------------------------------
	--                                                             COLORSCHEMES
	{ src = "https://github.com/doums/darcula" },
	{ src = "https://github.com/gruvbox-community/gruvbox" },
}

function M.setup()
	-- vim.api.nvim_create_autocmd({"PackChangedPre"}, {
	-- 	group = vim.api.nvim_create_augroup("simonvic.pack", {}),
	-- 	callback = function(ev)
	-- 		vim.print(ev.data.spec.name .. ":" .. vim.inspect(ev))
	-- 	end
	-- })
	-- vim.api.nvim_create_autocmd({"PackChanged"}, {
	-- 	group = vim.api.nvim_create_augroup("simonvic.pack", {clear = false}),
	-- 	callback = function(ev)
	-- 		vim.print(ev.data.spec.name .. ":" .. vim.inspect(ev))
	-- 	end
	-- })
	vim.pack.add(M.plugins)
	for _, plugin in pairs(M.plugins) do
		if plugin.data and plugin.data.on_setup then
			if not pcall(plugin.data.on_setup) then
				vim.notify("Error executing on_setup() for plugin " .. vim.inspect(plugin), vim.log.levels.ERROR)
			end
		end
	end
	-- vim.iter(vim.pack.get()):each(function(plugin)
	-- 	if plugin.spec.data and plugin.spec.data.on_setup then
	-- 		plugin.spec.data.on_setup()
	-- 	end
	-- end)
end

function M.setup_with_lazy()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.uv.fs_stat(lazypath) then
		vim.fn.system({
			"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)

	---Convert vim.pack plugin specs to lazy plugin specs
	---@param specs (string|vim.pack.Spec)[]
	---@return LazyPluginBase[]
	local function to_lazy_specs(specs)
		local lazy_specs = {}
		for _, plugin in pairs(specs) do
			local lazy_spec ---@type LazyPluginBase
			if type(plugin) == "string" then
				lazy_spec = { plugin }
			else
				lazy_spec = { plugin.src }
				if plugin.data and plugin.data.on_setup then
					lazy_spec.config = plugin.data.on_setup
				end
				if plugin.version then
					if type(plugin.version) == "string" then
						lazy_spec.version = plugin.version
					else
						lazy_spec.version = ">=" .. tostring(plugin.version.from)
					end
				end
			end
			table.insert(lazy_specs, lazy_spec)
		end
		return lazy_specs
	end

	require("lazy").setup(to_lazy_specs(M.plugins), {
		ui = {
			border = vim.o.winborder,
			icons = {
				list = {
					""
				}
			}
		},
		install = {
			colorscheme = { "simonvic_ruby" }
		},
		rocks = {
			enabled = false
		},
		checker = {
			enabled = true,
			notify = true,
			frequency = 3600,
		},
	})
end

return M
