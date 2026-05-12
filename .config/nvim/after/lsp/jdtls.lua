---@type vim.lsp.Config
return {
	cmd = {
		"jdtls",
		-- "/usr/bin/jdtls",
		-- vim.fn.stdpath("data") .. "/mason/bin/jdtls",

		"-configuration", vim.fn.expand("~/.cache/jdtls/config"),
	},
	root_markers = {
		{ -- for multi module projects
			'gradlew',
			'build.gradle',
			'build.gradle.kts',
			'mvnw',
			'.git',
		},
		{ -- for mono projects
			'build.xml',
			'pom.xml',
			'settings.gradle',
			'settings.gradle.kts',
		},
	},
	---@type lspconfig.settings.jdtls
	settings = {
		redhat = {
			telemetry = {
				enabled = false
			}
		},
		java = {
			codeGeneration = {
				generateComments = true,
				hashCodeEquals = {
					useJava7Objects = true,
				},
				useBlocks = false
			},
			implementationCodeLens = "all",
			referencesCodeLens = { enabled = true },
			inlayHints = {
				formatParameters = {
					enabled = true,
				},
				parameterNames = {
					enabled = "all",
				},
				parameterTypes = {
					enabled = true,
				}
			},
			signatureHelp = {
				enabled = true,
				description = {
					enabled = true
				}
			},
			format = {
				settings = {
					url = "~/.config/jdtls/settings.xml"
				},
				comments = { enabled = false },
			},
			sources = {
				organizeImports = {
					starThreshold = 5,
					staticStarThreshold = 3
				}
			}
		}
	}
}
