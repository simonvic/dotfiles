vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local opt = vim.opt
local glyphs = require("simonvic.glyphs")
local signs = require("simonvic.signs")

local M = {}

-------------------------------------------------------------------------------- BEHAVIOUR
opt.wrap = false
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "cursor"
opt.scrolloff = 8
opt.completeopt = "menuone,noselect,fuzzy,nosort"
opt.wildmode="longest,longest:full,list:full"
opt.backspace = "indent,eol,start,nostop"
-- opt.messageopt = "history:500"
opt.undofile = true
opt.autocomplete = false

-------------------------------------------------------------------------------- CASE
opt.ignorecase = true
opt.smartcase = true
opt.wildignorecase = true
opt.infercase = true

-------------------------------------------------------------------------------- INDENTATION
opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.expandtab = false
opt.copyindent = true
opt.preserveindent = true

-------------------------------------------------------------------------------- APPEARANCE
opt.colorcolumn = "80"
opt.shortmess:append("c")
opt.cursorline = true
opt.cursorcolumn = false
opt.termguicolors = true
opt.winborder = "rounded"
opt.pumborder = "rounded"
opt.showcmdloc = "statusline"

opt.list = false
opt.listchars = glyphs.listchars
opt.fillchars = glyphs.fillchars

-------------------------------------------------------------------------------- STATUSCOLUMN (gutter)
opt.statuscolumn = ""
	.. "%C"                                      -- folds
	.. "%{%&number?' %{v:lnum}':''%}"            -- line number
	.. "%="                                      -- spacing
	.. "%{%&relativenumber?' %2.2{v:relnum} ':''%}" -- relative line number
	.. "%s"                                      -- signs
	.. " "                                       -- spacing

-------------------------------------------------------------------------------- NUMBERS
opt.number = true
opt.relativenumber = true

-------------------------------------------------------------------------------- SIGNS
opt.signcolumn = "auto:9"
for name, sign in pairs(signs.diagnostic) do
	vim.fn.sign_define(name, sign)
end

-------------------------------------------------------------------------------- FOLDS
opt.foldcolumn = "auto:9"
opt.foldtext = ""
opt.foldlevel = 69
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.api.nvim_create_autocmd('LspAttach', {
-- 	callback = function(args)
-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
-- 		if client:supports_method('textDocument/foldingRange') then
-- 			vim.notify("lsp client supports foldingRange")
-- 			local win = vim.api.nvim_get_current_win()
-- 			vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
-- 		end
-- 	end,
-- })


-------------------------------------------------------------------------------- CURSOR SHAPE
opt.guicursor = {
	"a:blinkon100",  -- all
	"n:block",       -- normal
	"sm:block",      -- showmatch in insert mode
	"i:ver25",       -- insert
	"c:ver25",       -- command line normal
	"ci:ver25",      -- command line insert
	"t:ver25",       -- terminal insert mode
	"v:block",       -- visual
	"ve:block",      -- command line insert
	"r:hor50",       -- replace
	"cr:hor50",      -- command line replace
	"o:hor50-blinkon0", --  operator pending
}

-------------------------------------------------------------------------------- RESTORE CURSOR ON EXIT
vim.api.nvim_create_augroup("resetCursor", { clear = true })
vim.api.nvim_create_autocmd("VimLeave", {
	group = "resetCursor",
	command = "set guicursor=a:ver25"
})

-------------------------------------------------------------------------------- TITLE
opt.title = true
-- opt.titlestring = ""
-- 	.. "nvim "
-- 	.. "%t"
-- 	.. " (%f)"

-------------------------------------------------------------------------------- TABLINE
opt.showtabline = 1
function BuildTabLine()
	local s = ""
	for i = 1, vim.fn.tabpagenr("$"), 1 do
		if i == vim.fn.tabpagenr() then
			s = s .. "%#TabLineSel#"
		else
			s = s .. "%#TabLine#"
		end
		s = s .. "%" .. i .. "T  %{" .. i .. "}  %" .. i .. "X" .. glyphs.tabline.close .. " "
	end
	s = s .. "%#TabLineFill#%T"
	return s
end

opt.tabline = "%!v:lua.BuildTabLine()"

-------------------------------------------------------------------------------- WINDOW LINE
opt.winbar = ""
	.. "%=" -- padding
	.. "%h" -- help flag
	.. "%m" -- modified flag
	.. "%r" -- readonly flag
	.. "%f" -- file (relative to cwd)
	.. "%=" -- padding

-------------------------------------------------------------------------------- COMMAND LINE
opt.cmdheight = 1

-------------------------------------------------------------------------------- STATUS LINE
opt.laststatus = 3

local modes_aliases = {
	["n"]   = "NORMAL",
	["no"]  = "NORMAL...",
	["nov"] = "NORMAL... (v)",
	["noV"] = "NORMAL... (V)",
	["no"] = "NORMAL... (^V)",
	["niI"] = "NORMAL (INSERT)",
	["niR"] = "NORMAL (REPLACE)",
	["niV"] = "NORMAL (VISUAL)",
	["v"]   = "VISUAL",
	["V"]   = "VISUAL LINE",
	[""]   = "VISUAL BLOCK",
	["s"]   = "SELECT",
	["S"]   = "SELECT LINE",
	[""]   = "SELECT BLOCK",
	["i"]   = "INSERT",
	["ic"]  = "INSERT COMPLETITION",
	["ix"]  = "INSERT (x)",
	["R"]   = "REPLACE",
	["Rc"]  = "REPLACE COMPLETITION",
	["Rv"]  = "REPLACE VIRTUAL",
	["Rx"]  = "REPLACE (x)",
	["c"]   = "COMMAND",
	["cv"]  = "COMMAND (v)",
	["ce"]  = "COMMAND (r)",
	["r"]   = "PROMPT",
	["rm"]  = "PROMPT (m)",
	["r?"]  = "PROMPT (?)",
	["!"]   = "SHELL",
	["t"]   = "TERM INSERT",
	["nt"]  = "TERM NORMAL",
	["ntT"] = "TERM (NORMAL)",
}

local function build_status_line_mode()
	local mode = vim.api.nvim_get_mode().mode
	return string.format("[ %s ]", modes_aliases[mode] or mode, mode)
end


local function build_status_line_diagnostics()
	local clients = vim.lsp.get_clients()
	if #clients == 0 then
		return ""
	end
	local output = glyphs.statusline.separator
	for _, lsp in pairs(clients) do
		output = output .. string.format(" %s", lsp.name)
	end
	local diag = vim.diagnostic
	output = output .. string.format(
		"  %s  %s  %s  %s",
		"%#DiagnosticSignError#" .. glyphs.diagnostics.error .. "%* " .. #diag.get(0, { severity = diag.severity.ERROR }),
		"%#DiagnosticSignWarn#" .. glyphs.diagnostics.warn .. "%* " .. #diag.get(0, { severity = diag.severity.WARN }),
		"%#DiagnosticSignInfo#" .. glyphs.diagnostics.info .. "%* " .. #diag.get(0, { severity = diag.severity.INFO }),
		"%#DiagnosticSignHint#" .. glyphs.diagnostics.hint .. "%* " .. #diag.get(0, { severity = diag.severity.HINT }))
	return output;
end

local function build_status_line_git_branch()
	local branch = vim.g.gitsigns_head
	if branch then
		return glyphs.statusline.separator .. " " .. branch
	end
	return ""
end

function BuildStatusLine()
	return ""
		.. " " .. build_status_line_mode()                             -- mode
		.. " [%S]"                                                     -- command
		.. "%w"                                                        -- preview
		.. "%q"                                                        -- quickfix/location list
		.. "%="                                                        -- filling
		.. " %c:%l"                                                    -- column:line
		.. glyphs.statusline.separator .. " %{&ff}"                    -- file format
		.. glyphs.statusline.separator .. " %{''.(&fenc!=''?&fenc:&enc).''}" -- encoding
		.. glyphs.statusline.separator .. " %Y"                        -- file type
		.. build_status_line_diagnostics()                             -- diagnostics
		.. build_status_line_git_branch()                              -- git branch
		.. " "                                                         -- Some padding
end

opt.statusline = "%!luaeval('BuildStatusLine()')"


-------------------------------------------------------------------------------- DIAGNOSTICS
vim.diagnostic.config({
	underline = true,
	virtual_text = false,
	virtual_lines = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "", -- signs.diagnostic.DiagnosticSignError.text,
			[vim.diagnostic.severity.WARN]  = "", -- signs.diagnostic.DiagnosticSignWarn.text,
			[vim.diagnostic.severity.INFO]  = "", -- signs.diagnostic.DiagnosticSignInfo.text,
			[vim.diagnostic.severity.HINT]  = "", -- signs.diagnostic.DiagnosticSignHint.text,
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "", -- signs.diagnostic.DiagnosticSignError.texthl,
			[vim.diagnostic.severity.WARN]  = "", -- signs.diagnostic.DiagnosticSignWarn.texthl,
			[vim.diagnostic.severity.INFO]  = "", -- signs.diagnostic.DiagnosticSignInfo.texthl,
			[vim.diagnostic.severity.HINT]  = "", -- signs.diagnostic.DiagnosticSignHint.texthl,
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = signs.diagnostic.DiagnosticSignError.numhl,
			[vim.diagnostic.severity.WARN]  = signs.diagnostic.DiagnosticSignWarn.numhl,
			[vim.diagnostic.severity.INFO]  = signs.diagnostic.DiagnosticSignInfo.numhl,
			[vim.diagnostic.severity.HINT]  = signs.diagnostic.DiagnosticSignHint.numhl,
		},
	},
	severity_sort = false,
	float = {
		header = "",
		prefix = glyphs.diagnostics.prefix
	},
	jump = {
		float = false,
		wrap = false
	}
})

-------------------------------------------------------------------------------- TREESITTER
-- Enable treesitter for all available filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(args.match)
		if lang and vim.treesitter.language.add(lang) then
			vim.treesitter.start(args.buf, lang)
			-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		end
	end,
})

return M
