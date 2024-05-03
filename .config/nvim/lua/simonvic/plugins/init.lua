M = {}
M.plugins = {
	---------------------------------------------------------------------------
	--                                                      LIBS / DEPENDENCIES
	{ "nvim-lua/plenary.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{ "kyazdani42/nvim-web-devicons" },
	{ "nvim-neotest/nvim-nio" },
	---------------------------------------------------------------------------
	--                                                                  UI / UX
	{ "rcarriga/nvim-notify",              config = require("simonvic.plugins.configs.notify") },
	{ "nvim-telescope/telescope.nvim",     config = require("simonvic.plugins.configs.nvim-telescope") },
	{ "stevearc/dressing.nvim",            config = require("simonvic.plugins.configs.dressing") },
	{ "akinsho/toggleterm.nvim",           config = require("simonvic.plugins.configs.toggleterm") },
	{ "nvim-neo-tree/neo-tree.nvim",       config = require("simonvic.plugins.configs.neo-tree"),        branch = "v3.x", },
	{ "petertriho/nvim-scrollbar",         config = require("simonvic.plugins.configs.scrollbar") },
	{ "s1n7ax/nvim-window-picker",         config = require("simonvic.plugins.configs.window-picker") },
	---------------------------------------------------------------------------
	--                                                                   CODING
	{ "nvim-treesitter/nvim-treesitter",   config = require("simonvic.plugins.configs.treesitter"),      run = ":TSUpdate", },
	{ "nvim-treesitter/nvim-treesitter-textobjects", config = require("simonvic.plugins.configs.ts-textobjects") },
	{ "windwp/nvim-ts-autotag",            after = "nvim-treesitter" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "L3MON4D3/LuaSnip",                  config = require("simonvic.plugins.configs.snippets") },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/nvim-cmp",                  config = require("simonvic.plugins.configs.cmp") },
	{ "williamboman/mason.nvim",           config = require("simonvic.plugins.configs.mason") },
	{ "neovim/nvim-lspconfig",             config = require("simonvic.plugins.configs.lsp_config") },
	{ "williamboman/mason-lspconfig.nvim", config = require("simonvic.plugins.configs.mason-lspconfig"), after = "nvim-lspconfig", },
	{ "terrortylor/nvim-comment",          config = require("simonvic.plugins.configs.comment") },
	{ "stevearc/aerial.nvim",              config = require("simonvic.plugins.configs.aerial") },
	{ "windwp/nvim-autopairs",             config = require("simonvic.plugins.configs.autopairs") },
	{ "lewis6991/gitsigns.nvim",           config = require("simonvic.plugins.configs.gitsigns") },
	{ "echasnovski/mini.align",            config = require("simonvic.plugins.configs.align"),           version = false },
	{ "NvChad/nvim-colorizer.lua",         config = require("simonvic.plugins.configs.colorizer") },
	{ "max397574/colortils.nvim",          config = require("simonvic.plugins.configs.colortils") },
	{ "kylechui/nvim-surround",            config = require("simonvic.plugins.configs.surround") },
	---------------------------------------------------------------------------
	--                                                          ADVANCED CODING
	{ "mfussenegger/nvim-dap",             config = require("simonvic.plugins.configs.debugger") },
	{ "rcarriga/nvim-dap-ui",              config = require("simonvic.plugins.configs.dap_ui"),          after = "nvim-dap", },
	{ "mfussenegger/nvim-jdtls" },
	{ "mrcjkb/rustaceanvim" },
	{ "lervag/vimtex",                     config = require("simonvic.plugins.configs.vimtex") },
	{ "iamcco/markdown-preview.nvim",      confit = require("simonvic.plugins.configs.mdpreview") },
	---------------------------------------------------------------------------
	--                                                             COLORSCHEMES
	{ "doums/darcula" },
	{ "gruvbox-community/gruvbox" },
}

M.with_vimplug = function()
	vim.call("plug#begin")
	for _, plugin in ipairs(M.plugins) do
		if plugin[1] then
			local plug_args = {}
			if plugin.run then plug_args["do"] = plugin.run end
			if plugin.branch then plug_args["branch"] = plugin.branch end
			if plugin.tag then plug_args["tag"] = plugin.tag end
			if next(plug_args) then
				vim.fn["plug#"](plugin[1], plug_args)
			else
				vim.fn["plug#"](plugin[1])
			end
		end
	end
	vim.call("plug#end")
	for _, v in ipairs(M.plugins) do
		if v.config then
			v.config()
		end
	end
end

M.with_packer = function()
	table.insert(M.plugins, { "wbthomason/packer.nvim" })
	return require("packer").startup(M.plugins)
end

M.with_lazy = function()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
	require("lazy").setup(M.plugins, {
		ui = { border = "rounded", },
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
