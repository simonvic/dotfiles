M = {}
M.plugins = {
	---------------------------------------------------------------------------
	--                                                      LIBS / DEPENDENCIES
	{ "nvim-lua/plenary.nvim" },
	{ "BurntSushi/ripgrep" },
	{ "sharkdp/fd" },
	{ "MunifTanjim/nui.nvim" },
	{ "kyazdani42/nvim-web-devicons" },
	---------------------------------------------------------------------------
	--                                                                  UI / UX
	{ "rcarriga/nvim-notify",              config = require("plugins.configs.notify") },
	{ "nvim-telescope/telescope.nvim",     config = require("plugins.configs.nvim-telescope") },
	{ "stevearc/dressing.nvim",            config = require("plugins.configs.dressing") },
	{ "akinsho/toggleterm.nvim",           config = require("plugins.configs.toggleterm") },
	{ "nvim-neo-tree/neo-tree.nvim",       config = require("plugins.configs.neo-tree"),        branch = "v3.x", },
	{ "petertriho/nvim-scrollbar",         config = require("plugins.configs.scrollbar") },
	{ "s1n7ax/nvim-window-picker",         config = require("plugins.configs.window-picker") },
	---------------------------------------------------------------------------
	--                                                                   CODING
	{ "nvim-treesitter/nvim-treesitter",   config = require("plugins.configs.treesitter"),      run = ":TSUpdate", },
	{ "windwp/nvim-ts-autotag",            after = "nvim-treesitter" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "L3MON4D3/LuaSnip",                  config = require("plugins.configs.snippets") },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/nvim-cmp",                  config = require("plugins.configs.cmp") },
	{ "williamboman/mason.nvim",           config = require("plugins.configs.mason") },
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason-lspconfig.nvim", config = require("plugins.configs.mason-lspconfig"), after = "nvim-lspconfig", },
	{ "terrortylor/nvim-comment",          config = require("plugins.configs.comment") },
	{ "stevearc/aerial.nvim",              config = require("plugins.configs.aerial") },
	{ "windwp/nvim-autopairs",             config = require("plugins.configs.autopairs") },
	{ "lewis6991/gitsigns.nvim",           config = require("plugins.configs.gitsigns") },
	{ "NvChad/nvim-colorizer.lua",         config = require("plugins.configs.colorizer") },
	{ "max397574/colortils.nvim",          config = require("plugins.configs.colortils") },
	---------------------------------------------------------------------------
	--                                                          ADVANCED CODING
	{ "mfussenegger/nvim-dap",             config = require("plugins.configs.debugger") },
	{ "rcarriga/nvim-dap-ui",              config = require("plugins.configs.dapui"),           after = "nvim-dap", },
	{ "mfussenegger/nvim-jdtls" },
	{ "simrat39/rust-tools.nvim" },
	{ "lervag/vimtex",                     config = require("plugins.configs.vimtex") },
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
	require("lazy").setup(M.plugins)
end

return M
