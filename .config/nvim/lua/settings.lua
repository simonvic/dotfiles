--------------------------------------------------------------------------------
--                                                                    BEHAVIOUR
local vim = vim
local opt = vim.opt
M = {}
opt.wrap = false
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 8

--                                                                         CASE
opt.ignorecase = true
opt.smartcase = true
opt.wildignorecase = true
opt.infercase = true

--                                                                  INDENTATION
opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.expandtab = false
opt.copyindent = true
opt.preserveindent = true

opt.completeopt = "menuone,noinsert,noselect"
opt.backspace = "indent,eol,start,nostop"

-- @TODO vim.opt.undofile

-- fold
opt.foldlevel = 69
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

--------------------------------------------------------------------------------
--                                                                    APPEARANCE
opt.colorcolumn = "80"
opt.shortmess:append("c")
opt.cursorline = true
opt.termguicolors = true

opt.list = false
opt.listchars = {
	eol = '¬',
	tab = '> ',
	trail = '⋅',
	extends = '>',
	precedes = '<',
	space = '⋅',
}

opt.fillchars = {
	fold = ' ',
	foldopen = '',
	foldclose = '',
	eob = ' ',
}

--                                                                        FOLDS
opt.foldcolumn = "auto:9"
function BuildFoldText()
	local fn = vim.fn
	local v = vim.v
	local onetab = fn.strpart("          ", 0, opt.tabstop:get())
	local startline = fn.substitute(fn.getline(v.foldstart), "\t", onetab, "g")
	local endline = fn.substitute(fn.getline(v.foldend), "\t", "", "g")
	return startline .. "…" .. endline
end

opt.foldtext = "v:lua.BuildFoldText()"

-- vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
-- 	group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
-- 	callback = function()
-- 	  vim.opt.foldmethod     = 'expr'
-- 	  vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
-- 	end
--   })


-- @TODO formatoptions

--                                                                 CURSOR SHAPE
opt.guicursor = {
	"a:blinkon100", -- all
	"n:block", -- normal
	"sm:block", -- showmatch in insert mode
	"i:ver25", -- insert
	"c:ver25", -- command line normal
	"ci:ver25", -- command line insert
	"v:block", -- visual
	"ve:block", -- command line insert
	"r:hor50", -- replace
	"cr:hor50", -- command line replace
	"o:hor50-blinkon0", --  operator pending
}

--                                                       RESTORE CURSOR ON EXIT
vim.api.nvim_create_augroup("resetCursor", { clear = true })
vim.api.nvim_create_autocmd("VimLeave", {
	group = "resetCursor",
	command = "set guicursor=a:ver25"
})

--                                                                      NUMBERS
opt.number = true

--                                                                        SIGNS
opt.signcolumn = "auto:9"

--                                                                      TABLINE
opt.showtabline = 1
function BuildTabLine()
	local s = ""
	for i = 1, vim.fn.tabpagenr("$"), 1 do
		if i == vim.fn.tabpagenr() then
			s = s .. "%#TabLineSel#"
		else
			s = s .. "%#TabLine#"
		end
		s = s .. "%" .. i .. "T  %{" .. i .. "}  %" .. i .. "X "
	end
	s = s .. "%#TabLineFill#%T"
	return s
end

vim.opt.tabline = "%!v:lua.BuildTabLine()"

--                                                                  WINDOW LINE
opt.winbar = "%=%h%m%r%f%="

--                                                                 COMMAND LINE
opt.cmdheight = 1

--                                                                  STATUS LINE
opt.laststatus = 3

opt.statusline = ""
opt.statusline:append("[%{luaeval('vim.api.nvim_get_mode().mode')}]") --  @TODO change this     mode
opt.statusline:append("%w%q") --
opt.statusline:append("%=") --                                 filling
opt.statusline:append("%c:%l") --                              column:line
opt.statusline:append(" | %{&ff}") --                          file format
opt.statusline:append(" | %{''.(&fenc!=''?&fenc:&enc).''}") -- encoding
opt.statusline:append(" | %Y") --                              file type
opt.statusline:append(" | %{get(b:,'gitsigns_head')}") --      git branch
opt.statusline:append("  ") --                                 Some padding


--                                                                  DIAGNOSTICS
vim.diagnostic.config({
	virtual_text = false,
	float = {
		border = "rounded",
		header = "",
		prefix = "• "
	}
})
local lsp = vim.lsp
local handlers = lsp.handlers
local winopts = { border = "rounded" }
handlers["textDocument/signatureHelp"] = lsp.with(handlers.signature_help, winopts)
handlers["textDocument/hover"] = lsp.with(handlers.hover, winopts)
handlers["textDocument/codeAction"] = lsp.with(handlers.code_action, winopts)
-- ["textDocument/rename"]
-- ["workspace/applyEdit"]
-- ["language/status"]
--

return M
