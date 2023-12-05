vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv",{})
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv",{})

-- vim.api.nvim_set_keymap("n", "J", "mzJ`z",{})
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz",{})
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz",{})
vim.api.nvim_set_keymap("n", "N", "Nzzzv",{})
vim.api.nvim_set_keymap("n", "n", "nzzzv",{})

vim.api.nvim_set_keymap("x", "<leader>p", [["_dP]],{})

vim.api.nvim_set_keymap("n", "<leader>y", [["+y]],{})
vim.api.nvim_set_keymap("v", "<leader>y", [["+y]],{})
vim.api.nvim_set_keymap("n", "<leader>Y", [["+Y]],{})

vim.api.nvim_set_keymap("v", "<leader>d", [["_d]],{})
vim.api.nvim_set_keymap("n", "<leader>d", [["_d]],{})

vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>",{})

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")
