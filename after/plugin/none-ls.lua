local null_ls = require("null-ls")

local home = os.getenv("HOME")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.formatting.prettier,
		-- null_ls.builtins.formatting.phpcsfixer,
		-- null_ls.builtins.code_actions.eslint,
		-- null_ls.builtins.diagnostics.eslint_d,
		-- null_ls.builtins.formatting.clang_format,

		-- null_ls.builtins.diagnostics.checkstyle.with({
		--     extra_args = { '-c' , home .. "/work/checkstyle/checkstyle.xml" },
		-- }),
		-- null_ls.builtins.diagnostics.checkstyle.with({
		-- 	extra_args = { "-c", "/sun_checks.xml" },
		-- }),
		null_ls.builtins.formatting.google_java_format,
		-- null_ls.builtins.diagnostics.pmd.with({
		-- 	extra_args = {
		-- 		"--rulesets",
		-- 		"category/java/bestpractices.xml,category/jsp/bestpractices.xml",
		-- 		"--cache",
		-- 		home .. "/pmd-bin-6.55.0/cache/file.pmd",
		-- 		-- "--incremental",
		-- 	},
		-- 	diagnostics_postprocess = function(diagnostic)
		-- 		diagnostic.severity = diagnostic.message:find("really") and vim.diagnostic.severity["ERROR"]
		-- 			or vim.diagnostic.severity["WARN"]
		-- 	end,
		-- }),
		-- null_ls.builtins.diagnostics.chktex,
	},
})
