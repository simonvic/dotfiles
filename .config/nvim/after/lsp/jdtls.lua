return {
	cmd = {
		"jdtls",
		-- "/usr/bin/jdtls",
		-- vim.fn.stdpath("data") .. "/mason/bin/jdtls",

		"-configuration", vim.fn.expand("~/.cache/jdtls/config"),
	},
	root_markers = {
		"pom.xml", "build.gradle", ".git", "build.gradle.kts", "build.xml",
		"settings.gradle", "settings.gradle.kts"
	},
	settings = {
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
				parameterNames = {
					enabled = "all",
				},
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
