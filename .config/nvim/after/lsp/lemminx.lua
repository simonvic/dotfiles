---@type vim.lsp.Config
return {
	settings = {
		xml = {
			format = {
				enabled = true,
				maxLineWidth = 120,
				splitAttributes = "preserve",
				splitAttributesIndentSize = 1,
				spaceBeforeEmptyCloseTag = false,
				closingBracketNewLine = false,
				formatComments = false,
				joinCommentLine = false,
				joinContentLines = false,
				preservedNewlines = 1,
				preserveAttributeLineBreaks = true,
				preserveEmptyContent = true,
				emptyElements = "ignore",
			}
		}
	}
}
