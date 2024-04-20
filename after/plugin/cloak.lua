require("cloak").setup({
	enabled = true,
	cloak_character = "*",
	highlight_group = "Comment",
	patterns = {
		{
			file_pattern = {
				"application.yml",
				"*properties*",
				".env*",
				"wrangler.toml",
				".dev.vars",
				"*secret*",
			},
			cloak_pattern = {
				-- Matches key-value pairs with =, :, or space around the value
				"=[^\n]+", -- Matches `KEY=VALUE` lines, cloaking everything after `=`
				": [^\n]+", -- Matches `KEY: VALUE` lines, cloaking everything after `: `
				'"[^"]+"', -- Matches `"VALUE"` including quotes
				"'[^']+'", -- Matches `'VALUE'` including single quotes
				":.+",
				"-.+",
			},
		},
	},
})
