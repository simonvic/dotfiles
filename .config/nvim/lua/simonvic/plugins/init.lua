local M = {}

M.plugins = {
	---------------------------------------------------------------------------
	--                                                      LIBS / DEPENDENCIES
	{ "nvim-lua/plenary.nvim" },
	{ "kyazdani42/nvim-web-devicons" },
	{ "nvim-neotest/nvim-nio" },
	---------------------------------------------------------------------------
	--                                                                  UI / UX
	{ "rcarriga/nvim-notify",                        config = require("simonvic.plugins.configs.notify") },
	{ "nvim-telescope/telescope.nvim",               config = require("simonvic.plugins.configs.nvim-telescope") },
	{ "stevearc/dressing.nvim",                      config = require("simonvic.plugins.configs.dressing") },
	{ "akinsho/toggleterm.nvim",                     config = require("simonvic.plugins.configs.toggleterm") },
	-- { "folke/snacks.nvim",                           config = require("simonvic.plugins.configs.snacks") },
	-- { "nvim-neo-tree/neo-tree.nvim",                 config = require("simonvic.plugins.configs.neo-tree"),        branch = "v3.x", },
	-- { "s1n7ax/nvim-window-picker",                   config = require("simonvic.plugins.configs.window-picker") },
	{ "nvim-tree/nvim-tree.lua",                     config = require("simonvic.plugins.configs.nvimtree") },
	{ "petertriho/nvim-scrollbar",                   config = require("simonvic.plugins.configs.scrollbar") },
	-- { "onsails/lspkind.nvim" },
	-- { "folke/which-key.nvim",                        config = require("simonvic.plugins.configs.whichkey") },
	---------------------------------------------------------------------------
	--                                                                   CODING
	{ "nvim-treesitter/nvim-treesitter",             config = require("simonvic.plugins.configs.treesitter") },
	{ "nvim-treesitter/nvim-treesitter-textobjects", config = require("simonvic.plugins.configs.ts-textobjects") },
	{ "nvim-treesitter/nvim-treesitter-context",     config = require("simonvic.plugins.configs.ts-context") },
	{ "nvim-treesitter/nvim-treesitter-refactor",    config = require("simonvic.plugins.configs.ts-refactor") },
	{ "windwp/nvim-ts-autotag",                      config = require("simonvic.plugins.configs.ts-autotag") },
	-- { "hrsh7th/cmp-nvim-lsp" },
	-- { "hrsh7th/cmp-nvim-lsp-signature-help" },
	-- { "hrsh7th/cmp-buffer" },
	-- { "hrsh7th/cmp-path" },
	-- { "hrsh7th/nvim-cmp",                            config = require("simonvic.plugins.configs.cmp") },
	{ "rafamadriz/friendly-snippets" },
	{ "Saghen/blink.cmp",                            config = require("simonvic.plugins.configs.blinkcmp"),       version = "*" },
	{ "neovim/nvim-lspconfig",                       config = require("simonvic.plugins.configs.lsp_config") },
	{ "mason-org/mason.nvim",                        config = require("simonvic.plugins.configs.mason") },
	{ "mason-org/mason-lspconfig.nvim",              config = require("simonvic.plugins.configs.mason-lspconfig") },
	{ "stevearc/aerial.nvim",                        config = require("simonvic.plugins.configs.aerial") },
	{ "windwp/nvim-autopairs",                       config = require("simonvic.plugins.configs.autopairs") },
	{ "jake-stewart/multicursor.nvim",               config = require("simonvic.plugins.configs.multicursor") },
	{ "lewis6991/gitsigns.nvim",                     config = require("simonvic.plugins.configs.gitsigns") },
	{ "echasnovski/mini.align",                      config = require("simonvic.plugins.configs.align"),          version = false },
	{ "catgoose/nvim-colorizer.lua",                 config = require("simonvic.plugins.configs.colorizer") },
	{ "max397574/colortils.nvim",                    config = require("simonvic.plugins.configs.colortils") },
	{ "kylechui/nvim-surround",                      config = require("simonvic.plugins.configs.surround") },
	---------------------------------------------------------------------------
	--                                                          ADVANCED CODING
	{ "mfussenegger/nvim-dap",                       config = require("simonvic.plugins.configs.debugger") },
	{ "rcarriga/nvim-dap-ui",                        config = require("simonvic.plugins.configs.dap_ui") },
	{ "mfussenegger/nvim-jdtls" },
	{ "mrcjkb/rustaceanvim" },
	{ "lervag/vimtex",                               config = require("simonvic.plugins.configs.vimtex") },
	{ "iamcco/markdown-preview.nvim",                config = require("simonvic.plugins.configs.mdpreview") },
	---------------------------------------------------------------------------
	--                                                             COLORSCHEMES
	{ "doums/darcula" },
	{ "gruvbox-community/gruvbox" },
}

function M.setup()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.uv.fs_stat(lazypath) then
		vim.fn.system({
			"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
	require("lazy").setup(M.plugins, {
		ui = {
			border = "rounded",
			icons = {
				list = {
					""
				}
			}
		},
		install = {
			colorscheme = { "simonvic" }
		},
		checker = {
			enabled = true,
			notify = true,
			frequency = 3600,
		},
	})
end

return M
