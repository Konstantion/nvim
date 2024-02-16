-- vim.keymap.set("n", "<leader>ap", ":lua CopyAbsolutePathNETRW()<CR>", { noremap = true, silent = true })

function CopyAbsolutePathNETRW()
	-- Get the current word under the cursor
	local word = vim.fn.expand("<cfile>")
	-- Trim the word to remove any leading/trailing whitespace
	local trimmed_word = word:match("^%s*(.-)%s*$")
	-- Get the current working directory
	local cwd = vim.fn.getcwd()
	-- Concatenate the current working directory with the trimmed word to form the path
	local path = cwd .. "/" .. trimmed_word
	-- Set the "+ register (system clipboard) to the path
	vim.fn.setreg("+", path)
	-- Print a confirmation message
	print("Copied path to clipboard: " .. path)
end

