vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", {})
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", {})

-- vim.api.nvim_set_keymap("n", "J", "mzJ`z",{})
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", {})
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", {})
vim.api.nvim_set_keymap("n", "N", "Nzzzv", {})
vim.api.nvim_set_keymap("n", "n", "nzzzv", {})

vim.api.nvim_set_keymap("x", "<leader>p", [["_dP]], {})

vim.api.nvim_set_keymap("n", "<leader>y", [["+y]], {})
vim.api.nvim_set_keymap("v", "<leader>y", [["+y]], {})
vim.api.nvim_set_keymap("n", "<leader>Y", [["+Y]], {})

vim.api.nvim_set_keymap("v", "<leader>d", [["_d]], {})
vim.api.nvim_set_keymap("n", "<leader>d", [["_d]], {})

vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", {})

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.keymap.set("n", "<C-Up>", ":resize +4<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -4<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -4<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +4<cr>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-i>", "<C-a>", {})
vim.keymap.set("n", "<leader>cap", ":lua CopyAbsolutePath()<CR>", { noremap = true, silent = true })

function CopyAbsolutePath()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("Copied path to clipboard: " .. path)
end
